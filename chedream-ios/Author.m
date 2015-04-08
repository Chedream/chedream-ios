//
//  Author.m
//  chedream-ios
//
//  Created by Andrews on 29.03.15.
//  Copyright (c) 2015 Chedream. All rights reserved.
//

#import "Author.h"

@implementation Author

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if ((self = [super init])) {
        self.username = dict[@"username"];
        self.authorId = (int)dict[@"id"];
        self.firstName = dict[@"first_name"];
        self.lastName = dict[@"last_name"];
        self.email = dict[@"email"];
        self.imageLink = dict[@"avatar"][@"provider_reference"];
    }
    
    return self;
}

@end
