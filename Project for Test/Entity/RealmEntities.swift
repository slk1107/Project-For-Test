//
//  RealmEntities.swift
//  Project for Test
//
//  Created by Kris on 2020/2/22.
//  Copyright © 2020 Kris. All rights reserved.
//

import Foundation
import RealmSwift
class RealmSiteInfo: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var imageURL: String = ""
    override static func primaryKey() -> String? {
      return "id"
    }

}
