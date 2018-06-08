//
//  DataFeed.swift
//  NewsFeed
//
//  Created by steig hallquist on 6/8/18.
//  Copyright © 2018 steig hallquist. All rights reserved.
//

import Foundation

struct DataFeed : Codable {
    struct Content : Codable {
        let title : String
        let url: String
        let images: [Image]
    }
    
    struct Result : Codable {
        let content : Content
    }
    
    struct Items : Codable {
        let result : [Result]
    }
    
    let items : Items
}

struct Image : Codable {
    let originalUrl : String
    let originalHeight : Int
    let originalWidth : Int
}
