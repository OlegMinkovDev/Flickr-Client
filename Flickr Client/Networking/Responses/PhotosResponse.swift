//
//  PhotosResponse.swift
//  Flickr Client
//
//  Created by Oleh Minkov on 05.01.2023.
//

import Foundation

struct PhotosResponse: Decodable {
    
    struct Photos: Decodable {
        
        let page: Int
        let pages: Int
        let perpage: Int
        let total: Int
        let photo: [Photo]
    }
    
    let photos: Photos
}

struct Photo: Decodable {

    let title: String
    let url: String
    let height: Int
    let width: Int

    enum CodingKeys: String, CodingKey {

        case title
        case url = "url_m"
        case height = "height_m"
        case width = "width_m"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        url = try container.decode(String.self, forKey: .url)
        height = try container.decode(Int.self, forKey: .height)
        width = try container.decode(Int.self, forKey: .width)
    }
}
