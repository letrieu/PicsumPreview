//
//  PicsumProvider.swift
//  Picsum Preview
//
//  Created by TrieuLD on 8/11/20.
//  Copyright © 2020 TrieuLD. All rights reserved.
//

import Moya

enum PicsumProvider: TargetType {
    case getPhotos(page: Int, limit: Int)
    
    var baseURL: URL { return URL(string: "https://picsum.photos/v2")! }
    
    var path: String {
        return "/list"
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data { return Data() }
    
    var task: Task {
        var parameters: [String: Any] = [:]
        
        switch self {
        case .getPhotos(let page, let limit):
            parameters = ["page": page, "limit": limit]
        }
        
        return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
    }
    
    var headers: [String : String]? {
        return nil
    }

}
