//
//  PhotoViewModel.swift
//  Picsum Preview
//
//  Created by TrieuLD on 8/11/20.
//  Copyright © 2020 TrieuLD. All rights reserved.
//

import UIKit

enum PhotoCellLayout: Int {
    case compact
    case regular
}

class PhotoViewModel: NSObject {
    var title: String = ""
    var subTitle: String = ""
    var thumbUrl: String = ""
    var cellLayout: PhotoCellLayout = .compact
    
    var item: PhotoItem?
    
    init(item: PhotoItem) {
        self.item = item
        
        self.title = item.author ?? ""
        self.subTitle = "size: \(item.width ?? 0)x\(item.height ?? 0)"
        self.thumbUrl = item.download_url ?? ""
    }
    
    
}
