//
//  BaseViewController.h
//  chedream-ios
//
//  Created by core on 10.04.15.
//  Copyright (c) 2015 Chedream. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
@property (nonatomic, assign) BOOL isOpened;
- (IBAction)onMenuTap:(id)sender;
@end
