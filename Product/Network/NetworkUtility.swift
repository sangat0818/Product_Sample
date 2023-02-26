//
//  NetworkUtility.swift
//  Product
//
//  Created by Sangat Baral on 26/02/23.
//

import Foundation


public typealias NetworkRouterCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void

enum NetworkResult {
    case success
    case failure
}

class NetworkUtility {
    public static func request(urlString: String, completion handler: @escaping NetworkRouterCompletion) {
        let url = URL(string: urlString)!
        let urlSession = URLSession.shared.dataTask(with: url) { data, response, error in
            handler(data, response, error)
        }
        urlSession.resume()
    }
    
    public static func getResponseModel<T: Codable>(data: Data?, error: Error?, response: URLResponse?, type _: T.Type) -> (model: T?, error: String?) {
        if let httpResponse = response as? HTTPURLResponse {
            switch NetworkUtility.handleNetworkResponse(httpResponse) {
            case .success:
                guard let safeData = data else {
                    return (nil, "Error in Data")
                }
                do {
                    return (try JSONDecoder().decode(T.self, from: safeData), nil)
                } catch {
                    return (nil, error.localizedDescription)
                }

            case .failure:
                return (nil, "API Call Failed")
            }
        }

        return (nil, "Error in Response")
    }
    
    internal static func handleNetworkResponse(_ response: HTTPURLResponse) -> NetworkResult {
        switch response.statusCode {
        case 200 ... 299:
            return .success
        default:
            return .failure
        }
    }
}

