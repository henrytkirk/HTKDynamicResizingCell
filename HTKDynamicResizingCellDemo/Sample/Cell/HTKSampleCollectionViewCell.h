//
//  HTKSampleCollectionViewCell.h
//  HTKDynamicResizingCell
//
//  Created by Henry T Kirk on 10/31/14.
//  Copyright (c) 2014 Henry T Kirk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTKDynamicResizingCollectionViewCell.h"
#import "HTKDynamicResizingCellProtocol.h"

/**
 * Default cell size. This is required to properly size cells.
 */
#define DEFAULT_CELL_SIZE (CGSize){[[UIScreen mainScreen] bounds].size.width, 80}

/**
 * Sample CollectionViewCell that implements the dynamic sizing protocol.
 */
@interface HTKSampleCollectionViewCell : HTKDynamicResizingCollectionViewCell

/**
 * Sets up the cell with data
 */
- (void)setupCellWithData:(NSDictionary *)data andImage:(UIImage *)image;

@end
