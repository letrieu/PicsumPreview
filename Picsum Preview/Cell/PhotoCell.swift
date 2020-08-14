//
//  PhotoCell.swift
//  Picsum Preview
//
//  Created by TrieuLD on 8/11/20.
//  Copyright © 2020 TrieuLD. All rights reserved.
//

import UIKit
import Nuke
import SkeletonView

class PhotoCell: UICollectionViewCell {
    var containerView: UIView!
    var thumbView: UIImageView!
    var titleLabel: UILabel!
    var subTitleLabel: UILabel!
    
    var viewModel: PhotoViewModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        containerView = UIView()
        containerView.clipsToBounds = true
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 8
        contentView.addSubview(containerView)
        
        thumbView = UIImageView()
        thumbView.clipsToBounds = true
        thumbView.backgroundColor = .gray
        thumbView.isSkeletonable = true
        containerView.addSubview(thumbView)
        
        titleLabel = UILabel()
        titleLabel.textColor = .darkGray
        titleLabel.numberOfLines = 2
        titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        containerView.addSubview(titleLabel)
        
        subTitleLabel = UILabel()
        subTitleLabel.textColor = .gray
        subTitleLabel.font = .systemFont(ofSize: 12)
        containerView.addSubview(subTitleLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        containerView.frame = contentView.bounds
        
        if let viewModel = self.viewModel {
            switch viewModel.cellLayout {
            case .compact:
                let contentWidth = contentView.width
                thumbView.frame = CGRect(x: 0, y: 0, width: contentWidth, height: contentWidth)
                titleLabel.frame = CGRect(x: UICommonValue.defaultSpacing, y: thumbView.bottom + UICommonValue.defaultSpacing, width: thumbView.width - 2 * UICommonValue.defaultSpacing, height: contentView.height)
                let titleSize = titleLabel.sizeThatFits(titleLabel.bounds.size)
                titleLabel.height = titleSize.height
                
                subTitleLabel.frame = CGRect(x: titleLabel.left, y: titleLabel.bottom + UICommonValue.defaultSpacing/2, width: titleLabel.width, height: 16)
                break
            case .regular:
                let contentHeight = contentView.height
                
                thumbView.frame = CGRect(x: 0, y: 0, width: contentHeight, height: contentHeight)
                titleLabel.frame = CGRect(x: thumbView.right + UICommonValue.defaultSpacing,
                                          y: UICommonValue.defaultSpacing,
                                          width: contentView.width - thumbView.right - 2*UICommonValue.defaultSpacing,
                                          height: contentView.height)
                let titleSize = titleLabel.sizeThatFits(titleLabel.bounds.size)
                titleLabel.height = titleSize.height
                
                subTitleLabel.frame = CGRect(x: titleLabel.left, y: titleLabel.bottom + UICommonValue.defaultSpacing/2, width: titleLabel.width, height: 16)
                break
                
            }
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layoutCellWithObject(_ viewModel: PhotoViewModel) {
        
        self.viewModel = viewModel
        
        if let imageUrl = URL(string: viewModel.thumbUrl) {
            
            let request = ImageRequest(
                url: imageUrl,
                processors: [ImageProcessor.Resize(size: thumbView.bounds.size)]
            )
            
            let options = ImageLoadingOptions(
                failureImage: UIImage(named: "fail"),
                contentModes: .init(success: .scaleAspectFill, failure: .center, placeholder: .center)
            )
            
            thumbView.showAnimatedGradientSkeleton()
            Nuke.loadImage(with: request, options: options, into: thumbView, completion: { [weak self] result in
                self?.thumbView.hideSkeleton()
            })
        }
        
        self.titleLabel.text = viewModel.title
        self.subTitleLabel.text = viewModel.subTitle
        
    }
}
