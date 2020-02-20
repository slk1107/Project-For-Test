//
//  File.swift
//  TravelSite
//
//  Created by Kris on 2020/2/16.
//  Copyright © 2020 Kris. All rights reserved.
//

import Foundation
extension URL {
    func toHttps() -> URL? {
        let httpsScheme = "https://"
        if self.scheme == nil {
            let string = httpsScheme + self.relativeString
            return URL(string: string)
        }
        
        let urlWithouScheme = self.relativeString.components(separatedBy: "://").last!
        let resultURLString = httpsScheme + urlWithouScheme
        return URL(string: resultURLString)
    }
}
