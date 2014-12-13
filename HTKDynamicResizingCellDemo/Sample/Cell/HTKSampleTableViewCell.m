//
//  HTKSampleTableViewCell.m
//  HTKDynamicResizingCell
//
//  Created by Henry T Kirk on 11/1/14.
//
//  Copyright (c) 2014 Henry T. Kirk (http://www.henrytkirk.info)
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.


#import "HTKSampleTableViewCell.h"

@interface HTKSampleTableViewCell ()

/**
 * ImageView that shows sample picture
 */
@property (nonatomic, strong) UIImageView *sampleImageView;

/**
 * Label that is name of sample person
 */
@property (nonatomic, strong) UILabel *nameLabel;

/**
 * Label that is name of sample company
 */
@property (nonatomic, strong) UILabel *companyLabel;

/**
 * Label that displays sample "bio".
 */
@property (nonatomic, strong) UILabel *bioLabel;

@end

@implementation HTKSampleTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    
    self.backgroundColor = [UIColor whiteColor];
    self.accessoryType = UITableViewCellAccessoryNone;
    self.accessoryView = nil;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Fix for contentView constraint warning
    [self.contentView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    
    // Create our ImageView
    self.sampleImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.sampleImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.sampleImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.sampleImageView.layer.borderColor = [[UIColor darkGrayColor] CGColor];
    self.sampleImageView.layer.borderWidth = 1;
    self.sampleImageView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.sampleImageView];
    
    // Name label
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.nameLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:17];
    self.nameLabel.textColor = [UIColor blackColor];
    self.nameLabel.numberOfLines = 1;
    [self.contentView addSubview:self.nameLabel];
    
    // Company label
    self.companyLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.companyLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.companyLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:16];
    self.companyLabel.textColor = [UIColor blackColor];
    self.companyLabel.numberOfLines = 1;
    [self.contentView addSubview:self.companyLabel];
    
    // Bio label
    self.bioLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.bioLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.bioLabel.numberOfLines = 0; // Must be set for multi-line label to work
    self.bioLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.bioLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
    self.bioLabel.textColor = [UIColor darkGrayColor];
    [self.contentView addSubview:self.bioLabel];
    
    // Constrain
    NSDictionary *viewDict = NSDictionaryOfVariableBindings(_sampleImageView, _nameLabel, _companyLabel, _bioLabel);
    // Create a dictionary with buffer values
    NSDictionary *metricDict = @{@"sideBuffer" : @10, @"verticalBuffer" : @10, @"imageSize" : @75};
    
    // Constrain elements horizontally
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-sideBuffer-[_sampleImageView(imageSize)]-sideBuffer-[_nameLabel]-sideBuffer-|" options:0 metrics:metricDict views:viewDict]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-sideBuffer-[_sampleImageView(imageSize)]-sideBuffer-[_companyLabel]-sideBuffer-|" options:0 metrics:metricDict views:viewDict]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-sideBuffer-[_bioLabel]-sideBuffer-|" options:0 metrics:metricDict views:viewDict]];
    
    // Constrain elements vertically
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-verticalBuffer-[_sampleImageView(imageSize)]" options:0 metrics:metricDict views:viewDict]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-verticalBuffer-[_nameLabel]-verticalBuffer-[_companyLabel]" options:0 metrics:metricDict views:viewDict]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_bioLabel]-verticalBuffer-|" options:0 metrics:metricDict views:viewDict]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.companyLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.sampleImageView attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.bioLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.sampleImageView attribute:NSLayoutAttributeBottom multiplier:1 constant:5]];
    
    // Set hugging/compression priorites for all labels.
    // This is one of the most important aspects of having the cell size
    // itself. setContentCompressionResistancePriority needs to be set
    // for all labels to UILayoutPriorityRequired on the Vertical axis.
    // This prevents the label from shrinking to satisfy constraints and
    // will not cut off any text.
    // Setting setContentCompressionResistancePriority to UILayoutPriorityDefaultLow
    // for Horizontal axis makes sure it will shrink the width where needed.
    [self.nameLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.nameLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [self.companyLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.companyLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [self.bioLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.bioLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    
    // Set max layout width for all multi-line labels
    // This is required for any multi-line label. If you
    // do not set this, you'll find the auto-height will not work
    // this is because "intrinsicSize" of a label is equal to
    // the minimum size needed to fit all contents. So if you
    // do not have a max width it will not constrain the width
    // of the label when calculating height.
    CGSize defaultSize = [[self class] defaultCellSize];
    self.bioLabel.preferredMaxLayoutWidth = defaultSize.width - ([metricDict[@"sideBuffer"] floatValue] * 2);
}

- (void)setupCellWithData:(NSDictionary *)data andImage:(UIImage *)image {
    
    // Pull out sample data
    NSString *nameString = data[@"sampleName"];
    NSString *companyString = data[@"sampleCompany"];
    NSString *bioString = data[@"sampleBio"];
    
    // Set values
    self.nameLabel.text = nameString;
    self.companyLabel.text = companyString;
    self.bioLabel.text = bioString;
    
    self.sampleImageView.image = image;
}

+ (CGSize)defaultCellSize {
    return (CGSize){CGRectGetWidth([[UIScreen mainScreen] bounds]), 85};
}

@end
