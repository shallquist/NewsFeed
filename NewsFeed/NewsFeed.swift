//
//  NewsFeed.swift
//  NewsFeed
//
//  Created by steig hallquist on 6/8/18.
//  Copyright © 2018 steig hallquist. All rights reserved.
//

import UIKit
import Alamofire

private let url = "https://pubapps.github.io/newsfeed.json"
class NewsFeed: NSObject {
    class func getData(_ handler:@escaping (_ dataFeed:DataFeed?, _ error: Error?)->Void) {
        Alamofire.request(url)
            .validate()
            .responseData { (response) in
                switch response.result {
                case .success(let values):
                    let results = try? JSONDecoder().decode(DataFeed.self, from: values)
                    
                    handler(results, nil)
                case .failure(let error):
                    handler(nil, error)
                }

        }
    }
}
