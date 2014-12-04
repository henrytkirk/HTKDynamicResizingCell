//
//  HTKRootViewController.m
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


#import "HTKRootViewController.h"
#import "HTKSampleCollectionViewController.h"
#import "HTKSampleTableViewController.h"
#import "HTKDynamicResizingCellDemo-Swift.h"

// Cell Identifier
static NSString *HTKRootCellIdentifier = @"HTKRootCellIdentifier";

@interface HTKRootViewController ()

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation HTKRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Menu";
    
    self.dataArray = @[@"CollectionView Example",
                       @"TableView Example",
                       @"Swift CollectionView Example",
                       @"Swift TableView Example"];
    
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
        case 2: {
            viewController = [[SwiftSampleCollectionViewController alloc] init];
            break;
        }
        case 3: {
            viewController = [[SwiftSampleTableViewController alloc] init];
            break;
        }
        default:
            break;
    }
    // Push on stack
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
