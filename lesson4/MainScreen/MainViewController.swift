//
//  ViewController.swift
//  lesson4
//
//  Created by Тарас Евченко on 08.11.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var resultLabel: UILabel!
    
    private let viewModel = MainViewModel()
    
    private var facts = [Fact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
    }
    
    @IBAction func getDataButton(_ sender: Any) {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(
            UINib(
                nibName: "FactTableViewCell", bundle: .main
            ),
            forCellReuseIdentifier: "myCell"
        )
        
        viewModel.getCatsData()
    }
    
}

extension MainViewController: MainViewModelDelegate {
    
    func dataDidReciveCatsData(data: [Fact]) {
        DispatchQueue.main.async {[weak self] in
            self?.resultLabel.textColor = .black
            self?.resultLabel.text = "Данные загружены"
            self?.facts = data
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {[weak self] in
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
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return facts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as? FactTableViewCell {
            cell.cunfigure(factText: facts[indexPath.row].text)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
}

