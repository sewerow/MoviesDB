//
//  MovieDBViewModel.swift
//  MovieDB
//
//  Created by Liashko, Oleksandr on 4/25/19.
//  Copyright © 2018 Liashko, Oleksandr. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol MovieDBViewModelProtocol {
    typealias MovieDescription = Dictionary<String, Any>
    typealias MoviesDescription = [MovieDescription]
    var movies : BehaviorRelay<MoviesDescription> { get }
}

class MovieDBViewModel : MovieDBViewModelProtocol {
    var movies = BehaviorRelay<[Dictionary<String, Any>]>(value: [])
    
    let movieApiService : MovieAPIProtocol
    let bag = DisposeBag()
    
    init(movieApiService : MovieAPIProtocol) {
        self.movieApiService = movieApiService
        bind()
    }
    
    private func bind() {
        movieApiService.discoverMovies(page: 1).map({ dictionary in
            let results = dictionary.object(forKey: "results") as? MoviesDescription
            return results ?? []
        }).bind(to: movies).disposed(by: bag)
    }
}
