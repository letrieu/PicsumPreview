//
//  PicsumRegularCell.swift
//  Picsum Preview
//
//  Created by TrieuLD on 8/11/20.
//  Copyright © 2020 TrieuLD. All rights reserved.
//

import UIKit

class PicsumRegularCell: PicsumCompactCell {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let contentHeight = contentView.height
        
        thumbView.frame = CGRect(x: 0, y: 0, width: contentHeight, height: contentHeight)
        titleLabel.frame = CGRect(x: thumbView.right + UICommonValue.defaultSpacing,
                                  y: 0,
                                  width: contentView.width - thumbView.right - 2*UICommonValue.defaultSpacing,
                                  height: 20)
        subTitleLabel.frame = CGRect(x: titleLabel.left, y: titleLabel.bottom, width: titleLabel.width, height: 16)
    }
}
