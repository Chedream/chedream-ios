//
//  Question.m
//  chedream-ios
//
//  Created by Andrews on 19.04.15.
//  Copyright (c) 2015 Chedream. All rights reserved.
//

#import "Question.h"

@implementation Question

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if ((self = [super init])) {
        self.questionId = dict[@"id"];
        self.title = dict[@"title"];
        self.question = dict[@"question"];
        self.answer = dict[@"answer"];
        self.slug = dict[@"slug"];
    }
    
    return self;
}

@end
