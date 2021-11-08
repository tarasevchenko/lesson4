//
//  MainViewModel.swift
//  lesson4
//
//  Created by Тарас Евченко on 08.11.2021.
//

import Foundation

protocol MainViewModelDelegate: AnyObject {
    func dataDidReciveCatsData(data: [Fact])
    func error()
}

class MainViewModel {
    
    weak var delegate: MainViewModelDelegate?
    
    func getCatsData() {
        let catsUrl = URL(string: "https://cat-fact.herokuapp.com/facts")!
        NetworkService.shared.getCatsData(url: catsUrl) {[weak self] cats in
            guard let catsModels = cats else {
                self?.delegate?.error()
                return
            }
            
            self?.delegate?.dataDidReciveCatsData(data: catsModels)
        }
    }
}
