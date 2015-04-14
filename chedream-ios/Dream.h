//
//  Dream.h
//  chedream-ios
//
//  Created by Andrews on 29.03.15.
//  Copyright (c) 2015 Chedream. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Author.h"

@interface Dream : NSObject

@property (nonatomic, strong) NSNumber *dreamId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *slug;
@property (nonatomic, strong) NSString *posterLink;
@property (nonatomic, strong) NSNumber *equipmentProgress;
@property (nonatomic, strong) NSNumber *financialProgress;
@property (nonatomic, strong) NSNumber *workProgress;

@property (nonatomic, strong) Author *dreamAuthor;
@property (nonatomic, strong) NSString *dreamDescription;
@property (nonatomic, strong) NSMutableArray *mediaPictures;

@property (nonatomic, strong) NSMutableArray *equipmentResources;
@property (nonatomic, strong) NSMutableArray *financialResources;
@property (nonatomic, strong) NSMutableArray *workResources;

@property (nonatomic, strong) NSMutableArray *equipmentContributions;
@property (nonatomic, strong) NSMutableArray *financialContributions;
@property (nonatomic, strong) NSMutableArray *workContributions;


- (instancetype)initWithDictionary:(NSDictionary *)dict;


@end
