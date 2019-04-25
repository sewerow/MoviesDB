//
//  MovieDBViewController.swift
//  MovieDB
//
//  Created by Liashko, Oleksandr on 4/25/19.
//  Copyright © 2018 Liashko, Oleksandr. All rights reserved.
//

import UIKit
import Then

class MovieDBViewController: UIViewController {
    
    private var viewModel: MovieDBViewModelProtocol!
    private var navigator: Navigator!
    
    static func createWith(navigator: Navigator,
                           storyboard: UIStoryboard,
                           viewModel: MovieDBViewModelProtocol) -> MovieDBViewController {
        return storyboard.instantiateViewController(ofType: MovieDBViewController.self).then { vc in
            vc.navigator = navigator
            vc.viewModel = viewModel
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
    }
    
    private func bindUI() {
        
        
    }
    
}
