HTKDynamicResizingCell
======================

Subclassed UITableView/UICollectionView cells that will auto calculate their size so long as AutoLayout constraints are applied correctly. For iOS 7+. Works similar to how iOS 8's auto sizing of cells work.

## Adding to your project:
### Cocoapods

[CocoaPods](http://cocoapods.org) is the recommended way to add HTKScrollingNavigationController to your project.

1. Add a pod entry for HTKScrollingNavigationController to your Podfile `pod 'HTKDynamicResizingCell', '~> 0.0.1'`
2. Install the pod(s) by running `pod install`.
3. Subclass `HTKDynamicResizingTableViewCell` or `HTKDynamicResizingCollectionViewCell` where you wish to use it.
4. Make sure Auto-layout is setup correctly. See comments in classes for help.

### Autolayout Tips:

For AutoLayout to be correct, make sure you complete the following:

1. For height to calculate correctly, set hugging/compression priorites for all labels. This is one of the most important aspects of having the cell size itself. setContentCompressionResistancePriority needs to be set for all labels to UILayoutPriorityRequired on the Vertical axis. This prevents the label from shrinking to satisfy constraints and will not cut off any text. 
    i.e. `[self.label setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];`

2. Set PreferredMaxLayoutWidth for all labels that will have a auto height. This should equal width of cell minus any buffers on sides. 
    i.e `self.label.preferredMaxLayoutWidth = defaultSize - buffers;`

3. Set any imageView's images correctly so they have proper size. Remember if you don't set a fixed width/height on a UIImageView it will use the 1x intrinsic size of the image to calculate a constraint. So if your image isn't sized correctly it will produce an incorrect value.

## Screen shot:

![Sample Screenshot](http://htk-github.s3.amazonaws.com/HTKDynamicResizingCellSS1.png)

## Change log:
v0.0.1: Initial project commit

Questions? Email: henrytkirk@gmail.com or Web: http://www.henrytkirk.info
