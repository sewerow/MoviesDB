//
//  Page.swift
//  MovieDB
//
//  Created by Oleksandr Liashko on 4/26/19.
//  Copyright © 2019 Liashko, Oleksandr. All rights reserved.
//

import Foundation

/// The Page type represents portion of data recieving from server.
/// Each responce from API contains exact structure of information as Page type.
struct Page {
    var page : Int
    var total_results : Int
    var total_pages : Int
    var results : [Movie]
}

extension Page : Decodable { }
