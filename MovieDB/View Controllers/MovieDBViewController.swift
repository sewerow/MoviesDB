//
//  MovieDBViewController.swift
//  MovieDB
//
//  Created by Liashko, Oleksandr on 4/25/19.
//  Copyright © 2018 Liashko, Oleksandr. All rights reserved.
//

import UIKit
import Then
import RxSwift
import RxCocoa

class MovieDBViewController: UIViewController {
    @IBOutlet weak var moviesTableView: UITableView!
    @IBOutlet weak var filterBttn: UIButton!
    
    private var viewModel: MovieDBViewModelProtocol!
    private var navigator: Navigator!
    private var bag = DisposeBag()
    
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
        self.viewModel.movies.bind(to: moviesTableView.rx.items(cellIdentifier: "DefaultCell")) { row, model, cell in
            cell.textLabel?.text = model["title"] as? String
        }.disposed(by: bag)
        
        self.moviesTableView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            guard let `self` = self else { return }
            `self`.navigator.show(segue: .MovieInfo, sender: `self`)
        }).disposed(by: bag)
    }
}
