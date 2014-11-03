//
//  HTKSampleTableViewController.m
//  HTKDynamicResizingCell
//
//  Created by Henry T Kirk on 11/1/14.
//  Copyright (c) 2014 Henry T Kirk. All rights reserved.
//

#import "HTKSampleTableViewController.h"
#import "HTKSampleTableViewCell.h"

/**
 * Cell identifier for the sample cell
 */
static NSString *HTKSampleTableViewCellIdentifier = @"HTKSampleTableViewCellIdentifier";

@interface HTKSampleTableViewController ()

/**
 * Array that holds our sample data
 */
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation HTKSampleTableViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    
    self.title = @"TableView Sample";
    
    self.dataArray = [NSMutableArray array];
    
    // Load sample data into the array
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"SampleData" ofType:@"plist"];
    [self.dataArray addObjectsFromArray:[NSArray arrayWithContentsOfFile:filePath]];
}

- (void)loadView {
    
    // Setup our TableView
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Register our cell
    [self.tableView registerClass:[HTKSampleTableViewCell class] forCellReuseIdentifier:HTKSampleTableViewCellIdentifier];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HTKSampleTableViewCell *cell = (HTKSampleTableViewCell *)[tableView dequeueReusableCellWithIdentifier:HTKSampleTableViewCellIdentifier forIndexPath:indexPath];
    
    // Load data
    NSDictionary *dataDict = self.dataArray[indexPath.row];
    // Sample image
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"pic%i", arc4random_uniform(10) + 1]];
    [cell setupCellWithData:dataDict andImage:image];
        
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    __weak typeof(self) weakSelf = self;
    CGSize defaultSize = DEFAULT_CELL_SIZE;
    
    // Create our size
    CGSize cellSize = [HTKSampleTableViewCell sizeForCellWithDefaultSize:defaultSize setupCellBlock:^id(id<HTKDynamicResizingCellProtocol> cellToSetup) {
        // set values - there's no need to set the image here
        // because we have height and width constraints set, so
        // nil image will end up measuring to that size. If you don't
        // set the image contraints, it will end up being it's 1x intrinsic
        // size of the image, so you should set a default image when you
        // create the cell.
        NSDictionary *dataDict = weakSelf.dataArray[indexPath.row];
        [((HTKSampleTableViewCell *)cellToSetup) setupCellWithData:dataDict andImage:nil];
        
        // return cell
        return cellToSetup;
    }];
    
    return cellSize.height;
}

@end
