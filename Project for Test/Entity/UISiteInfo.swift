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
    var description: String
    init(serverInfo: SiteInfo) {
        self.title = serverInfo.stitle
        self.description = serverInfo.xbody
        let firstFileURL = serverInfo.file
            .components(separatedBy: "http://")
            .compactMap({URL(string: $0)?.toHttps()})
            .first!
        self.imageURL = firstFileURL
    }
}
