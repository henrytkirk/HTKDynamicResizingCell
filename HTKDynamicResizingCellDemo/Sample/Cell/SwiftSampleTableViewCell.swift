//
//  SwiftSampleTableViewCell.swift
//  HTKDynamicResizingCellDemo
//
//  Created by Ben on 14/12/2014.
//  Copyright (c) 2014 bcylin. All rights reserved.
//

import UIKit

class SwiftSampleTableViewCell: HTKDynamicResizingTableViewCell {

    // MARK: - Properties

    lazy var sampleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .ScaleAspectFill
        imageView.layer.borderColor = UIColor.darkGrayColor().CGColor
        imageView.layer.borderWidth = 1
        imageView.layer.shouldRasterize = true
        imageView.layer.rasterizationScale = UIScreen.mainScreen().scale
        return imageView
    }()

    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 17)
        label.textColor = UIColor.blackColor()
        label.numberOfLines = 1
        return label
    }()

    lazy var companyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 16)
        label.textColor = UIColor.blackColor()
        label.numberOfLines = 1
        return label
    }()

    lazy var bioLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 15)
        label.textColor = UIColor.darkGrayColor()
        label.numberOfLines = 0
        label.lineBreakMode = .ByWordWrapping
        return label
    }()

    // MARK: - UITableViewCell

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpSubviews()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - Private Methods

    func setUpSubviews() {
        self.backgroundColor = UIColor.whiteColor()
        self.accessoryType = .None
        self.selectionStyle = .None

        self.contentView.autoresizingMask = .FlexibleHeight
        self.contentView.addSubview(self.sampleImageView)
        self.contentView.addSubview(self.nameLabel)
        self.contentView.addSubview(self.companyLabel)
        self.contentView.addSubview(self.bioLabel)
    }
}
