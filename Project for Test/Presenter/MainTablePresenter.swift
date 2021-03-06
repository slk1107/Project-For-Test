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

enum ServerError: Error {
    case NoResult
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
            if uiResults.count == 0 {
                self.fetchFromServer(from: 0)
            } else {
                self.siteList.append(contentsOf: uiResults)
                self.viewController.reloadTableView()
                self.syncFromServer(from: 0, pageCount: uiResults.count)
            }
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
        if currentItemCount - index == 3 && fetchedRecord < currentItemCount {
            fetchedRecord = currentItemCount
            fetchFromServer(from: currentItemCount)
        }
    }
    
    
}

class MainTablePresenter {
    weak var viewController: MainTableViewController!
    var siteList = [UISiteInfo]()
    var networkInteractor: NetworkInteractor!
    var databaseInteractor: DataBaseInteractor!
    private var fetchedRecord = 0
    
    private func fetchFromDB(completeHandler: @escaping ([UISiteInfo]) -> Void) {
        databaseInteractor.fetch() {
            realmSiteInfos in
            let uiInfos = realmSiteInfos.map {UISiteInfo(dbInfo: $0)}
            completeHandler(uiInfos)
        }
    }
    
    private func fetchFromServer(from index: Int) {
        syncFromServer(from: index, complete: { [weak self] results in
            self?.handleServerFetchCallback(results: results)
        }, error: { [weak self] error in
            self?.handleFetchFailed(error: error)
        })
    }
    
    private func syncFromServer(from index: Int, pageCount: Int = 10, complete: (([UISiteInfo]) -> Void)? = nil, error: ((Error) -> Void)? = nil) {
        networkInteractor.fetchData(from: index, pageCount: pageCount, completion: {
            [weak self] response in
            guard let self = self, let results = response?.result.results else {return}
            
            if results.count == 0 {
                error?(ServerError.NoResult)
            }
            
            self.databaseInteractor.save(siteInfos: results)
            complete?(results.map({UISiteInfo(serverInfo: $0)}))
            
            }, error: error)
    }
    
    private func handleServerFetchCallback(results: [UISiteInfo]) {
        siteList.append(contentsOf: results)
        viewController.reloadTableView()
    }
    
    private func handleFetchFailed(error: Error) {
        fetchedRecord = fetchedRecord - 10 //page count
    }
}
