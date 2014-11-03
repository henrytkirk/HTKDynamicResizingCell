//
//  HTKSampleTableViewCell.h
//  HTKDynamicResizingCell
//
//  Created by Henry T Kirk on 11/1/14.
//  Copyright (c) 2014 Henry T Kirk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTKDynamicResizingTableViewCell.h"
#import "HTKDynamicResizingCellProtocol.h"

/**
 * Default cell size. This is required to properly size cells.
 */
#define DEFAULT_CELL_SIZE (CGSize){[[UIScreen mainScreen] bounds].size.width, 85}

/**
 * Sample CollectionViewCell that implements the dynamic sizing protocol.
 */
@interface HTKSampleTableViewCell : HTKDynamicResizingTableViewCell

/**
 * Sets up the cell with data
 */
- (void)setupCellWithData:(NSDictionary *)data andImage:(UIImage *)image;

@end
