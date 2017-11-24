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
    @IBOutlet weak var downloadingLabel: UILabel!

    var rows = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // hide empty rows
        tableView.tableFooterView = UIView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DataManager.requestData(delegate: self)
    }

    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            downloadingLabel.isHidden = false
            DataManager.requestData(delegate: self)
        }
    }

}

extension ViewController: DataManagerDelegate {

    func requestCompleted(data: [String]?, error: DataManagerError?) {
        DispatchQueue.main.async {
            self.downloadingLabel.isHidden = true
        }

        guard let data = data else {
            return
        }
        DispatchQueue.main.async {
            self.rows = data
            self.tableView.reloadData()
        }
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
