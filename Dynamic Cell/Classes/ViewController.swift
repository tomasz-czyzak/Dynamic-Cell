//
//  ViewController.swift
//  Dynamic Cell
//
//  Created by Tomasz Czyzak on 20/10/2017.
//  Copyright © 2017 TC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var rows = Array.buildModelWith(elements: 10)
    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()

        // hide empty rows
        tableView.tableFooterView = UIView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: #selector(updateCell),
                                     userInfo: nil,
                                     repeats: true)

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        timer?.invalidate()
        timer = nil
    }

    @objc func updateCell() {
        let rowNumber = Int(arc4random_uniform(UInt32(rows.count)))

        guard let cell = tableView.cellForRow(at: IndexPath(row: rowNumber, section: 0)) as? DynamicViewCell else {
            return
        }

        // update model
        rows[rowNumber] = String.generateRandomWords()

        // update cell
        tableView.beginUpdates()
        cell.updateWith(value: rows[rowNumber])
        tableView.endUpdates()
    }

}

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "firstCellIdentifier", for: indexPath)
        if let dynamicCell = cell as? DynamicViewCell {
            dynamicCell.configure(data: (row: indexPath.row, value: rows[indexPath.row]))
        }
        return cell
    }

}
