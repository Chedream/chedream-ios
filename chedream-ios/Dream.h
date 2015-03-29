//
//  Dream.h
//  chedream-ios
//
//  Created by Andrews on 29.03.15.
//  Copyright (c) 2015 Chedream. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Dream : NSObject

@property (nonatomic, strong) NSNumber *dreamId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *slug;
@property (nonatomic, strong) NSString *imageLink;
@property (nonatomic, strong) NSNumber *equipmentProgress;
@property (nonatomic, strong) NSNumber *financialProgress;
@property (nonatomic, strong) NSNumber *workProgress;

- (instancetype)initWithDictionary:(NSDictionary *)dict;


@end
