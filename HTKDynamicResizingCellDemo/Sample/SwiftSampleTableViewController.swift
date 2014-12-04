//
//  SwiftSampleTableViewController.swift
//  HTKDynamicResizingCellDemo
//
//  Created by Ben on 04/12/2014.
//  Copyright (c) 2014 bcylin. All rights reserved.
//

import UIKit

@objc class SwiftSampleTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Swift Table View"
    }

    // MARK: - UITableViewDataSource

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

}
