//
//  Dream.m
//  chedream-ios
//
//  Created by Andrews on 29.03.15.
//  Copyright (c) 2015 Chedream. All rights reserved.
//

#import "Dream.h"
#import "Author.h"

@implementation Dream

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if ((self = [super init])) {
        self.dreamId = dict[@"id"];
        self.title = dict[@"title"];
        self.slug = dict[@"slug"];
        self.posterLink = [NSString stringWithFormat:@"%@%@", @"http://chedream.org/upload/media/poster/0001/01/", dict[@"media_poster"][@"provider_reference"]];
        self.dreamAuthor = [[Author alloc] initWithDictionary:dict[@"author"]];
        
    }
    
    return self;
}

@end
