//
//  PhotoCollectionViewLayout.swift
//  Picsum Preview
//
//  Created by TrieuLD on 8/11/20.
//  Copyright © 2020 TrieuLD. All rights reserved.
//

import UIKit

class PhotoCollectionViewLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        
        self.minimumLineSpacing = UICommonValue.defaultSpacing
        self.minimumInteritemSpacing = UICommonValue.defaultSpacing
        self.scrollDirection = .vertical
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func sizeForItem(withCollectionViewSize: CGSize) -> CGSize {
        
        var collum : CGFloat = 3
        
        if UICommonValue.isLandscape {
            collum = 4
        }
        
        let itemWidth = (UICommonValue.screenWidth - (collum - 1)*UICommonValue.defaultSpacing)/collum
        
        return CGSize(width: itemWidth, height: itemWidth + 70)
    }
}
