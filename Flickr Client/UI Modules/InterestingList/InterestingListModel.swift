//
//  InterestingListModel.swift
//  Flickr Client
//
//  Created by Oleh Minkov on 05.01.2023.
//

import Foundation

protocol InterestingListModelProtocol {
    
    var photos: [Photo] { get set }
    var page: Int { get set }
    var pages: Int { get set }

    func getInterestingList(page: Int, completion: @escaping (Result<PhotosResponse, NetworkError>) -> Void)
}

class InterestingListModel: InterestingListModelProtocol {
    
    var photos: [Photo] = []
    var page: Int = 1
    var pages: Int = 0
    
    func getInterestingList(page: Int, completion: @escaping (Result<PhotosResponse, NetworkError>) -> Void) {
        apiClient.execute(request: InterestingListRequest(page: page), responseType: PhotosResponse.self, completion: completion)
    }
}
