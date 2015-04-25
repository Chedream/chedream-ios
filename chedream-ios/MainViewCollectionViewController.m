//
//  MainViewCollectionViewController.m
//  chedream-ios
//
//  Created by core on 08.04.15.
//  Copyright (c) 2015 Chedream. All rights reserved.
//

#import "MainViewCollectionViewController.h"
#import "MainViewCell.h"
#import "DetailsViewController.h"
#import "UIViewController+ECSlidingViewController.h"
#import <AFHTTPRequestOperationManager.h>
#import "Dream.h"
#import <SDWebImage/UIImageView+WebCache.h>



@interface MainViewCollectionViewController () {
    NSMutableArray *dreams;
}

@property (nonatomic, assign) BOOL isOpened;
@property (nonatomic,assign,readwrite) BOOL isServerReachable;

- (IBAction)onMenuTap:(id)sender;

@end


@implementation MainViewCollectionViewController

static NSString * const reuseIdentifier = @"MainViewCell";


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
    [self.collectionView registerNib:[UINib nibWithNibName:reuseIdentifier
                                                    bundle:[NSBundle mainBundle]]
                        forCellWithReuseIdentifier:reuseIdentifier];
    
    [self getDreams];
    
    
#pragma network state changing inspector (realtime)
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@" !  Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
    }];

#pragma network status manager
    
    NSURL *baseURL = [NSURL URLWithString:@"http://api.chedream.org/"];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    
    NSOperationQueue *operationQueue = manager.operationQueue;
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [operationQueue setSuspended:NO];
                break;
            case AFNetworkReachabilityStatusNotReachable:
            default:
                [operationQueue setSuspended:YES];
                break;
        }
    }];
    
    
        // to start monitoring
    [manager.reachabilityManager startMonitoring];
    
    
        //get current network status and alert if unreachable
    if([AFNetworkReachabilityManager sharedManager].reachable ){
        
        NSLog(@"%@",@"is reachable");
    }else{
        NSLog(@"%@",@"not reachable");
        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No connection" message:@"Check your Internet connection" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
//        [alert addButtonWithTitle:@"OK"];
//        [alert show];
        return;
    }
}

- (void)getDreams{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://api.chedream.org/dreams.json?count=20" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
    
    MainViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];

    Dream *dreamByIndex = dreams[indexPath.row];
    
    [cell.poster sd_setImageWithURL:[NSURL URLWithString:dreamByIndex.posterLink]
                      placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    cell.title.text = [dreamByIndex title];

    float countedEQProgress = [self getFloatValue: dreamByIndex.equipmentProgress];
    if (countedEQProgress == 1) {
        cell.equipmentProgress.tintColor = [UIColor orangeColor];
        cell.equipmentProgress.progress = 0.999;

    } else {
        cell.equipmentProgress.tintColor = [UIColor blackColor];
        cell.equipmentProgress.progress = countedEQProgress;

    }
    
    float countedFINProgress = [self getFloatValue: dreamByIndex.financialProgress];
    if (countedFINProgress == 1) {
        cell.financialProgress.tintColor = [UIColor orangeColor];
        cell.financialProgress.progress = 0.999;

    } else {
        cell.financialProgress.tintColor = [UIColor blackColor];
        cell.financialProgress.progress = countedFINProgress;

    }
    
    float countedWORKProgress = [self getFloatValue: dreamByIndex.workProgress];
    if (countedWORKProgress == 1) {
        cell.workProgress.tintColor = [UIColor orangeColor];
        cell.workProgress.progress = 0.999;

    } else {
        cell.workProgress.tintColor = [UIColor blackColor];
        cell.workProgress.progress = countedWORKProgress;

    }
    
    return cell;
}

- (float)getFloatValue:(NSString*)string

{   float result = 1;
    if (string) {
        int intV = [string intValue];
        if (intV < 100)
        {
            result = (float)intV / 100;
        }
    }

    return result;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DetailsViewController *details = [[DetailsViewController alloc] initWithNibName:@"DetailsViewController" bundle:nil];
    details.currentDream = [dreams objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:details animated:YES];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(CGRectGetWidth(collectionView.frame)/2 -1, CGRectGetWidth(collectionView.frame)* 0.60-1);
}


 #pragma mark - Navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([segue.identifier isEqualToString:@"showDreamDetails"]) {
//        NSIndexPath *indexPath = [[self.collectionView indexPathsForSelectedItems] objectAtIndex:0];
//        DetailsViewController *destViewController = segue.destinationViewController;
////        destViewController.selectedRowSlug = [[dreams objectAtIndex:indexPath.row] slug] ;
//        destViewController.currentDream = [dreams objectAtIndex:indexPath.row];
//    }
//}

@end
