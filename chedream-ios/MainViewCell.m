//
//  MainViewCell.m
//  chedream-ios
//
//  Created by Andrews on 21.04.15.
//  Copyright (c) 2015 Chedream. All rights reserved.
//

#import "MainViewCell.h"

@implementation MainViewCell

-(void) makeWorkProgress {
    
    UCZProgressView  *workProgress = [[UCZProgressView alloc]initWithFrame:CGRectMake(70, 155, 20, 20)];
    workProgress.indeterminate = NO;
    workProgress.lineWidth = 3.0f;
    workProgress.radius = 16.0f;
    workProgress.tintColor = [UIColor orangeColor];
    workProgress.progress = 0.5;
    self.workProgress = workProgress;
    [self.contentView addSubview:self.workProgress];
}

-(void) makeFinancialProgress {
    
    UCZProgressView  *finProgress = [[UCZProgressView alloc]initWithFrame:CGRectMake(20, 155, 20, 20)];
    finProgress.lineWidth = 3.0f;
    finProgress.radius = 16.0f;
    finProgress.tintColor = [UIColor orangeColor];
    finProgress.progress = 0.8;
    self.financialProgress = finProgress;
    [self.contentView addSubview:self.financialProgress];
}

-(void) makeEquipmentProgress {
    
    UCZProgressView  *eqProgress = [[UCZProgressView alloc]initWithFrame:CGRectMake(120, 155, 20, 20)];
    eqProgress.lineWidth = 3.0f;
    eqProgress.radius = 16.0f;
    eqProgress.tintColor = [UIColor orangeColor];
    eqProgress.progress = 0.99;
    self.equipmentProgress = eqProgress;
    [self.contentView addSubview:self.equipmentProgress];
}


- (void)awakeFromNib {
     [super awakeFromNib];
    // Initialization code
    [self makeWorkProgress];
    [self makeFinancialProgress];
    [self makeEquipmentProgress];
}

@end