//
//  ResourceContribution.m
//  chedream-ios
//
//  Created by Andrews on 11.04.15.
//  Copyright (c) 2015 Chedream. All rights reserved.
//

#import "ResourceContribution.h"

@implementation ResourceContribution

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if ((self = [super init])) {
        self.contributionId = dict[@"id"];
        self.quantity = dict[@"quantity"];
        self.createdAt = dict[@"created_at"];
        self.hidden = (BOOL)dict[@"hidden_contributor"];
//        self.dreamResource = [[DreamResource alloc] initWithDictionary:dict[@""]];
    }

    return self;
}

@end
