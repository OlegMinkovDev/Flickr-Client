//
//  APIRequest.swift
//  Flickr Client
//
//  Created by Oleh Minkov on 05.01.2023.
//

import Foundation

typealias APIResponse<T> = Result<T, NetworkError>

public enum HTTPMethod: String {
    
    case get = "GET"
    case post = "POST"
}

public protocol APIRequest {
    
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any] { get }
    var headers: [String: String] { get }
}

extension APIRequest {
  
    var method: HTTPMethod { return .get }
    var parameters: [String: Any] { return [:] }
    var headers: [String: String] { return [:] }
}
