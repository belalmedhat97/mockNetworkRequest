//
//  DogRouter.swift
//  DogCall
//
//  Created by belal medhat on 01/07/2022.
//

import Foundation

enum dogService:Service {
    
    case DogImage // indicate Success Response
    case DogError // indicate Error Response
    var baseURL: String {
        return "https://dog.ceo"
    }
    
     var path: String {
           switch self {
           case .DogImage,.DogError:
               return "/api/breeds/image/random" // ## used One
           }
       }
    
    var parameters: RequestParams {
        switch self {
        case .DogImage,.DogError:
            return.NoParamter // ## used One
        }
    }
       var method: HTTPMethod {
        switch self {
        case .DogError:
            return .post
        case .DogImage:
            return .get
        }
    }

    var Header: [String : String] {
        return ["":""]
    }
    
    

}
