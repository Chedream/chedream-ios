//
//  ResourceContribution.h
//  chedream-ios
//
//  Created by Andrews on 11.04.15.
//  Copyright (c) 2015 Chedream. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DreamResource.h"


@interface ResourceContribution : NSObject

@property (nonatomic, strong) NSNumber *contributionId;
@property (nonatomic) BOOL hidden;
@property (nonatomic, strong) NSNumber *quantity;
@property (nonatomic, strong) NSString *createdAt;
@property (nonatomic, strong) DreamResource *dreamResource;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
