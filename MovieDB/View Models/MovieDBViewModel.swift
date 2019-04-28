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
    typealias MovieDescription = Movie
    typealias MoviesDescription = [MovieDescription]
    
    var movies : BehaviorRelay<MoviesDescription> { get }
    func willDislplay(indexPath: IndexPath)
    func filterByData()
}

class MovieDBViewModel : MovieDBViewModelProtocol {
    
    var movies = BehaviorRelay<MoviesDescription>(value: [])
    
    private var moviesDescription : MoviesDescription = []
    private var sortMoviesDescription : MoviesDescription = []
    
    private var pageNumber : Int = 1
    private var loading = false
    
    private let newPageTrigger = PublishSubject<(pageNumber: Int, loading: Bool)>()
    private let bag = DisposeBag()
    
    private let movieApiService : MovieAPIProtocol
    
    init(movieApiService : MovieAPIProtocol) {
        self.movieApiService = movieApiService
        bind()
    }
    
    private func bind() {
        
        //doon
        
        newPageTrigger
            .filter({ (_: Int, loading: Bool) -> Bool in return loading == false })
            .do(onNext: { _ in self.loading = true })
            .flatMap { (pageNumber: Int, loading: Bool) -> Observable<MoviesDescription> in
                
                return self.movieApiService.discoverMovies(page: pageNumber)
                    .map({ dataPage in
                        
                        guard let page = try? JSONDecoder().decode(Page.self, from: dataPage) else {
                            return self.moviesDescription
                        }
                        
                        self.moviesDescription.append(contentsOf: page.results)
                        
                        let sorted = page.results.sorted(by: { return $0.release_date > $1.release_date })
                        self.sortMoviesDescription.append(contentsOf: sorted)
                        
                        return self.moviesDescription
                        
                    }).do(onNext: { _ in
                        self.pageNumber += 1
                        self.loading = false
                    }).catchError({ (error) -> Observable<[Movie]> in
                        print("errot has occured \(error)")
                        self.loading = false
                        return Observable.just(self.moviesDescription)
                    })
            }.bind(to: movies).disposed(by: bag)
        
        newPageTrigger.onNext((self.pageNumber, self.loading))
    }
    
    func willDislplay(indexPath: IndexPath) {
        if indexPath.row == movies.value.count-1 {
            newPageTrigger.onNext((self.pageNumber, self.loading))
        }
    }
    
    func filterByData() {
        moviesDescription = sortMoviesDescription
        movies.accept(moviesDescription)
    }
}
