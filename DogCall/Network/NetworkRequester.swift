//
//  NetworkRequester.swift
//  DogCall
//
//  Created by belal medhat on 04/07/2022.
//

import Foundation

enum ResponseStatus {
    case success
    case failure
    case badDecode
}
class NetworkRequester{
    private let network:RequestProtocols
    init(network:RequestProtocols){
        self.network = network
    }
    func getDogImg(completion:@escaping(ResponseStatus,Any)->(Void)){
        network.Request(URL: dogService.DogImage.urlRequest) { (result:CustomResults<DogResponse,DogErrorResponse,Error>) in
            switch result{
            case .success(let response):
                print(response)
                print(response.status ?? "")
                completion(ResponseStatus.success,response)
            case .failure(let error):
                print("")
                print(error.code ?? "100")
                print(error)
                completion(ResponseStatus.failure,error)
                
            case .failureError(let error):
                print(error.localizedDescription)
                completion(ResponseStatus.badDecode,error)
                
            }
        }
    }
}
