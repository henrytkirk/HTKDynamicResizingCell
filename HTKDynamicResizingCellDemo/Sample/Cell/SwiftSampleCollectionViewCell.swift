//
//  SwiftSampleCollectionViewCell.swift
//  HTKDynamicResizingCellDemo
//
//  Created by Ben on 16/12/2014.
//  Copyright (c) 2014 bcylin. All rights reserved.
//

import UIKit

class SwiftSampleCollectionViewCell: HTKDynamicResizingCollectionViewCell {

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

    // MARK: - UICollectionViewCell

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpSubviews()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - Private Methods

    func setUpSubviews() {
        backgroundColor = UIColor.whiteColor()

        sampleImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        nameLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        companyLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        bioLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        contentView.autoresizingMask = .FlexibleHeight
        contentView.addSubview(sampleImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(companyLabel)
        contentView.addSubview(bioLabel)

        let views: [NSObject: AnyObject] = [
            "image": sampleImageView,
            "name": nameLabel,
            "company": companyLabel,
            "bio": bioLabel
        ]
        let metrics: [NSObject: AnyObject] = [
            "padding": 10,
            "imageSize": 75
        ]

        // Horizontal constraints
        contentView.addConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat(
                "H:|-padding-[image(imageSize)]-padding-[name]-padding-|",
                options: nil,
                metrics: metrics,
                views: views
            )
        )
        contentView.addConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat(
                "H:|-padding-[image(imageSize)]-padding-[company]-padding-|",
                options: nil,
                metrics: metrics,
                views: views
            )
        )
        contentView.addConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat(
                "H:|-padding-[bio]-padding-|",
                options: nil,
                metrics: metrics,
                views: views
            )
        )

        // Vertical constraints
        contentView.addConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat(
                "V:|-padding-[image(imageSize)]",
                options: nil,
                metrics: metrics,
                views: views
            )
        )
        contentView.addConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat(
                "V:|-padding-[name]-padding-[company]",
                options: nil,
                metrics: metrics,
                views: views
            )
        )
        contentView.addConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat(
                "V:[bio]-padding-|",
                options: nil,
                metrics: metrics,
                views: views
            )
        )
        contentView.addConstraint(
            NSLayoutConstraint(
                item: companyLabel,
                attribute: .Bottom,
                relatedBy: .Equal,
                toItem: sampleImageView,
                attribute: .Bottom,
                multiplier: 1,
                constant: 0
            )
        )
        contentView.addConstraint(
            NSLayoutConstraint(
                item: bioLabel,
                attribute: .Top,
                relatedBy: .Equal,
                toItem: sampleImageView,
                attribute: .Bottom,
                multiplier: 1,
                constant: 5
            )
        )

        // Workaround an issue with undefined symbols of "_UILayoutPriorityRequired" and "_UILayoutPriorityDefaultLow"
        let UILayoutPriorityRequired : UILayoutPriority = 1000.0
        let UILayoutPriorityDefaultLow : UILayoutPriority = 250.0

        // Set hugging/compression priorites for all labels
        nameLabel.setContentCompressionResistancePriority(UILayoutPriorityRequired, forAxis: .Vertical)
        nameLabel.setContentCompressionResistancePriority(UILayoutPriorityDefaultLow, forAxis: .Horizontal)
        companyLabel.setContentCompressionResistancePriority(UILayoutPriorityRequired, forAxis: .Vertical)
        companyLabel.setContentCompressionResistancePriority(UILayoutPriorityDefaultLow, forAxis: .Horizontal)
        bioLabel.setContentCompressionResistancePriority(UILayoutPriorityRequired, forAxis: .Vertical)
        bioLabel.setContentCompressionResistancePriority(UILayoutPriorityDefaultLow, forAxis: .Horizontal)

        let defaultSize = self.dynamicType.defaultCellSize
        bioLabel.preferredMaxLayoutWidth = defaultSize.width - (metrics["padding"] as CGFloat) * 2
    }

    // MARK: - Public Methods

    func setupCellWithData(data: [NSObject: AnyObject], image: UIImage?) {
        nameLabel.text = data["sampleName"] as? String
        companyLabel.text = data["sampleCompany"] as? String
        bioLabel.text = data["sampleBio"] as? String
        sampleImageView.image = image
    }

}
