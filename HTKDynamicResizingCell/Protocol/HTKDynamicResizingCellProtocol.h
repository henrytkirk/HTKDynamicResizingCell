//
//  HTKDynamicResizingCellProtocol.h
//  HTKDynamicResizingCell
//
//  Created by Henry T Kirk on 10/31/14.
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


/**
 * Protocol used to implement dynamic resizing of UITableView and
 * UICollectionView cells. When implementing AutoLayout in your 
 * cells, you need to make sure you complete the following:
 *
 * 1. Set ContentCompressionResistancePriority for all labels
 *    i.e. [self.label setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
 *
 * 2. Set PreferredMaxLayoutWidth for all labels that will have a
 *    auto height. This should equal width of cell minus any buffers on sides.
 *    i.e self.label.preferredMaxLayoutWidth = defaultSize - buffers;
 *
 * 3. Set any imageView's images correctly. Remember if you don't
 *    set a fixed width/height on a UIImageView it will use the 1x
 *    intrinsic size of the image to calculate a constraint. So if your
 *    image isn't sized correctly it will produce an incorrect value.
 */
@protocol HTKDynamicResizingCellProtocol;

/**
 * Estimated width of the UITableViewCell accessory width.
 * Used to adjust preferredMaxWidth on labels. You need to 
 * factor this in when setting max width if your accessoryType
 * is anything other than UITableViewCellAccessoryNone.
 */
static CGFloat HTKDynamicTableViewCellAccessoryWidth = 33; // appx size measured

/**
 * Array that holds a single cell we use for "sizing" and measuring.
 * You use this to hold different cells you wish to calculate size
 * on. You don't want to create a cell each time to size with, that
 * would result in poor performance.
 *
 * Simply create a instance of your cell and add it to this array
 * to reuse.
 */
static NSMutableArray *cellArray;

/**
 * Block used to setup the cell prior to measuring the size.
 * You will configure the cellToSetup with all of your label/image
 * values as needed.
 */
typedef id (^setupCellBlock)(id<HTKDynamicResizingCellProtocol> cellToSetup);

@protocol HTKDynamicResizingCellProtocol <NSObject>

/**
 * Class method that you pass in the default cell size. You will configure
 * the cell's labels (and nil images in most cases) in the block.
 * 
 * The default size passed should be used to init your "sizing" cell and
 * assist with setting max/min sizes.
 */
+ (CGSize)sizeForCellWithDefaultSize:(CGSize)defaultSize setupCellBlock:(setupCellBlock)block;

@end