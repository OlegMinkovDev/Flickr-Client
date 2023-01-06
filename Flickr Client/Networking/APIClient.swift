//
//  APIClient.swift
//  Flickr Client
//
//  Created by Oleh Minkov on 05.01.2023.
//

import Foundation

class APIClient {
    
    private let baseUrlString: String
    
    init(baseUrlString: String) {
        self.baseUrlString = baseUrlString
    }
    
    func execute<T: Decodable>(
        request: APIRequest,
        responseType: T.Type,
        completion: @escaping (APIResponse<T>) -> Void
    ) {
        var components = URLComponents()
        components.scheme = Constant.scheme
        components.host = baseUrlString
        components.path = request.path
        
        if request.method == .get {
            components.queryItems = request.parameters.map { URLQueryItem(name: $0.key, value: $0.value as? String) }
        }
        
        guard let url = components.url else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        
        if request.method == .post {
            let httpBody = try? JSONSerialization.data(withJSONObject: request.parameters)
            urlRequest.httpBody = httpBody
        }
        
        let session = URLSession.shared.dataTask(with: urlRequest, completionHandler: { data, response, error in
            if let networkError = NetworkError(data: data, response: response, error: error) {
                completion(.failure(networkError))
                return
            }
            
            guard let data = data else { return }
            
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } catch let error {
                completion(.failure(NetworkError.decodingError(error)))
            }
        })
        session.resume()
    }
}
