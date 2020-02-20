//
//  SiteListPresenter.swift
//  TravelSite
//
//  Created by Kris on 2020/2/16.
//  Copyright © 2020 Kris. All rights reserved.
//

import Foundation

class MainTablePresenter {
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
