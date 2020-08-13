//
//  MoreCollectionViewCell.swift
//  Picsum Preview
//
//  Created by TrieuLD on 8/13/20.
//  Copyright © 2020 TrieuLD. All rights reserved.
//

import UIKit
import SnapKit

class MoreCollectionViewCell: UICollectionViewCell {
    var indicatorView: UIActivityIndicatorView!
    var loadingLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        indicatorView = UIActivityIndicatorView()
        self.addSubview(indicatorView)
        
        loadingLabel = UILabel()
        loadingLabel.font = UIFont.systemFont(ofSize: 14)
        loadingLabel.textColor = .black
        self.addSubview(loadingLabel)
        
        let paddingLeft = UIView()
        self.addSubview(paddingLeft)
        
        let paddingRight = UIView()
        self.addSubview(paddingRight)
        
        loadingLabel.text = "Loading..."
        
        indicatorView.snp.makeConstraints { maker in
            maker.left.equalTo(paddingLeft.snp.right)
            maker.centerY.equalTo(self.snp.centerY)
        }
        
        loadingLabel.snp.makeConstraints { maker in
            maker.left.equalTo(indicatorView.snp.right).offset(UICommonValue.smallSpacing)
            maker.centerY.equalTo(indicatorView.snp.centerY)
            maker.right.equalTo(paddingRight.snp.left)
        }
        
        paddingLeft.snp.makeConstraints { maker in
            maker.left.equalTo(self)
            maker.centerY.equalTo(indicatorView.snp.centerY)
            maker.width.equalTo(paddingRight.snp.width)
        }
        paddingRight.snp.makeConstraints { maker in
            maker.right.equalTo(self)
            maker.centerY.equalTo(indicatorView.snp.centerY)
        }
        indicatorView.startAnimating()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
