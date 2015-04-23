//
//  FaqTableViewCell.m
//  chedream-ios
//
//  Created by core on 21.04.15.
//  Copyright (c) 2015 Chedream. All rights reserved.
//

#import "FaqTableViewCell.h"

@implementation FaqTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor whiteColor];
        //[UIColor colorWithRed:252.0f/255.0f green:176.0f/255.0f blue:64.0f/255.0f alpha:1.0f];
    self.selectedBackgroundView = bgColorView;
    self.faqText.textColor = [UIColor blackColor];
    self.faqText.highlightedTextColor = [UIColor blackColor];
    
    //[UIColor colorWithRed:252.0f/255.0f green:176.0f/255.0f blue:64.0f/255.0f alpha:1.0f];

    // Configure the view for the selected state
}

@end
