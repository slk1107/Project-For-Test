//
//  CoreDataInteractor.swift
//  Project for Test
//
//  Created by Kris on 2020/2/20.
//  Copyright © 2020 Kris. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class DataBaseInteractor: NSObject{
    static let shared = DataBaseInteractor()
    let queue = DispatchQueue(label: "fetch CoreSiteInfo", qos: .background)
    
    func fetch(completeHandler: @escaping ([RealmSiteInfo]) -> Void) {
        queue.async {
            do {
                let realm = try Realm()
                var results = [RealmSiteInfo]()
                for realmInfo in realm.objects(RealmSiteInfo.self).enumerated() {
                    results.append(realmInfo.element)
                }
                completeHandler(results)
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    func save(siteInfos: [SiteInfo]) {
        guard let realm = try? Realm() else {
            return
        }
        try? realm.write {
            for siteInfo in siteInfos {
                let realmSite = RealmSiteInfo()
                realmSite.id = siteInfo._id
                realmSite.title = siteInfo.stitle
                realmSite.imageURL = siteInfo.imageURL.absoluteString
                realm.add(realmSite, update: .all)
            }
        }
    }
}
