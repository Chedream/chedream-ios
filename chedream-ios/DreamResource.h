//
//  DreamResource.h
//  chedream-ios
//
//  Created by core on 10.04.15.
//  Copyright (c) 2015 Chedream. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DreamResource : NSObject
@property (nonatomic, strong) NSNumber *resourceId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSNumber *quantity;
@property (nonatomic, strong) NSString *createdAt;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
