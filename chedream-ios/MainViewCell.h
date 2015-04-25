//
//  MainViewCell.h
//  chedream-ios
//
//  Created by Andrews on 21.04.15.
//  Copyright (c) 2015 Chedream. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UCZProgressView/UCZProgressView.h>

@interface MainViewCell : UICollectionViewCell
@property (nonatomic, strong) IBOutlet UILabel *title;
@property (nonatomic, strong) IBOutlet UIImageView *poster;
@property (nonatomic, strong) IBOutlet UIImageView *one;
@property (nonatomic, strong) IBOutlet UIImageView *two;
@property (nonatomic, strong) IBOutlet UIImageView *three;

@property (nonatomic, weak) IBOutlet UCZProgressView * workProgress;
@property (nonatomic, weak) IBOutlet UCZProgressView * financialProgress;
@property (nonatomic, weak) IBOutlet UCZProgressView * equipmentProgress;

-(void) makeWorkProgress;
-(void) makeFinancialProgress;
-(void) makeEquipmentProgress;

@end
