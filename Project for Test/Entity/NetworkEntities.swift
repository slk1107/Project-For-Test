//
//  NetworkEntities.swift
//  TravelSite
//
//  Created by Kris on 2020/2/15.
//  Copyright © 2020 Kris. All rights reserved.
//

import Foundation
struct RootDataResponse: Codable {
    var result: DatalistResponse
}
struct DatalistResponse: Codable {
    var limit: Int
    var offset: Int
    var count: Int?
    var results: [SiteInfo]
}
struct SiteInfo: Codable {
    var _id: Int
    var stitle: String
    var file: String
    
    var imageURL: URL {
        get {
            return file.components(separatedBy: "http://").compactMap({URL(string: $0)?.toHttps()}).first!
        }
    }
}
