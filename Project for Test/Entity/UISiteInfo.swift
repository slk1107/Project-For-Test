//
//  SiteListEntities.swift
//  TravelSite
//
//  Created by Kris on 2020/2/16.
//  Copyright © 2020 Kris. All rights reserved.
//

import Foundation
struct UISiteInfo {
    var title: String
    var imageURL: URL
    init(serverInfo: SiteInfo) {
        self.title = serverInfo.stitle
        let firstFileURL = serverInfo.file
            .components(separatedBy: "http://")
            .compactMap({URL(string: $0)?.toHttps()})
            .first!
        self.imageURL = firstFileURL
    }
    
    init(title: String, imageURL: URL) {
        self.title = title
        self.imageURL = imageURL
    }
}
