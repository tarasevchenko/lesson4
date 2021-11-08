//
//  FactTableViewCell.swift
//  lesson4
//
//  Created by Тарас Евченко on 08.11.2021.
//

import UIKit

class FactTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var factLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(factText: String) {
        factLabel.text = factText
    }
}
