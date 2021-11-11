//
//  DetailViewController.swift
//  lesson4
//
//  Created by Тарас Евченко on 11.11.2021.
//

import UIKit
import RealmSwift

class DetailViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    
    private let localRealm = try! Realm()
    
    var factId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textLabel.text = localRealm.object(ofType: Fact.self, forPrimaryKey: factId)?.text
    }

}
