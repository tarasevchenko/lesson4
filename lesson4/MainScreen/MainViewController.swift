//
//  ViewController.swift
//  lesson4
//
//  Created by Тарас Евченко on 08.11.2021.
//

import UIKit
import RealmSwift
import Foundation

class MainViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var resultLabel: UILabel!
    
    private let viewModel = MainViewModel()
    
    private var facts = [Fact]()
    private var selectedFactId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.fetchDataFromDataBase()
        configureTableView()
    }
    
    @IBAction func getDataButton(_ sender: Any) {
        viewModel.getCatsData()
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(
            UINib(
                nibName: "FactTableViewCell", bundle: .main
            ),
            forCellReuseIdentifier: "myCell"
        )
    }
    
}

extension MainViewController: MainViewModelDelegate {
    func dataDidReciveCatsFromDataBase(data: [Fact]) {
        self.facts = data
        DispatchQueue.main.async {[weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func dataDidReciveCats(data: [Fact]) {
        DispatchQueue.main.async {[weak self] in
            self?.facts = data
            self?.resultLabel.textColor = .black
            self?.resultLabel.text = "Данные загружены"
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {[weak self] in
                self?.tableView.reloadData()
                self?.resultLabel.isHidden = true
            }
        }
    }
    
    func error() {
        DispatchQueue.main.async {[weak self] in
            self?.resultLabel.textColor = .red
            self?.resultLabel.text = "Ошибка сети"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destVc = segue.destination as? DetailViewController,
           let factId = selectedFactId {
            destVc.factId = factId
        }
    }
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return facts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as? FactTableViewCell {
            cell.configure(factText: facts[indexPath.row].text ?? "")
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedFactId = facts[indexPath.row].id
        performSegue(withIdentifier: "detailVC", sender: self)
    }
    
}

