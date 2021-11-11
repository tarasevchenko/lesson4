//
//  MainViewModel.swift
//  lesson4
//
//  Created by Тарас Евченко on 08.11.2021.
//

import Foundation
import RealmSwift

protocol MainViewModelDelegate: AnyObject {
    func dataDidReciveCats(data: [Fact])
    func dataDidReciveCatsFromDataBase(data: [Fact])
    func error()
}

class MainViewModel {
    
    weak var delegate: MainViewModelDelegate?
    
    private let localRealm = try! Realm()
    
    func fetchDataFromDataBase() {
        let realmFacts = Array(localRealm.objects(Fact.self))
        
        guard !realmFacts.isEmpty else {
            return
        }
        
        delegate?.dataDidReciveCatsFromDataBase(data: realmFacts)
    }
    
    func getCatsData() {
        let catsUrl = URL(string: "https://cat-fact.herokuapp.com/facts")!
        
        NetworkService.shared.getCatsData(url: catsUrl) {[weak self] cats in
            guard let catsModels = cats else {
                self?.delegate?.error()
                return
            }
            self?.saveFactsToDataBase(models: catsModels)
            self?.delegate?.dataDidReciveCats(data: catsModels)
        }
    }
    
    private func saveFactsToDataBase(models: [Fact]) {
        DispatchQueue.main.async { [weak self] in
            do  {
                try self?.localRealm.write {
                    self?.localRealm.add(models, update: .modified)
                }
            } catch {
                print("database error")
            }
        }
    }
}
