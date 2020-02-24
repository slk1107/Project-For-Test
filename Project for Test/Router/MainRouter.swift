//
//  TravelRouter.swift
//  TravelSite
//
//  Created by Kris on 2020/2/16.
//  Copyright © 2020 Kris. All rights reserved.
//

import UIKit
class MainRouter {
    static func buildMainPage() -> UIViewController {
        let storyboard = UIStoryboard(name: "FirstPage", bundle: nil)
        let rootVC = storyboard.instantiateInitialViewController() as! UINavigationController
        let mainTableViewController = rootVC.viewControllers[0] as! MainTableViewController

        let presenter = MainTablePresenter()
        presenter.viewController = mainTableViewController
        presenter.networkInteractor = NetworkInteractor()
        mainTableViewController.presenter = presenter
        
        return rootVC
    }
}
