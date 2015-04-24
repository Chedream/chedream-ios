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

//-(void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout;
//    layout.itemSize = CGSizeMake(160, 180);
//    
//    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
//}

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
//    
//    float buttonWidth = cell.three.frame.size.width;
//
//    float single = cell.frame.size.width/2 - buttonWidth/2;
//    [cell.three setTitle:@"button" forState:UIControlStateNormal];
    
    if (dreamByIndex.equipmentProgress) {
        cell.equipmentProgress.tintColor = [UIColor blackColor];
        cell.equipmentProgress.progress = [dreamByIndex.equipmentProgress integerValue]/100;
        NSLog(@"%f",[dreamByIndex.equipmentProgress floatValue]);
    }
    
    
    
    
    
/*
    if (!dreamByIndex.equipmentProgress || [dreamByIndex.equipmentProgress integerValue]/100 >= 1 ) {
        cell.equipmentProgress.tintColor = [UIColor orangeColor];
        cell.equipmentProgress.progress = 0.99;
        
    } else {
        
    [cell makeEquipmentProgress]; // or uncoment awakeFromNib in MainViewCell
    [cell.equipmentProgress setProgress:[dreamByIndex.equipmentProgress integerValue]/100 animated:YES];
    
        NSLog(@"!   %i", [dreamByIndex.equipmentProgress integerValue]/100);
    }
    
    
    
    if (!dreamByIndex.financialProgress || [dreamByIndex.financialProgress integerValue]/100 >= 1 ) {
        cell.financialProgress.tintColor = [UIColor orangeColor];
        cell.financialProgress.progress = 0.99;
        
    } else {
    
    [cell makeFinancialProgress]; // or uncoment awakeFromNib in MainViewCell
    [cell.financialProgress setProgress:[dreamByIndex.financialProgress integerValue]/100 animated:YES];

        NSLog(@"int/100   %i", [dreamByIndex.financialProgress integerValue]/100);
    }
    
    
    if (!dreamByIndex.workProgress || [dreamByIndex.workProgress integerValue]/100 >= 1 ) {
        cell.workProgress.tintColor = [UIColor orangeColor];
        cell.workProgress.progress = 0.99;
        
    } else {
    
    [cell makeWorkProgress]; // or uncoment awakeFromNib in MainViewCell
    [cell.workProgress setProgress:[dreamByIndex.workProgress integerValue]/100 animated:YES];

        NSLog(@"!float/100   %i", [dreamByIndex.workProgress integerValue]/100);
    }
*/
    
    
    
    

//
//    if (!dreamByIndex.financialProgress) {
//        cell.one.hidden = YES;
//       
//        
//    } else {
//        cell.one.hidden = NO;
//        [cell.one setTitle:dreamByIndex.financialProgress forState:UIControlStateNormal];
//    }
//    if (!dreamByIndex.equipmentProgress) {
//        cell.two.hidden = YES;
//    } else{
//        cell.two.hidden = NO;
//        [cell.two setTitle:dreamByIndex.equipmentProgress forState:UIControlStateNormal];
//    }
//    if (!dreamByIndex.workProgress){
//        cell.three.hidden = YES;
//    } else {
//        cell.three.hidden = NO;
//        [cell.three setTitle:dreamByIndex.workProgress forState:UIControlStateNormal];
//    }
//    [cell.three setFrame:CGRectMake(single,
//                                        cell.three.frame.origin.y,
//                                        cell.three.frame.size.width,
//                                        cell.three.frame.size.height)];
//    
    return cell;
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

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([segue.identifier isEqualToString:@"showDreamDetails"]) {
//        NSIndexPath *indexPath = [[self.collectionView indexPathsForSelectedItems] objectAtIndex:0];
//        DetailsViewController *destViewController = segue.destinationViewController;
////        destViewController.selectedRowSlug = [[dreams objectAtIndex:indexPath.row] slug] ;
//        destViewController.currentDream = [dreams objectAtIndex:indexPath.row];
//    }
//}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
