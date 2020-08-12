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
    
    var collectionView: UICollectionView!
    
    var compactCollectionViewLayout = PhotoCollectionViewLayout()
    var regularCollectionViewLayout = PhotoCollectionViewLayout()
    
    var viewModels: [PhotoViewModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        self.loadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionView.frame = self.view.bounds
    }
    
    func loadData() {
        MoyaProvider<PicsumProvider>().request(.getPhotos(page: 1, limit: 100)) { event in
            switch event {
            case .success(let response):
                do {
                    if let json = try response.mapJSON() as? [[String: Any]] {
                        let photos = Mapper<PhotoItem>().mapArray(JSONArray: json)
                        
                        DispatchQueue.main.async { [weak self] in
                            self?.updateDataWithPhotos(photos)
                        }
                    }
                } catch {
                    
                }
                
                break
            case .failure(let error):
                break
            }
        }
    }
    
    func updateDataWithPhotos(_ photos: [PhotoItem]) {
        self.viewModels = photos.map({ (photo) -> PhotoViewModel in
            return PhotoViewModel(item: photo)
        })
        
        self.collectionView.reloadData()
    }

    
    func setupUI() {
        
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: compactCollectionViewLayout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PicsumCompactCell.self, forCellWithReuseIdentifier: "Cell")
        self.view.addSubview(collectionView)
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PicsumCompactCell
        
        let viewModel = viewModels[indexPath.row]
        cell.layoutCellWithObject(viewModel)
        
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return compactCollectionViewLayout.sizeForItem(withCollectionViewSize: collectionView.bounds.size)
    }
}

