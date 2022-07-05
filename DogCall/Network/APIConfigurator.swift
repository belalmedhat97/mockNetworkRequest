//
//  APIConfigurator.swift
//  DogCall
//
//  Created by belal medhat on 01/07/2022.
//

import Foundation
enum CustomResults<T,E,Error>{ // Using this custom results to decode when error json response came
    case success(T)
    case failure(E)
    case failureError(Error)
}
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case put = "PUT"
    // implement more when needed: post, put, delete, patch, etc.
}
enum RequestParams {
    case body(_:[String:Any])
    case url(_:[String:Any])
    case NoParamter
}
protocol Service {
    var baseURL: String { get }
    var path: String { get }
    var parameters: RequestParams { get }
    var method: HTTPMethod { get }
    var Header:[String:String] { get }
}

extension Service {
    public var urlRequest: URLRequest {
        guard let url = URL(string: baseURL) else {
        fatalError("URL could not be built")
        }
        var request = URLRequest(url: url.appendingPathComponent(path))
        
        
        request.httpMethod = method.rawValue

        switch parameters {

                case .body(let params):
                    request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])

                   case .url(let params):
                           let queryParams = params.map { pair  in
                               return URLQueryItem(name: pair.key, value: "\(pair.value)")
                           }
                           var components = URLComponents(string:url.appendingPathComponent(path).absoluteString)
                           components?.queryItems = queryParams
                           request.url = components?.url

                   case .NoParamter:
                       request.httpBody = nil

                   }

                    return request
        }
    }
