//
//  DetailsViewController.h
//  chedream-ios
//
//  Created by core on 08.04.15.
//  Copyright (c) 2015 Chedream. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Dream.h"

@interface DetailsViewController : UIViewController

@property (nonatomic, strong) Dream *currentDream;
@property (nonatomic, strong) NSString *selectedRowSlug;

@end
