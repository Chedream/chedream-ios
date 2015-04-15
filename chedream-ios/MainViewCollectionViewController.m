//
//  MainViewCollectionViewController.m
//  chedream-ios
//
//  Created by core on 08.04.15.
//  Copyright (c) 2015 Chedream. All rights reserved.
//

#import "MainViewCollectionViewController.h"
#import "DetailsViewController.h"
#import "UIViewController+ECSlidingViewController.h"
#import <AFHTTPRequestOperationManager.h>
#import "Dream.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface MainViewCollectionViewController () {
    NSMutableArray *dreams;
}
@property (nonatomic, assign) BOOL isOpened;
- (IBAction)onMenuTap:(id)sender;

@end


@implementation MainViewCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout;
    layout.itemSize = CGSizeMake(160, 180);
    
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
}

- (IBAction)onMenuTap:(id)sender {
    if (self.isOpened) {
        [self.slidingViewController resetTopViewAnimated:YES];
    }else{
        [self.slidingViewController anchorTopViewToRightAnimated:YES];
    }
    self.isOpened = !self.isOpened;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dreams = [NSMutableArray array];
    
    [self getDreams];
}

- (void)getDreams{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://api.chedream.org/dreams.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"JSON: %@", responseObject);
        [self parseDreams:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)parseDreams:(id) responseObject{
    NSDictionary *dreamsJson = (NSDictionary *) responseObject;
    if (!dreamsJson) {
        //todo set status with error
        return;
    }
    NSDictionary *dreamsArray = dreamsJson[@"dreams"];
    for (NSDictionary *iCountryDict in dreamsArray) {
        if (!iCountryDict) {
            break;
        }
        
        [dreams addObject:[[Dream alloc] initWithDictionary:iCountryDict]];
    }
    [self.collectionView reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return dreams.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"dreamCell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    Dream *dreamByIndex = dreams[indexPath.row];
    
    UIImageView *dreamImageView = (UIImageView *)[cell viewWithTag:100];
//    dreamImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:dreamByIndex.posterLink]]];
    [dreamImageView sd_setImageWithURL:[NSURL URLWithString:dreamByIndex.posterLink]
                      placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    UILabel *dreamTitle = (UILabel *)[cell viewWithTag:2];
    dreamTitle.text = [dreamByIndex title];
    
    return cell;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(CGRectGetWidth(collectionView.frame)/2 -1, CGRectGetWidth(collectionView.frame)* 0.60-1);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showDreamDetails"]) {
        NSIndexPath *indexPath = [[self.collectionView indexPathsForSelectedItems] objectAtIndex:0];
        DetailsViewController *destViewController = segue.destinationViewController;
//        destViewController.selectedRowSlug = [[dreams objectAtIndex:indexPath.row] slug] ;
        destViewController.currentDream = [dreams objectAtIndex:indexPath.row];
    }
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
