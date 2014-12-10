//
//  HTKSampleCollectionViewController.m
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


#import "HTKSampleCollectionViewController.h"
#import "HTKDynamicResizingCollectionViewCell.h"
#import "HTKSampleCollectionViewCell.h"

/**
 * Cell identifier for the sample cell
 */
static NSString *HTKSampleCollectionViewCellIdentifier = @"HTKSampleCollectionViewCellIdentifier";

@interface HTKSampleCollectionViewController () <UICollectionViewDelegateFlowLayout>

/**
 * Array that holds our sample data
 */
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation HTKSampleCollectionViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {

    self.title = @"CollectionView Sample";

    self.dataArray = [NSMutableArray array];
    
    // Load sample data into the array
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"SampleData" ofType:@"plist"];
    [self.dataArray addObjectsFromArray:[NSArray arrayWithContentsOfFile:filePath]];
}

- (void)loadView {
    // Setup our CollectionViewLayout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 1;
    layout.sectionInset = UIEdgeInsetsZero;

    // Setup our CollectionView
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    // Set BG color to light gray. Since we have minimumLineSpacing
    // set to 1, this is a cheap way to create "cell separators", but
    // wouldn't recommend this way. It's just for example.
    self.collectionView.backgroundColor = [UIColor lightGrayColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Register our cell
    [self.collectionView registerClass:[HTKSampleCollectionViewCell class] forCellWithReuseIdentifier:HTKSampleCollectionViewCellIdentifier];
}

#pragma mark - UICollectionView Delegates

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // Get cell
    HTKSampleCollectionViewCell *cell = (HTKSampleCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:HTKSampleCollectionViewCellIdentifier forIndexPath:indexPath];
    
    // Load data
    NSDictionary *dataDict = self.dataArray[indexPath.row];
    // Sample image
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"pic%i", arc4random_uniform(10) + 1]];
    [cell setupCellWithData:dataDict andImage:image];

    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    __weak typeof(self) weakSelf = self;
    CGSize defaultSize = [HTKSampleCollectionViewCell defaultCellSize];
    
    // Create our size
    return [HTKSampleCollectionViewCell sizeForCellWithDefaultSize:defaultSize setupCellBlock:^id(id<HTKDynamicResizingCellProtocol> cellToSetup) {
        // set values - there's no need to set the image here
        // because we have height and width constraints set, so
        // nil image will end up measuring to that size. If you don't
        // set the image contraints, it will end up being it's 1x intrinsic
        // size of the image, so you should set a default image when you
        // create the cell.
        NSDictionary *dataDict = weakSelf.dataArray[indexPath.row];
        [((HTKSampleCollectionViewCell *)cellToSetup) setupCellWithData:dataDict andImage:nil];
        
        // return cell
        return cellToSetup;

    }];
}

@end
