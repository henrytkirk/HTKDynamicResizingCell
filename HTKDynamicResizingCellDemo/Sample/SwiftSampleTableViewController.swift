//
//  SwiftSampleTableViewController.swift
//  HTKDynamicResizingCellDemo
//
//  Created by Ben on 04/12/2014.
//  Copyright (c) 2014 bcylin. All rights reserved.
//

import UIKit

@objc class SwiftSampleTableViewController: UITableViewController {

    var dataArray: [[NSObject: AnyObject]] = []
    var sizeCache = NSCache()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Swift Table View"

        // Load sample data into the array
        if let filePath = NSBundle.mainBundle().pathForResource("SampleData", ofType: "plist") {
            if let data = NSArray(contentsOfFile: filePath) as? [[NSObject: AnyObject]] {
                self.dataArray = data
            }
        }

        // Register cell classes
        self.tableView!.registerClass(SwiftSampleTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(SwiftSampleTableViewCell.self))
        self.tableView!.estimatedRowHeight = 44
        self.tableView!.rowHeight = UITableViewAutomaticDimension
    }

    // MARK: - UITableViewDataSource

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(NSStringFromClass(SwiftSampleTableViewCell.self)) as SwiftSampleTableViewCell

        // Configure the cell
        let dataDict = self.dataArray[indexPath.row]
        let image = UIImage(named: "pic\(arc4random_uniform(10) + 1)")
        cell.setupCellWithData(dataDict, image: image)

        return cell
    }

    // MARK: - UITableViewDelegate

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var cellSize: CGSize

        if let value: AnyObject = self.sizeCache.objectForKey("\(indexPath)") {
            cellSize = value.CGSizeValue()
        } else {
            let dataDict = self.dataArray[indexPath.row]
            let defaultSize = SwiftSampleTableViewCell.defaultCellSize

            cellSize = SwiftSampleTableViewCell.sizeForCellWithDefaultSize(defaultSize, setupCellBlock: { (cellToSetup: HTKDynamicResizingCellProtocol!) -> AnyObject! in
                (cellToSetup as? SwiftSampleTableViewCell)?.setupCellWithData(dataDict, image: nil)
                return cellToSetup
            })
            self.sizeCache.setObject(NSValue(CGSize: cellSize), forKey: "\(indexPath)")
        }

        return cellSize.height
    }

}
