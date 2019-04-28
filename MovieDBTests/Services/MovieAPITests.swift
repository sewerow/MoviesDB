//
//  MovieAPITests.swift
//  MovieDBTests
//
//  Created by Oleksandr Liashko on 4/25/19.
//  Copyright © 2019 Liashko, Oleksandr. All rights reserved.
//

import XCTest
@testable import MovieDB
import RxSwift

class MovieAPITests: XCTestCase {
    var bag : DisposeBag!
    var movieService : MovieAPIProtocol!
    
    override func setUp() {
        super.setUp()
        bag = DisposeBag()
        movieService = MovieAPIService()
    }
    
    func testMovieDiscoveryUrlSession() {
        
        let service = MovieAPIService()
        let expecation = XCTestExpectation(description: "list of movies")
        
        service.buildRequest(page: 1).subscribe(onNext: {
            print($0)
            expecation.fulfill()
        }).disposed(by: bag)
        
        wait(for: [expecation], timeout: 50)
    }
    
    func testMovieDiscoveryUrlSessionEncode() {
        
        let service = MovieAPIService()
        let expecation = XCTestExpectation(description: "list of movies")

        service
            .buildRequest(page: 1)
            .map { (data: Data) -> Page? in
                let page : Page? = try? JSONDecoder().decode(Page.self, from: data)
                return page
            }.subscribe(onNext: {
                if $0 != nil {
                    expecation.fulfill()
                } else {
                    XCTAssert(false, "JSON serialization error")
                }
            })
            .disposed(by: bag)
            
        wait(for: [expecation], timeout: 50)
    }
}
