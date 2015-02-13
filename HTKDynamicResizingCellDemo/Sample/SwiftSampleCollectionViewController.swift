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
    var sizeCache = NSCache()

    override init() {
        let layout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: layout)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Swift Collection View"

        // Load sample data into the array
        if let filePath = NSBundle.mainBundle().pathForResource("SampleData", ofType: "plist") {
            if let data = NSArray(contentsOfFile: filePath) as? [[NSObject: AnyObject]] {
                dataArray = data
            }
        }

        // Setup collection view layout
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 1
        layout.sectionInset = UIEdgeInsetsZero
        collectionView!.collectionViewLayout = layout

        // Register cell classes
        collectionView!.registerClass(SwiftSampleCollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(SwiftSampleCollectionViewCell.self))
        collectionView!.backgroundColor = UIColor.lightGrayColor()
    }

    // MARK: - UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(NSStringFromClass(SwiftSampleCollectionViewCell.self), forIndexPath: indexPath) as SwiftSampleCollectionViewCell

        // Configure the cell
        let dataDict = dataArray[indexPath.row]
        let image = UIImage(named: "pic\(arc4random_uniform(10) + 1)")
        cell.setupCellWithData(dataDict, image: image)

        return cell
    }

    // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        var cellSize: CGSize

        if let value: AnyObject = sizeCache.objectForKey("\(indexPath)") {
            cellSize = value.CGSizeValue()
        } else {
            let dataDict = dataArray[indexPath.row]
            let defaultSize = SwiftSampleCollectionViewCell.defaultCellSize

            cellSize = SwiftSampleCollectionViewCell.sizeForCellWithDefaultSize(defaultSize, setupCellBlock: { (cellToSetup: HTKDynamicResizingCellProtocol!) -> AnyObject! in
                (cellToSetup as? SwiftSampleCollectionViewCell)?.setupCellWithData(dataDict, image: nil)
                return cellToSetup
            })
            sizeCache.setObject(NSValue(CGSize: cellSize), forKey: "\(indexPath)")
        }

        return cellSize
    }
}
