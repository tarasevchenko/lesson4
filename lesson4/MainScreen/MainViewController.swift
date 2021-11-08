//
//  ViewController.swift
//  lesson4
//
//  Created by Тарас Евченко on 08.11.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!
    
    private let viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
    }
    
    @IBAction func getDataButton(_ sender: Any) {
        viewModel.getCatsData()
    }
    
}

extension MainViewController: MainViewModelDelegate {
    
    func dataDidReciveCatsData(data: [Fact]) {
        DispatchQueue.main.async {[weak self] in
            self?.resultLabel.textColor = .black
            self?.resultLabel.text = data.randomElement()?.text
        }
    }
    
    func error() {
        DispatchQueue.main.async {[weak self] in
            self?.resultLabel.textColor = .red
            self?.resultLabel.text = "Ошибка сети"
        }
    }
    
}

