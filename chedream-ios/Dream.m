//
//  Dream.m
//  chedream-ios
//
//  Created by Andrews on 29.03.15.
//  Copyright (c) 2015 Chedream. All rights reserved.
//

#import "Dream.h"
#import "Author.h"
#import "DreamResource.h"
#import "ResourceContribution.h"


@implementation Dream

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if ((self = [super init])) {
        self.dreamId = dict[@"id"];
        self.title = dict[@"title"];
        self.slug = dict[@"slug"];
        self.posterLink = [NSString stringWithFormat:@"%@%@", @"http://chedream.org/upload/media/poster/0001/01/", dict[@"media_poster"][@"provider_reference"]];
        
        self.dreamAuthor = [[Author alloc] initWithDictionary:dict[@"author"]];
        self.dreamDescription = dict[@"description"];
        
        NSDictionary *financialResourcesArray = dict[@"dream_financial_resources"];
        if (financialResourcesArray.count > 0) {
            self.financialResources = [NSMutableArray array];
            for (NSDictionary *financialResource in financialResourcesArray) {
                if (!financialResource) {
                    break;
                }
                [self.financialResources addObject:[[DreamResource alloc] initWithDictionary:financialResource]];
            }
        }
        
        NSDictionary *equipmentResourcesArray = dict[@"dream_equipment_resources"];
        if (equipmentResourcesArray.count > 0) {
            self.equipmentResources = [NSMutableArray array];
            for (NSDictionary *equipmentResource in equipmentResourcesArray) {
                if (!equipmentResource) {
                    break;
                }
                [self.equipmentResources addObject:[[DreamResource alloc] initWithDictionary:equipmentResource]];
            }
        }
        
        NSDictionary *workResourcesArray = dict[@"dream_work_resources"];
        if (workResourcesArray.count > 0) {
            self.workResources = [NSMutableArray array];
            for (NSDictionary *workResource in workResourcesArray) {
                if (!workResource) {
                    break;
                }
                [self.workResources addObject:[[DreamResource alloc] initWithDictionary:workResource]];
            }
        }
        
        NSDictionary *financialContributionsArray = dict[@"dream_financial_contributions"];
        if (financialContributionsArray.count > 0) {
            self.financialContributions = [NSMutableArray array];
            for (NSDictionary *financialContribution in financialContributionsArray) {
                if (!financialContribution) {
                    break;
                }
                [self.financialContributions addObject:[[ResourceContribution alloc] initWithDictionary:financialContribution]];
            }
        }
        
        NSDictionary *equipmentContributionsArray = dict[@"dream_equipment_contributions"];
        if (equipmentContributionsArray.count > 0) {
            self.equipmentContributions = [NSMutableArray array];
            for (NSDictionary *equipmentContribution in equipmentContributionsArray) {
                if (!equipmentContribution) {
                    break;
                }
                [self.equipmentContributions addObject:[[ResourceContribution alloc] initWithDictionary:equipmentContribution]];
            }
        }
        
        NSDictionary *workContributionsArray = dict[@"dream_work_contributions"];
        if (workContributionsArray.count > 0) {
            self.workContributions = [NSMutableArray array];
            for (NSDictionary *workContribution in workContributionsArray) {
                if (!workContribution) {
                    break;
                }
                [self.workContributions addObject:[[ResourceContribution alloc] initWithDictionary:workContribution]];
            }
        }
        
    }
    
    return self;
}

@end
