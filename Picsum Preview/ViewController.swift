//
//  ViewController.swift
//  Picsum Preview
//
//  Created by TrieuLD on 8/11/20.
//  Copyright © 2020 TrieuLD. All rights reserved.
//

import UIKit
import Moya
import ObjectMapper

class ViewController: UIViewController {
    
    var segmentControl: UISegmentedControl!
    
    var collectionView: UICollectionView!
    
    let compactCollectionViewLayout = PhotoCollectionViewLayout()
    let regularCollectionViewLayout = PhotoCollectionViewLayout()
    
    let refreshControl = UIRefreshControl()
    
    var viewModels: [PhotoViewModel] = []
    
    var isLoading = false
    var currentPage = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        isLoading = true
        self.loadData() {[weak self] success in
            self?.isLoading = false
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionView.frame = self.view.bounds
    }
    
    func loadData(more: Bool = false, completion: ((Bool) -> Void)? = nil) {
        
        let page = more ? currentPage : 0
        
        MoyaProvider<PicsumProvider>().request(.getPhotos(page: page + 1, limit: 100)) { event in
            switch event {
            case .success(let response):
                do {
                    if let json = try response.mapJSON() as? [[String: Any]] {
                        let photos = Mapper<PhotoItem>().mapArray(JSONArray: json)
                        
                        DispatchQueue.main.async { [weak self] in
                            self?.updateDataWithPhotos(photos, page: page, loadMore: more)
                            completion?(true)
                        }
                    }
                } catch {
                    completion?(false)
                }
                
                break
            case .failure( _):
                completion?(false)
                break
            }
        }
    }
    
    func updateDataWithPhotos(_ photos: [PhotoItem], page: Int, loadMore: Bool) {
        
        currentPage = page + 1
        
        let newViewModels = photos.map({ (photo) -> PhotoViewModel in
            return PhotoViewModel(item: photo)
        })
        
        if loadMore {
            self.viewModels.append(contentsOf: newViewModels)
        } else {
            self.viewModels = newViewModels
        }
        
        self.collectionView.reloadData()
    }

    
    func setupUI() {
        
        segmentControl = UISegmentedControl(items: ["Compact", "Regular"])
        segmentControl.sizeToFit()
        segmentControl.selectedSegmentIndex = 0
        segmentControl.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)], for: .normal)
        
        segmentControl.addTarget(self, action: #selector(segmentControllDidChangeValue(_:)), for: .valueChanged)
        
        self.navigationItem.titleView = segmentControl
        
        
        compactCollectionViewLayout.iPhoneCollumn = 2
        compactCollectionViewLayout.iPadCollumn = 3
        compactCollectionViewLayout.iPhoneLandCapseCollumn = 3
        compactCollectionViewLayout.iPadLandCapseCollumn = 5
        compactCollectionViewLayout.heightRatio = 1.5
        
        regularCollectionViewLayout.iPhoneCollumn = 1
        regularCollectionViewLayout.iPadCollumn = 2
        regularCollectionViewLayout.iPhoneLandCapseCollumn = 2
        regularCollectionViewLayout.iPadLandCapseCollumn = 2
        regularCollectionViewLayout.heightRatio = 0.5
           
        
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: compactCollectionViewLayout)
        collectionView.backgroundColor = .blue
        collectionView.contentInset = .init(top: UICommonValue.defaultSpacing, left: 0, bottom: 0, right: 0)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.register(MoreCell.self, forCellWithReuseIdentifier: "MoreCell")
        self.view.addSubview(collectionView)
        
        refreshControl.addTarget(self, action: #selector(didPullToRefresh(_:)), for: .valueChanged)
        collectionView.alwaysBounceVertical = true
        collectionView.refreshControl = refreshControl
    }
    
    @objc private func didPullToRefresh(_ sender: Any) {
        
        isLoading = true
        self.loadData(more: false) { [weak self] success in
            self?.isLoading = false
            self?.refreshControl.endRefreshing()
        }
    }
    
    @objc private func segmentControllDidChangeValue(_ sender: Any) {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            collectionView.setCollectionViewLayout(compactCollectionViewLayout, animated: true)
            break
        default:
            collectionView.setCollectionViewLayout(regularCollectionViewLayout, animated: true)
            break
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (indexPath.row == viewModels.count) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoreCell", for: indexPath)
            
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PhotoCell
        
        let viewModel = viewModels[indexPath.row]
        cell.layoutCellWithObject(viewModel)
        
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell: MoreCell = cell as? MoreCell {
            if (!cell.indicatorView.isAnimating) {
                cell.indicatorView.startAnimating()
            }
            
            if (!isLoading) {
                isLoading = true
                self.loadData(more: true) {[weak self] success in
                    self?.isLoading = false
                }
            }
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if let collectionViewLayout = collectionViewLayout as? PhotoCollectionViewLayout {
            
            if indexPath.row == viewModels.count {
                return collectionViewLayout.sizeForMoreItem(with: collectionView.bounds.size)
            }
            
            let viewModel = viewModels[indexPath.row]
            if (collectionViewLayout == compactCollectionViewLayout) {
                viewModel.cellLayout = .compact
            } else {
                viewModel.cellLayout = .regular
            }
            
            return collectionViewLayout.sizeForItem(with: collectionView.bounds.size)
        }
        return .zero
    }
}

