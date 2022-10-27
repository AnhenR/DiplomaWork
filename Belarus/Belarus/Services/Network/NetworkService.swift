//
//  NetworkService.swift
//  Belarus
//
//  Created by user on 21.10.22.
//

import Foundation

protocol NetworkRouterProtocol {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: String { get }
    var parameters: [URLQueryItem] { get }
}

enum NetworkErros: String, Error {
    case invalidURL = "Invalid URL, Try again"
}

class NetworkService {
    class func request<T: Decodable>(router: NetworkRouterProtocol, completion: @escaping (Result<T, Error>)-> Void) {
        
        let session = URLSession(configuration: .default)
        guard let urlRequest = constructRequest(from: router) else {
            completion(.failure(NetworkErros.invalidURL))
            return
        }
        
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                if let error = error {
                    completion(.failure(error))
                }
                return
            }
            guard response != nil else {
                print("no response")
                return
            }
            guard let data = data else {
                print("no data")
                return
            }
            do {
                let responseObject = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(responseObject))
                }
            } catch {
                completion(.failure(error))
            }
        }
        dataTask.resume()
    }
    
    private class func constructRequest(from router: NetworkRouterProtocol) -> URLRequest? {
        var comonents = URLComponents()
        comonents.scheme = router.scheme
        comonents.host = router.host
        comonents.path = router.path
        comonents.queryItems = router.parameters
        
        guard let url = comonents.url else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = router.method
        return urlRequest
    }
}

actor NetworkActor {
    static func request<T: Decodable>(router: NetworkRouterProtocol) async -> Result<T, Error> {
        
        let session = URLSession(configuration: .default)
        guard let urlRequest = constructRequest(from: router) else {
            return .failure(NetworkErros.invalidURL)
        }
        
        do {
            let data = try await session.data(for: urlRequest).0
            let responseObject = try JSONDecoder().decode(T.self, from: data)
            return .success(responseObject)
        } catch {
            return .failure(error)
        }
    }
    
    static func request<T: Decodable>(router: NetworkRouterProtocol) async throws -> T {
        
        let session = URLSession(configuration: .default)
        guard let urlReuqest = constructRequest(from: router) else {
            throw NetworkErros.invalidURL
        }
        
        do {
            let data = try await session.data(for: urlReuqest).0
            let responseObject = try JSONDecoder().decode(T.self, from: data)
            return responseObject
        } catch {
            throw error
        }
    }
    
    private static func constructRequest(from router: NetworkRouterProtocol) -> URLRequest? {
        var comonents = URLComponents()
        comonents.scheme = router.scheme
        comonents.host = router.host
        comonents.path = router.path
        comonents.queryItems = router.parameters
        
        guard let url = comonents.url else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = router.method
        return urlRequest
    }
}
