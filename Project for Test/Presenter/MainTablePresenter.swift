//
//  SiteListPresenter.swift
//  TravelSite
//
//  Created by Kris on 2020/2/16.
//  Copyright © 2020 Kris. All rights reserved.
//

import Foundation

protocol MainTablePresenterProtocol: class {
    var siteList: [UISiteInfo] {get set}
    var viewController: MainTableViewController! {get set}
    func viewDidLoad()
    func numberOfSections() -> Int
    func numberOfRowsInSection(section: Int) -> Int
    func willDisplay(index: Int)
    func cellIdentifier(at index: Int) -> String
}

extension MainTablePresenter: MainTablePresenterProtocol {
    func cellIdentifier(at index: Int) -> String {
        if index % 3 == 0 {
            return "Description"
        } else {
            return "ImageBackground"
        }
    }
    
    func viewDidLoad() {
        fetchData(from: 0)
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return siteList.count
    }
    
    func willDisplay(index: Int) {
        let currentItemCount = siteList.count
        if currentItemCount - index == 3 {
            fetchData(from: siteList.count)
        }
    }
    
    
}

class MainTablePresenter {
    weak var viewController: MainTableViewController!
    var siteList = [UISiteInfo]()
    var networkInteractor: NetworkInteractor!
    private func fetchData(from index: Int) {
        networkInteractor.fetchData(from: index, completion: {
            [weak self] response in
                self?.handleFetchCallback(response: response)
            }, error: { [weak self] error in
                self?.handleFetchFailed(error: error)
        })
    }
    
    private func handleFetchCallback(response: RootDataResponse?) {
        guard let results = response?.result.results, results.count > 0 else {
            return
        }
        let uiInfos = results.map({UISiteInfo(serverInfo: $0)})
        
        siteList.append(contentsOf: uiInfos)
        viewController.reloadTableView()
        saveToCoreData(infos: uiInfos)
    }
    
    private func saveToCoreData(infos: [UISiteInfo]) {
        
    }
    
    private func handleFetchFailed(error: Error) {
        
    }
}
