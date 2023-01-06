//
//  InterestingListRequest.swift
//  Flickr Client
//
//  Created by Oleh Minkov on 05.01.2023.
//

import Foundation

struct InterestingListRequest: APIRequest {
    
    var page: Int
    
    init(page: Int) {
        self.page = page
    }
    
    var path: String { "/services/rest" }
    var parameters: [String : Any] {
        [
            "method": "flickr.interestingness.getList",
            "api_key": "\(Constant.apiKey)",
            "extras": "url_m",
            "per_page": "10",
            "page": "\(page)",
            "format": "json",
            "nojsoncallback": "1"
        ]
    }
}
