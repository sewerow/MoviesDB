//
//  AppDelegate.swift
//  MovieDB
//
//  Created by Liashko, Oleksandr on 4/25/19.
//  Copyright © 2018 Liashko, Oleksandr. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let navigator = Navigator()
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let navigationCntrl = window!.rootViewController as! UINavigationController
        navigator.show(segue: .MovieDB, sender: navigationCntrl)
        return true
    }
}
