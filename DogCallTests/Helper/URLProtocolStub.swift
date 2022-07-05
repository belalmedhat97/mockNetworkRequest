//
//  URLProtocolStub.swift
//  DogCallTests
//
//  Created by belal medhat on 04/07/2022.
//

import Foundation

class URLProtocolStub: URLProtocol {
    static var loadingHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))?
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    override class func canonicalRequest(for request: URLRequest) -> URLRequest { // 4
        return request
    }
    
    override func startLoading() {
        guard let handler = Self.loadingHandler else {
            print("Loading handler is not set.")
            return
        }
        do {
            let (response, data) = try handler(request)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
    override func stopLoading() {
        // TODO: Add stop loading here
    }
}
