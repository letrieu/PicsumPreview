//
//  PhotoItem.swift
//  Picsum Preview
//
//  Created by TrieuLD on 8/11/20.
//  Copyright © 2020 TrieuLD. All rights reserved.
//

import ObjectMapper

struct PhotoItem: Codable, Mappable, Equatable {
    init?(map: Map) {
        
    }
    
    var id: String?
    var author: String?
    var width: Int?
    var height: Int?
    var url: String?
    var download_url: String?

    mutating func mapping(map: Map) {
        id <- map["id"]
        author <- map["author"]
        width <- map["width"]
        height <- map["height"]
        url <- map["url"]
        download_url <- map["download_url"]
    }
}

