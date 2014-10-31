//
//  HTKRootViewController.m
//  HTKDynamicResizingCell
//
//  Created by Henry T Kirk on 11/1/14.
//  Copyright (c) 2014 Henry T Kirk. All rights reserved.
//

#import "HTKRootViewController.h"
#import "HTKSampleCollectionViewController.h"
#import "HTKSampleTableViewController.h"

// Cell Identifier
static NSString *HTKRootCellIdentifier = @"HTKRootCellIdentifier";

@interface HTKRootViewController ()

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation HTKRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Menu";
    
    self.dataArray = @[@"CollectionView Example", @"TableView Example"];
    
    // Register class
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:HTKRootCellIdentifier];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HTKRootCellIdentifier forIndexPath:indexPath];
    
    // Set menu title
    cell.textLabel.text = self.dataArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    UIViewController *viewController = nil;
    switch (indexPath.row) {
        case 0: {
            viewController = (HTKSampleCollectionViewController *)[[HTKSampleCollectionViewController alloc] init];
            break;
                              
        }
        case 1: {
            viewController = (HTKSampleTableViewController *)[[HTKSampleTableViewController alloc] init];
            break;
            
        }
        default:
            break;
    }
    // Push on stack
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
