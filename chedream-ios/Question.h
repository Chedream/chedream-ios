//
//  Question.h
//  chedream-ios
//
//  Created by Andrews on 19.04.15.
//  Copyright (c) 2015 Chedream. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Question : NSObject

@property (nonatomic, strong) NSNumber *questionId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *question;
@property (nonatomic, strong) NSString *answer;
@property (nonatomic, strong) NSString *slug;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end