//
//  Dream.h
//  chedream-ios
//
//  Created by Andrews on 29.03.15.
//  Copyright (c) 2015 Chedream. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Dream : NSObject

@property (nonatomic) int *dreamId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *slug;
@property (nonatomic, strong) NSString *imageLink;
@property (nonatomic) int *equipmentProgress;
@property (nonatomic) int *financialProgress;
@property (nonatomic) int *workProgress;


@end
