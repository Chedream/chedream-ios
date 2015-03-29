//
//  Author.h
//  chedream-ios
//
//  Created by Andrews on 29.03.15.
//  Copyright (c) 2015 Chedream. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Author : NSObject

@property (nonatomic) int *authorId;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *imageLink;

@end
