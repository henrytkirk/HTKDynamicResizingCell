//
//  SwiftSampleCollectionViewController.swift
//  HTKDynamicResizingCellDemo
//
//  Created by Ben on 04/12/2014.
//  Copyright (c) 2014 bcylin. All rights reserved.
//

import UIKit

@objc class SwiftSampleCollectionViewController: UICollectionViewController {

    var dataArray: [[NSObject: AnyObject]] = []

    init() {
        let layout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: layout)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Swift Collection View"

        // Load sample data into the array
        if let filePath = NSBundle.mainBundle().pathForResource("SampleData", ofType: "plist") {
            if let data = NSArray(contentsOfFile: filePath) as? [[NSObject: AnyObject]] {
                self.dataArray = data
            }
        }

        // Setup collection view layout
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 1
        layout.sectionInset = UIEdgeInsetsZero
        self.collectionView!.collectionViewLayout = layout

        // Register cell classes
        self.collectionView!.registerClass(HTKSampleCollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(HTKSampleCollectionViewCell.self))
        self.collectionView!.backgroundColor = UIColor.lightGrayColor()
    }

    // MARK: - UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArray.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(NSStringFromClass(HTKSampleCollectionViewCell.self), forIndexPath: indexPath) as! HTKSampleCollectionViewCell

        // Configure the cell
        let dataDict = self.dataArray[indexPath.row]
        let image = UIImage(named: "pic\(arc4random_uniform(10) + 1)")
        cell.setupCellWithData(dataDict, andImage: image)

        return cell
    }

    // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let dataDict = self.dataArray[indexPath.row]
        let defaultSize = HTKSampleCollectionViewCell.defaultCellSize()

        let cellSize = HTKSampleCollectionViewCell.sizeForCellWithDefaultSize(defaultSize, setupCellBlock: { (cellToSetup: HTKDynamicResizingCellProtocol!) -> AnyObject! in
            (cellToSetup as? HTKSampleCollectionViewCell)?.setupCellWithData(dataDict, andImage: nil)
            return cellToSetup
        })

        return cellSize
    }
}
