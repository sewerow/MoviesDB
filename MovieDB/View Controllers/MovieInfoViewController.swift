//
//  MovieInfoViewController.swift
//  MovieDB
//
//  Created by Oleksandr Liashko on 4/26/19.
//  Copyright © 2019 Liashko, Oleksandr. All rights reserved.
//

import UIKit
import Then

class MovieInfoViewController : UIViewController {
    
    @IBOutlet weak var textField: UITextView!
    
    private var navigator: Navigator!
    private var viewModel: MovieInfoViewModelProtocol!

    static func createWith(navigator: Navigator,
                           storyboard: UIStoryboard,
                           viewModel: MovieInfoViewModelProtocol) -> MovieInfoViewController {
        return storyboard.instantiateViewController(ofType: MovieInfoViewController.self).then { vc in
            vc.navigator = navigator
            vc.viewModel = viewModel
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
    }
    
    private func bindUI() {
        textField.text = self.viewModel.description
    }
}
