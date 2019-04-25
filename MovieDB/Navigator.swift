//
//  Navigator.swift
//  MovieDB
//
//  Created by Liashko, Oleksandr on 4/25/19.
//  Copyright © 2018 Liashko, Oleksandr. All rights reserved.
//

import Foundation
import UIKit

class Navigator {
    lazy private var defaultStoryboard = UIStoryboard(name: "Main", bundle: nil)

    enum Segue {
        case MovieDB
    }
    
    func show(segue: Segue, sender: UIViewController) {
        switch segue {
        case .MovieDB:
            let vm = MovieDBViewModel()
            let vc = MovieDBViewController.createWith(navigator: self,
                                                      storyboard: sender.storyboard ?? defaultStoryboard,
                                                      viewModel: vm)
            show(target: vc, sender: sender)
        }
    }
    
    private func show(target: UIViewController, sender: UIViewController) {
        if let nav = sender as? UINavigationController {
            nav.pushViewController(target, animated: false)
            return
        }
        
        if let nav = sender.navigationController {
            nav.pushViewController(target, animated: true)
        } else {
            sender.present(target, animated: true, completion: nil)
        }
    }
}