//
//  MovieInfoViewModel.swift
//  MovieDB
//
//  Created by Oleksandr Liashko on 4/26/19.
//  Copyright © 2019 Liashko, Oleksandr. All rights reserved.
//

import Foundation

protocol MovieInfoViewModelProtocol {
    var description : String { get }
}

class MovieInfoViewModel : MovieInfoViewModelProtocol {
    private let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    var description : String {
        return String("\(self.movie)")
    }
}
