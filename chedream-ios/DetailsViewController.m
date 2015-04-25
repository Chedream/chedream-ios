//
//  DetailsViewController.m
//  chedream-ios
//
//  Created by core on 08.04.15.
//  Copyright (c) 2015 Chedream. All rights reserved.
//

#import "DetailsViewController.h"
#import <AFHTTPRequestOperationManager.h>
#import "Dream.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *dreamPoster;
@property (weak, nonatomic) IBOutlet UIView *avatarContainer;
@property (weak, nonatomic) IBOutlet UIImageView *autorAvatar;
@property (weak, nonatomic) IBOutlet UILabel *authorName;
@property (weak, nonatomic) IBOutlet UIView *border;
@property (weak, nonatomic) IBOutlet UILabel *dreamTitle;
@property (weak, nonatomic) IBOutlet UILabel *dreamDescription;
@property (strong, nonatomic) IBOutlet UIView *progressModule;
//@property (strong, nonatomic) IBOutlet UIButton *participants;
//@property (strong, nonatomic) IBOutlet UIButton *estimate;


@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self getDreamDetails];
    [self setDataToView];
}

- (void)getDreamDetails{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url = [NSString stringWithFormat:@"%@%@%@", @"http://api.chedream.org/dreams/", self.selectedRowSlug, @".json"];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self parseDreams:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)parseDreams:(id) responseObject{
    NSDictionary *dreamsJson = (NSDictionary *) responseObject;
    if (!dreamsJson) {
        //todo set status with error
        return;
    }

    self.currentDream = [[Dream alloc] initWithDictionary:dreamsJson];
    [self setDataToView];
}


- (void)setDataToView {
    CGRect scrollViewFrame = self.view.frame;

    [_dreamPoster sd_setImageWithURL:[NSURL URLWithString:_currentDream.posterLink]
                      placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    _avatarContainer.layer.cornerRadius = _avatarContainer.frame.size.height /2;
    _avatarContainer.layer.masksToBounds = YES;
    _avatarContainer.layer.borderWidth = 0;
    
    _authorName.text = [_currentDream.dreamAuthor authorFullName];
    CGRect authorFrame = self.border.frame;

    _dreamTitle.text = _currentDream.title;
    [_dreamTitle sizeToFit];
    CGRect dreamTitleFrame = self.dreamTitle.frame;
    dreamTitleFrame.origin.y = authorFrame.origin.y + authorFrame.size.height + 10;
    self.dreamTitle.frame = dreamTitleFrame;
    
    _dreamDescription.attributedText = [[NSAttributedString alloc]
                              initWithData: [_currentDream.dreamDescription dataUsingEncoding:NSUnicodeStringEncoding]
                              options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
                              documentAttributes: nil
                              error: nil];
    [_dreamDescription sizeToFit];
    CGRect descriptionFrame = _dreamDescription.frame;
    descriptionFrame.origin.y = dreamTitleFrame.origin.y + dreamTitleFrame.size.height + 6;
    self.dreamDescription.frame = descriptionFrame;
    
    CGRect progressModuleFrame = _progressModule.frame;
    progressModuleFrame.origin.y = descriptionFrame.origin.y + descriptionFrame.size.height;
    self.progressModule.frame = progressModuleFrame;
    
    scrollViewFrame.size.height = [self countTotalHeight];
    [(UIScrollView *)self.view setContentSize:scrollViewFrame.size];
}

- (float) countTotalHeight {
    return _dreamPoster.frame.size.height
        + _authorName.frame.size.height
        + _dreamTitle.frame.size.height
        + _border.frame.size.height
        + _dreamDescription.frame.size.height
        + _progressModule.frame.size.height
        + 60;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
