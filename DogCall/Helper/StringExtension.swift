//
//  StringExtension.swift
//  DogCall
//
//  Created by belal medhat on 03/07/2022.
//

import UIKit
extension String {
    func getUrl() -> URL {
        let url:URL = URL(string: self)!
        return url
    }
    
    func getImgFromUrl(_ completion: @escaping(UIImage)->(Void)?){
        let url = URL(string: self)
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url!){ //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
                completion((UIImage(data: data) ?? UIImage(systemName: "xmark.circle.fill"))!)
            }
        }
        }
    }
}
