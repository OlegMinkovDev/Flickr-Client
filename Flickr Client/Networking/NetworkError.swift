//
//  NetworkError.swift
//  Flickr Client
//
//  Created by Oleh Minkov on 05.01.2023.
//

import Foundation

enum Status: String, Decodable {
    
    case ok = "ok"
    case fail = "fail"
}

enum NetworkError: Error {
    
    struct APIError: Decodable {
        
        let stat: Status
        let code: Int
        let message: String
    }
    
    case transportError(Error)
    case serverError(statusCode: Int)
    case noData
    case decodingError(Error)
    case apiError(APIError)
    
    public var localizedDescription: String {
        switch self {
        case let .transportError(error):
            return "Transport error occur. Details: \(error)"
        case let .serverError(code):
            return "Server error occur with status code: \(code)"
        case .noData:
            return "No data found"
        case let .decodingError(error):
            return "Decoding error occur. Details: \(error)"
        case let .apiError(error):
            return error.message
        }
    }
}

extension NetworkError {
    
    init?(data: Data?, response: URLResponse?, error: Error?) {
        if let error = error {
            self = .transportError(error)
            return
        }

        if let response = response as? HTTPURLResponse,
            !(200...299).contains(response.statusCode) {
            self = .serverError(statusCode: response.statusCode)
            return
        }
        
        guard let data = data else {
            self = .noData
            return
        }
        
        if let apiError = try? JSONDecoder().decode(APIError.self, from: data) {
            self = .apiError(apiError)
            return 
        }
        
        return nil
    }
}
