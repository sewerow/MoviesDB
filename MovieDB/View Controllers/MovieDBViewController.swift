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
        
        self.moviesTableView.rx.modelSelected(Dictionary<String, Any>.self).subscribe{[weak self] model in
            guard let `self` = self else { return }
            `self`.navigator.show(segue: .MovieInfo, sender: `self`, info: model.element ?? [:])
        }.disposed(by: bag)
        
        self.moviesTableView.rx.willDisplayCell.asObservable().subscribe { [weak self] (event: Event<(cell: UITableViewCell, indexPath: IndexPath)>) in
            guard let `self` = self, let indexPath = event.element?.indexPath else { return }
            `self`.viewModel.willDislplay(indexPath: indexPath)
        }.disposed(by: bag)
    }
    
    @IBAction func filter(_ sender: Any) {
        self.viewModel.filterByData()
    }
}
