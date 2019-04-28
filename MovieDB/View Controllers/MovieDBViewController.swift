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
            cell.textLabel?.text = model.title
        }.disposed(by: bag)
        
        self.moviesTableView.rx.modelSelected(Movie.self).subscribe(onNext: {
            self.navigator.show(segue: .MovieInfo(model: $0), sender: self)
        }).disposed(by: bag)
        
        self.moviesTableView.rx.willDisplayCell.asObservable().subscribe(onNext: {
            self.viewModel.willDislplay(indexPath: $0.indexPath)
        }).disposed(by: bag)
    }
    
    @IBAction func filter(_ sender: Any) {
        self.viewModel.filterByData()
    }
}
