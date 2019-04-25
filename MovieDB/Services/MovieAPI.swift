//
//  MovieAPI.swift
//  MovieDB
//
//  Created by Oleksandr Liashko on 4/25/19.
//  Copyright © 2019 Liashko, Oleksandr. All rights reserved.
//

import Foundation
import RxAlamofire
import RxSwift


protocol MovieAPIProtocol {
    func discoverMovies(page: Int) -> Observable<NSDictionary>
}

class MovieAPIService : MovieAPIProtocol {
    
    enum Constants {
        static let apiKey = "46d63a13f19138a3fcf367ae2ad2cabf"
    }
    
    func discoverMovies(page: Int) -> Observable<NSDictionary> {
        return requestJSON(.get, discoverMoviesRequest(page: page)).map { (r, json )in
            if r.statusCode == 200 {
                return json as! NSDictionary
            }
            
            return NSDictionary()
        }
        
    }
    
    private func discoverMoviesRequest(page number: Int) -> String {
        return discoverMoviesRequest(with: Constants.apiKey, page: number)
    }
    
    private func discoverMoviesRequest(with apiKey: String, page number: Int) -> String {
        return "https://api.themoviedb.org/3/discover/movie?api_key=\(apiKey)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=\(number)"
    }
}
