//
//  DreamResource.m
//  chedream-ios
//
//  Created by Andrews on 30.03.15.
//  Copyright (c) 2015 Chedream. All rights reserved.
//

#import "DreamResource.h"

@implementation DreamResource

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if ((self = [super init])) {
        self.resourceId = dict[@"id"];
        self.title = dict[@"title"];
        self.quantity = dict[@"quantity"];
        self.createdAt = dict[@"created_at"];
    }
    
    return self;
}

@end
