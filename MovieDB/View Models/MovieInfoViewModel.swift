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
    let info: Dictionary<String, Any>
    
    init(info: Dictionary<String, Any>) {
        self.info = info
    }
    
    var description : String {
        return info.description
    }
}
