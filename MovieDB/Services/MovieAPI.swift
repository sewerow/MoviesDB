//
//  MovieAPI.swift
//  MovieDB
//
//  Created by Oleksandr Liashko on 4/25/19.
//  Copyright © 2019 Liashko, Oleksandr. All rights reserved.
//

import Foundation
import RxSwift

/// A type representing an error value that can be thrown by Movie API
enum ApiError : Error {
    case invalidKey
    case notFound
    case serverFailure
}

/// The protocol describing abstraction of recieveing movies data
protocol MovieAPIProtocol {
    func discoverMovies(page: Int) -> Observable<Data>
}

/// The service pefroming exact job of fetching movies data from server 
class MovieAPIService : MovieAPIProtocol {
    
    
    /// Discover Movies
    ///
    /// - Parameters:
    ///   - page        The exact number of page
    /// - Return:       The data representing movies on the exact page
    func discoverMovies(page: Int) -> Observable<Data> {
        return buildRequest(page: page)
    }
}

extension MovieAPIService {
        
    ///
    /// Private methods to build a request with RxCocoa
    ///
    private func buildRequest(page number: Int) -> Observable<Data> {
        
        let request: Observable<URLRequest> = Observable.create() { observer in
            
            let url = URL(string: self.discoverMoviesRequest(page: number))!
            let request = URLRequest(url: url)
            
            observer.onNext(request)
            observer.onCompleted()
            
            return Disposables.create()
        }
        
        let session = URLSession.shared
        return request.flatMap() { request in
            return session.rx.response(request: request).map() { response, data in
                if 200 ..< 300 ~= response.statusCode {
                    return data
                } else if response.statusCode == 401 {
                    throw ApiError.invalidKey
                } else if 400 ..< 500 ~= response.statusCode {
                    throw ApiError.notFound
                } else {
                    throw ApiError.serverFailure
                }
            }
        }
    }
    
    private enum Constants {
        static let apiKey = "46d63a13f19138a3fcf367ae2ad2cabf"
    }
    
    private func discoverMoviesRequest(with apiKey: String = Constants.apiKey, page number: Int) -> String {
        return "https://api.themoviedb.org/3/discover/movie?api_key=\(apiKey)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=\(number)"
    }
}
