//
//  DogNetworkTests.swift
//  DogCallTests
//
//  Created by belal medhat on 03/07/2022.
//

import XCTest
@testable import DogCall

class DogNetworkTests: XCTestCase {
    var network:RequestProtocols!
    var exp:XCTestExpectation!
    override func setUp() {
        let configuration = URLSessionConfiguration.ephemeral // 1
        configuration.protocolClasses = [URLProtocolStub.self] // 2
        let session = URLSession(configuration: configuration)
        exp = expectation(description: "Loading dog images")
        network = RequestHandler(urlSession: session)
        
    }
    override func tearDown() {
        network = nil
    }
    //MARK: - test successful response
    func testSuccessfulResponse() {
        // Prepare mock response.
        let MockedResult = DogResponse(message:"https://images.dog.ceo/breeds/cotondetulear/IMG_20160830_202631573.jpg", status: "success")

        URLProtocolStub.loadingHandler = { request in // 3
            
            guard let url = request.url, url == "\(Endpoints.baseURL)/api/breeds/image/random".getUrl() else {
                throw NSError(domain: "no match url", code: 1)
                
            }
            
            let response = HTTPURLResponse(url: URL(string: "\(Endpoints.baseURL)/api/breeds/image/random")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, JsonObjectCreator.getJSON(jsnInfo: MockedResult)!)
        }
        
        
        
        
        // Call API.
        network.Request(URL: dogService.DogImage.urlRequest) { (result:CustomResults<DogResponse,DogErrorResponse,Error>) in
            switch result{
            case .success(let response):
                //MARK: - get the success response here
                XCTAssertEqual(response.message, MockedResult.message,"message is similar to message")
            
                XCTAssertEqual(response.status, MockedResult.status)

                //You can handle 'response' when request success (response as LoginResponse)
            case .failure(let error):
                
                print("")
                print(error.code ?? "100")
                print(error)
            case .failureError(let error):
                print(error.localizedDescription)
            }
            self.exp.fulfill()
            
        }
        wait(for: [exp], timeout: 10)
    }
    
    //MARK: - test failure response
    func testFailureResponse() {
        // Prepare mock response.
        let MockedResult = DogErrorResponse(status: "failure", message:"server error",code:400)
        
        
        URLProtocolStub.loadingHandler = { request in // 3
            
            guard let url = request.url, url == "\(Endpoints.baseURL)/api/breeds/image/random".getUrl() else {
                throw NSError(domain: "no match url", code: 1)
                
            }
            
            let response = HTTPURLResponse(url: URL(string: "\(Endpoints.baseURL)/api/breeds/image/random")!, statusCode: 400, httpVersion: nil, headerFields: nil)!
            return (response, JsonObjectCreator.getJSON(jsnInfo: MockedResult)!)
        }
        
        
        
        
        // Call API.
        network.Request(URL: dogService.DogImage.urlRequest) { (result:CustomResults<DogResponse,DogErrorResponse,Error>) in
            switch result{
            case .success(let response):
                print(response)
            case .failure(let error):
                XCTAssertEqual(error.message, MockedResult.message,"issue found in server")
                XCTAssertEqual(error.status, MockedResult.status, "issue found in server")
//                XCTFail("Error was not expected: \(error)")
                
            case .failureError(let error):
                print(error.localizedDescription)
            }
            self.exp.fulfill()
            
        }
        wait(for: [exp], timeout: 10)
    }


}

