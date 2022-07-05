//
//  DogModel.swift
//  DogCall
//
//  Created by belal medhat on 01/07/2022.
//

import Foundation
struct DogResponse:Codable{
    var message:String?
    var status:String?
}
struct DogErrorResponse:Codable {
    
    var status:String?
    var message:String?
    var code:Int?
}

