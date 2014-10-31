//
//  HTKDynamicResizingCollectionViewCell.m
//  HTKDynamicResizingCell
//
//  Created by Henry T Kirk on 10/31/14.
//  Copyright (c) 2014 Henry T Kirk. All rights reserved.
//

#import "HTKDynamicResizingCollectionViewCell.h"

@implementation HTKDynamicResizingCollectionViewCell

+ (void)initialize {
    // Create array
    cellArray = [NSMutableArray array];
}

+ (CGSize)sizeForCellWithDefaultSize:(CGSize)defaultSize setupCellBlock:(setupCellBlock)block {

    // Check to see if we have a "sizing" cell to work with
    __block id<HTKDynamicResizingCellProtocol> cell = nil;
    [cellArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[[self class] class]]) {
            cell = obj;
            *stop = YES;
        }
    }];
    
    if (!cell) {
        // Create and add to our static array using default size passed
        cell = [[[self class] alloc] initWithFrame:CGRectMake(0, 0, defaultSize.width, defaultSize.height)];
        [cellArray addObject:cell];
    }
    
    // Get our cell configured in block
    cell = block(cell);
    
    // Determine size. If your constraints aren't setup correctly
    // this won't work. So make sure you:
    //
    // 1. Set ContentCompressionResistancePriority for all labels
    //    i.e. [self.label setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    //
    // 2. Set PreferredMaxLayoutWidth for all labels that will have a
    //    auto height. This should equal width of cell minus any buffers on sides.
    //    i.e self.label.preferredMaxLayoutWidth = defaultSize - buffers;
    //
    // 3. Set any imageView's images correctly. Remember if you don't
    //    set a fixed width/height on a UIImageView it will use the 1x
    //    intrinsic size of the image to calculate a constraint. So if your
    //    image isn't sized correctly it will produce an incorrect value.
    //
    CGSize size = [((UICollectionViewCell *)cell).contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];

    // Return which size is bigger since systemLayoutFittingSize will return
    // the smallest size fitting that fits.
    size.width = MAX(defaultSize.width, size.width);
    
    // Return our size that was calculated
    return size;
}

@end
