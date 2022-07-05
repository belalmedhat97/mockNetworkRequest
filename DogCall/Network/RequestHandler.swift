//
//  NetworkCaller.swift
//  DogCall
//
//  Created by belal medhat on 01/07/2022.
//

import Foundation

protocol RequestProtocols{

    func Request<T:Codable,E:Codable>(URL:URLRequest, completion: @escaping (CustomResults<T,E,Error>) -> Void)
}
class RequestHandler:RequestProtocols{
    private let urlSession: URLSession
      
      init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
      }
    
     func Request<T:Codable,E:Codable>(URL:URLRequest, completion: @escaping (CustomResults<T,E,Error>) -> Void){
        
        let session = urlSession
        
        let RequesterTask = session.dataTask(with: URL) { (data, response, error) in
            guard error == nil else {return}
            if let HTTPResponse = response as? HTTPURLResponse {
                let str = String(decoding: data!, as: UTF8.self)
                print(str)
                switch HTTPResponse.statusCode {
                case 200..<300:
                    if let URLData = data {
                    do {
                    let ResponseResult = try JSONDecoder().decode(T.self, from: URLData)
                        completion(.success(ResponseResult))
                    }catch{
                        completion(.failureError(error))
                    }
                    }
                case 400...500:
                    if let URLDataError = data {
                        do{
                    let ErrorResponseResult = try JSONDecoder().decode(E.self, from: URLDataError)
                        completion(.failure(ErrorResponseResult))
                    }catch{
                        completion(.failureError(error))
                    
                }
            }
                default:
                    print("")
                }
          
        }
        }
        RequesterTask.resume()
    }
}




