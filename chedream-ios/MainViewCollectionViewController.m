//
//  MainViewCollectionViewController.m
//  chedream-ios
//
//  Created by core on 08.04.15.
//  Copyright (c) 2015 Chedream. All rights reserved.
//

#import "MainViewCollectionViewController.h"

@interface MainViewCollectionViewController ()

@end

@implementation MainViewCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    array = [[NSArray alloc]initWithObjects:
             @"dream1.png",
             @"dream2.png",
             @"dream3.png",
             @"dream4.png",
             @"dream5.png",
             @"dream6.png",
             nil];
    
    
    
    // Do any additional setup after loading the view.
    
    // Create your image
    //    UIImage *image = [UIImage imageNamed: @"icon_logo.png"];
    //    UIImageView *imageview = [[UIImageView alloc] initWithImage: image];
    //
    //    // set the text view to the image view
    //    self.navigationItem.titleView = imageview;
    
    //
    //     [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"icon_logo.png"] forBarMetrics:UIBarMetricsDefault];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return array.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"dreamCell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    UIImageView *dreamImageView = (UIImageView *)[cell viewWithTag:100];
    dreamImageView.image = [UIImage imageNamed:[array objectAtIndex:indexPath.row]];
    
    return cell;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout;
    layout.itemSize = CGSizeMake(160, 180);
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(CGRectGetWidth(collectionView.frame)/2 -1, CGRectGetWidth(collectionView.frame)* 0.60-1);
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
