//
//  jsonObjectCreator.swift
//  DogCallTests
//
//  Created by belal medhat on 04/07/2022.
//

import Foundation
/// create class to create mocked response from server
class JsonObjectCreator{

    static func getJSON<customType:Encodable>(jsnInfo:customType) -> Data?{
            let encoder = JSONEncoder()
            if let jsonData = try? encoder.encode(jsnInfo) {
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    print(jsonString)
                }
                return jsonData
            }
        return nil
        }
}
