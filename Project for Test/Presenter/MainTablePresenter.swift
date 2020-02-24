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
        fetchFromDB() { [weak self] uiResults in
            guard let self = self else {return}
            self.siteList.append(contentsOf: uiResults)
            self.viewController.reloadTableView()
            self.fetchFromServer(from: self.siteList.count)
        }
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
            fetchFromServer(from: siteList.count)
        }
    }
    
    
}

class MainTablePresenter {
    weak var viewController: MainTableViewController!
    var siteList = [UISiteInfo]()
    var networkInteractor: NetworkInteractor!
    var databaseInteractor: DataBaseInteractor!
    
    private func fetchFromDB(completeHandler: @escaping ([UISiteInfo]) -> Void) {
        databaseInteractor.fetch() {
            realmSiteInfos in
            let uiInfos = realmSiteInfos.map {UISiteInfo(dbInfo: $0)}
            completeHandler(uiInfos)
        }
    }
    
    private func fetchFromServer(from index: Int) {
        networkInteractor.fetchData(from: index, completion: {
            [weak self] response in
                self?.handleServerFetchCallback(response: response)
            }, error: { [weak self] error in
                self?.handleFetchFailed(error: error)
        })
    }
    
    private func handleServerFetchCallback(response: RootDataResponse?) {
        guard let results = response?.result.results, results.count > 0 else {
            return
        }
        let uiInfos = results.map({UISiteInfo(serverInfo: $0)})
        
        siteList.append(contentsOf: uiInfos)
        viewController.reloadTableView()
        saveToCoreData(infos: uiInfos)
    }
    
    private func saveToCoreData(infos: [UISiteInfo]) {
        databaseInteractor.save(siteInfos: infos)
    }
    
    private func handleFetchFailed(error: Error) {
        
    }
}
