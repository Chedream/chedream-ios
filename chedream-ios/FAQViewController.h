//
//  FAQViewController.h
//  chedream-ios
//
//  Created by core on 08.04.15.
//  Copyright (c) 2015 Chedream. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "UIViewController+ECSlidingViewController.h"
#import "FaqTableViewCell.h"

@interface FAQViewController : UITableViewController
@property (nonatomic, assign) BOOL isOpened;
- (IBAction)onMenuTap:(id)sender;


@end
