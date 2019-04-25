//
//  General.swift
//  MovieDB
//
//  Created by Liashko, Oleksandr on 4/25/19.
//  Copyright © 2018 Liashko, Oleksandr. All rights reserved.
//

import Foundation

protocol ValidProtocol {
    var isValid : Bool { get }
}

enum LocationStatus {
    case inside, outside
}

enum NetworkWiFIStatus {
    case unknown
    case connected(name: String)
}

