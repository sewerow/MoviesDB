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
    
    func testMovieDiscovery() {
        let expecation = XCTestExpectation(description: "list of movies")
        
        movieService.discoverMovies(page: 1).subscribe { data in
            XCTAssertTrue(data.element?.count != 0)
            expecation.fulfill()
        }.disposed(by: bag)
        
        wait(for: [expecation], timeout: 50)
    }
}
