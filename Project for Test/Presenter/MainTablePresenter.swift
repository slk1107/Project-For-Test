//
//  SiteListPresenter.swift
//  TravelSite
//
//  Created by Kris on 2020/2/16.
//  Copyright © 2020 Kris. All rights reserved.
//

import Foundation

protocol MainTablePresenterProtocol: class {
    var viewController: MainTableViewController! {get set}
    func viewDidLoad()
    func numberOfSections() -> Int
    func numberOfRowsInSection(section: Int) -> Int
    func willDisplay(index: Int)
}

extension MainTablePresenter: MainTablePresenterProtocol {
    func viewDidLoad() {
        
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return 0
    }
    
    func willDisplay(index: Int) {
        
    }
    
    
}

class MainTablePresenter {
    weak var viewController: MainTableViewController!
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
        guard let results = response?.result.results else {
            return
        }
        let uiInfos = results.map({UISiteInfo(serverInfo: $0)})
        saveToCoreData(infos: uiInfos)
    }
    
    private func saveToCoreData(infos: [UISiteInfo]) {
        
    }
    
    private func handleFetchFailed(error: Error) {
        
    }
}
