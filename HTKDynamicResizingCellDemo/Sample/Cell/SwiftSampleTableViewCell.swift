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

    class var defaultCellSize: CGSize {
        get {
            return CGSize(width: CGRectGetWidth(UIScreen.mainScreen().bounds), height: 85)
        }
    }

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

        self.sampleImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.nameLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.companyLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.bioLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.contentView.autoresizingMask = .FlexibleHeight
        self.contentView.addSubview(self.sampleImageView)
        self.contentView.addSubview(self.nameLabel)
        self.contentView.addSubview(self.companyLabel)
        self.contentView.addSubview(self.bioLabel)

        let views: [NSObject: AnyObject] = [
            "image": self.sampleImageView,
            "name": self.nameLabel,
            "company": self.companyLabel,
            "bio": self.bioLabel
        ]
        let metrics: [NSObject: AnyObject] = [
            "padding": 10,
            "imageSize": 75
        ]

        // Horizontal constraints
        self.contentView.addConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat(
                "H:|-padding-[image(imageSize)]-padding-[name]-padding-|",
                options: nil,
                metrics: metrics,
                views: views
            )
        )
        self.contentView.addConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat(
                "H:|-padding-[image(imageSize)]-padding-[company]-padding-|",
                options: nil,
                metrics: metrics,
                views: views
            )
        )
        self.contentView.addConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat(
                "H:|-padding-[bio]-padding-|",
                options: nil,
                metrics: metrics,
                views: views
            )
        )

        // Vertical constraints
        self.contentView.addConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat(
                "V:|-padding-[image(imageSize)]",
                options: nil,
                metrics: metrics,
                views: views
            )
        )
        self.contentView.addConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat(
                "V:|-padding-[name]-padding-[company]",
                options: nil,
                metrics: metrics,
                views: views
            )
        )
        self.contentView.addConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat(
                "V:[bio]-padding-|",
                options: nil,
                metrics: metrics,
                views: views
            )
        )
        self.contentView.addConstraint(
            NSLayoutConstraint(
                item: self.companyLabel,
                attribute: .Bottom,
                relatedBy: .Equal,
                toItem: self.sampleImageView,
                attribute: .Bottom,
                multiplier: 1,
                constant: 0
            )
        )
        self.contentView.addConstraint(
            NSLayoutConstraint(
                item: self.bioLabel,
                attribute: .Top,
                relatedBy: .Equal,
                toItem: self.sampleImageView,
                attribute: .Bottom,
                multiplier: 1,
                constant: 5
            )
        )

        // Workaround an issue with undefined symbols of "_UILayoutPriorityRequired" and "_UILayoutPriorityDefaultLow"
        let UILayoutPriorityRequired : UILayoutPriority = 1000.0
        let UILayoutPriorityDefaultLow : UILayoutPriority = 250.0

        // Set hugging/compression priorites for all labels
        self.nameLabel.setContentCompressionResistancePriority(UILayoutPriorityRequired, forAxis: .Vertical)
        self.nameLabel.setContentCompressionResistancePriority(UILayoutPriorityDefaultLow, forAxis: .Horizontal)
        self.companyLabel.setContentCompressionResistancePriority(UILayoutPriorityRequired, forAxis: .Vertical)
        self.companyLabel.setContentCompressionResistancePriority(UILayoutPriorityDefaultLow, forAxis: .Horizontal)
        self.bioLabel.setContentCompressionResistancePriority(UILayoutPriorityRequired, forAxis: .Vertical)
        self.bioLabel.setContentCompressionResistancePriority(UILayoutPriorityDefaultLow, forAxis: .Horizontal)

        let defaultSize = self.dynamicType.defaultCellSize
        self.bioLabel.preferredMaxLayoutWidth = defaultSize.width - (metrics["padding"] as CGFloat) * 2
    }

    // MARK: - Public Methods

    func setupCellWithData(data: [NSObject: AnyObject], image: UIImage?) {
        self.nameLabel.text = data["sampleName"] as? String
        self.companyLabel.text = data["sampleCompany"] as? String
        self.bioLabel.text = data["sampleBio"] as? String
        self.sampleImageView.image = image
    }

}
