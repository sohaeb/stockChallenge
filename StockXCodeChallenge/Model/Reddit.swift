//
//  Weather.swift
//  StockXCodeChallenge
//
//  Created by may on 2018-07-11.
//  Copyright © 2018 sohaeb. All rights reserved.
//

import Foundation

/*
 * Codable Structs for decoding JSON Data using JSONDecoder
 */

struct Reddit : Codable {
    let data : FirstLevelData
    let reason: String?
}

struct FirstLevelData : Codable {
        let children : [Children]
}

struct Children : Codable {
    let data : SecondLevelData
}

struct SecondLevelData : Codable {
    let title : String
    let permalink : String
    let subreddit_name_prefixed : String
}
