//
//  ViewController.swift
//  DogCall
//
//  Created by belal medhat on 01/07/2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var dogBtn: UIButton!
    @IBOutlet weak var dogImage: UIImageView!
    private let network = NetworkRequester(network: RequestHandler())
    override func viewDidLoad() {
        super.viewDidLoad()
        dogBtn.layer.cornerRadius = 10
        dogBtn.clipsToBounds = true
        dogImage.layer.cornerRadius = 10
        dogImage.clipsToBounds = true
        dogImage.contentMode = .scaleAspectFill
        // Do any additional setup after loading the view.
    }
    @IBAction func dogCallBtn(_ sender: Any) {
        network.getDogImg { status, result in

            switch status {
            case .success:
                print(result)
                let dogResult = result as! DogResponse
                dogResult.message?.getImgFromUrl({ img in
                    self.dogImage.image = img
                })
                print("success")
                break
            case .failure:
                print(result)
                print("server error")
                break
            default:
                print(result)
                print("decode error")
                break
            }
        }
    }

}

