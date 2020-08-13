//
//  PhotoCollectionViewLayout.swift
//  Picsum Preview
//
//  Created by TrieuLD on 8/11/20.
//  Copyright © 2020 TrieuLD. All rights reserved.
//

import UIKit

class PhotoCollectionViewLayout: UICollectionViewFlowLayout {
    
    var iPhoneCollumn: CGFloat = 1
    var iPadCollumn: CGFloat = 1
    var iPhoneLandCapseCollumn: CGFloat = 1
    var iPadLandCapseCollumn: CGFloat = 1
    
    var heightRatio: CGFloat = 1
    
    override init() {
        super.init()
        
        self.minimumLineSpacing = UICommonValue.smallSpacing
        self.minimumInteritemSpacing = UICommonValue.smallSpacing
        self.scrollDirection = .vertical
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func sizeForItem(with collectionViewSize: CGSize) -> CGSize {
        
        let collum = self.numberOfCollumn()
        
        let itemWidth = (UICommonValue.screenWidth - (collum - 1)*UICommonValue.smallSpacing)/collum
        
        return CGSize(width: itemWidth, height: itemWidth * heightRatio)
    }
    
    func sizeForMoreItem(with collectionViewSize: CGSize) -> CGSize {
        return CGSize(width: collectionViewSize.width, height: 40)
    }
    
    func numberOfCollumn() -> CGFloat {
        if UICommonValue.isLandscape {
            return UICommonValue.isIpad ? iPadLandCapseCollumn : iPhoneLandCapseCollumn
        }
        return UICommonValue.isIpad ? iPadCollumn : iPhoneCollumn
    }
}
