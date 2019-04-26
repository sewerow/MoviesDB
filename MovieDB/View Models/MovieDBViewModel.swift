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
    func willDislplay(indexPath: IndexPath)
}

class MovieDBViewModel : MovieDBViewModelProtocol {
    
    var movies = BehaviorRelay<[Dictionary<String, Any>]>(value: [])
    var moviesDescription : MoviesDescription = []
    
    var pageNumber : Int = 1
    var loading = false
    
    let movieApiService : MovieAPIProtocol
    let bag = DisposeBag()
    
    init(movieApiService : MovieAPIProtocol) {
        self.movieApiService = movieApiService
        bind()
    }
    
    private func bind() {
        requestPage()
    }
    
    func willDislplay(indexPath: IndexPath) {
        if indexPath.row == movies.value.count-1 && loading == false {
            requestPage()
        }
    }
    
    func requestPage() {
        loading = true
        movieApiService.discoverMovies(page: self.pageNumber).map({ dictionary in
            guard let results = dictionary.object(forKey: "results") as? MoviesDescription else {
                return self.moviesDescription
            }
            
            self.loading = false
            self.pageNumber += 1
            
            self.moviesDescription.append(contentsOf: results)
            return self.moviesDescription
            
        }).bind(to: movies).disposed(by: bag)
    }
}
