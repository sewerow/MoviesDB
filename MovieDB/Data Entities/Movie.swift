//
//  Movie.swift
//  MovieDB
//
//  Created by Oleksandr Liashko on 4/25/19.
//  Copyright © 2019 Liashko, Oleksandr. All rights reserved.
//

import Foundation

/// The type describing overall available information about Movie
struct Movie {
    var vote_count : Int64
    var id : Int64
    var video : Bool
    var vote_average : Double
    var title: String
    var popularity: Double
    var poster_path : String
    var original_language: String
    var original_title: String
    var genre_ids: [Int64]
    var backdrop_path : String
    var adult: Bool
    var overview : String
    var release_date: String
}

extension Movie : Decodable { }
