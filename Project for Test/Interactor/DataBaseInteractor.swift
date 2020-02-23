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
    
    func fetch(completeHandler: @escaping ([RealmSiteInfo]?) -> Void) {
        queue.async {
            do {
                let realm = try Realm()
                let siteInfos = realm.objects(RealmSiteInfo.self).sorted(by: {$0.title < $1.title})
                completeHandler(siteInfos)
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    
    func save(siteInfo: UISiteInfo) {
        guard let realm = try? Realm() else {
            return
        }
        try? realm.write {
            let realmSite = RealmSiteInfo()
            realmSite.title = siteInfo.title
            realmSite.imageURL = siteInfo.imageURL.absoluteString
            realm.add(realmSite)
        }
    }
}
