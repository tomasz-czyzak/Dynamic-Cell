//
//  DynamicViewCell.swift
//  Dynamic Cell
//
//  Created by Tomasz Czyzak on 20/10/2017.
//  Copyright © 2017 TC. All rights reserved.
//

import UIKit

class DynamicViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!

    func configure(data: (row: Int, value:String)) {
        nameLabel.text = "\(data.row)"
        valueLabel.text = data.value
    }

    func updateWith(value: String?) {
        valueLabel.text = value
    }

}
