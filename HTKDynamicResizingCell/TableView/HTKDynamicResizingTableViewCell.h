//
//  HTKDynamicResizingTableViewCell.h
//  HTKDynamicResizingCell
//
//  Created by Henry T Kirk on 10/31/14.
//  Copyright (c) 2014 Henry T Kirk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTKDynamicResizingCellProtocol.h"

/**
 * Class that implements Dynamic resizing protocol. Subclass this
 * to work with auto resizing of cells.
 */
@interface HTKDynamicResizingTableViewCell : UITableViewCell <HTKDynamicResizingCellProtocol>

@end
