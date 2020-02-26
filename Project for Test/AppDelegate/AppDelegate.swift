//
//  AppDelegate.swift
//  Project for Test
//
//  Created by Kris on 2020/2/20.
//  Copyright © 2020 Kris. All rights reserved.
//

import UIKit
import CoreData
import Realm
import RealmSwift
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = MainRouter.buildMainPage()
        window!.makeKeyAndVisible()
        realmMigration()
        return true
    }
    
    private func realmMigration() {
        let config = Realm.Configuration(schemaVersion: 1, migrationBlock: {
            migration, oldSchemaVersion in
            if (oldSchemaVersion < 1) {
                migration.deleteData(forType: RealmSiteInfo.className())
            }
        })
        Realm.Configuration.defaultConfiguration = config
        let _ = try! Realm()
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

