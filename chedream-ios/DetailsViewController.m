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
@property (weak, nonatomic) IBOutlet UIImageView *autorAvatar;
@property (weak, nonatomic) IBOutlet UILabel *authorName;
@property (weak, nonatomic) IBOutlet UILabel *dreamTitle;
@property (weak, nonatomic) IBOutlet UILabel *dreamDescription;
@property (strong, nonatomic) IBOutlet UIView *progressModule;
@property (strong, nonatomic) IBOutlet UIButton *participants;
@property (strong, nonatomic) IBOutlet UIButton *estimate;


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
//    NSString *text = @"fdhfjdhbjfdh dfjh fdjhd j dfjh fjhdf fdhjdffjfhdjfhdj fdf djfh djhf djfh jdf fjhd fjhd fjhdf jhdf jdhf dhjf dhjf jdfjdfjdfjdfjdhf jdhf djhf jdhf jdhf jdhf XXXX";
    
    CGRect scrollViewFrame = self.view.frame;
    scrollViewFrame.size.height = 5000;
    [(UIScrollView *)self.view setContentSize:scrollViewFrame.size];

    [_dreamPoster sd_setImageWithURL:[NSURL URLWithString:_currentDream.posterLink]
                      placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    _authorName.text = [_currentDream.dreamAuthor authorFullName];
//    _authorName.text = @"test";
    [_authorName sizeToFit];
    CGRect authorFrame = self.authorName.frame;

    _dreamTitle.text = _currentDream.title;
//    _dreamTitle.text = text;
    [_dreamTitle sizeToFit];
    CGRect dreamTitleFrame = self.dreamTitle.frame;
    dreamTitleFrame.origin.y = authorFrame.origin.y + authorFrame.size.height;
    self.dreamTitle.frame = dreamTitleFrame;
    _dreamDescription.attributedText = [[NSAttributedString alloc]
                              initWithData: [_currentDream.dreamDescription dataUsingEncoding:NSUnicodeStringEncoding]
                              options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
                              documentAttributes: nil
                              error: nil];
//    _dreamDescription.text = text;
    [_dreamDescription sizeToFit];
    CGRect descriptionFrame = _dreamDescription.frame;
    descriptionFrame.origin.y = dreamTitleFrame.origin.y + dreamTitleFrame.size.height;
    self.dreamDescription.frame = descriptionFrame;
    
    CGRect progressModuleFrame = _progressModule.frame;
    progressModuleFrame.origin.y = descriptionFrame.origin.y + descriptionFrame.size.height;
    self.progressModule.frame = progressModuleFrame;
    
    CGRect estimateFrame = _estimate.frame;
    estimateFrame.origin.y = progressModuleFrame.origin.y + progressModuleFrame.size.height;
    _estimate.frame = estimateFrame;
    
    CGRect participantsFrame = _participants.frame;
    participantsFrame.origin.y = estimateFrame.origin.y + estimateFrame.size.height;
    _participants.frame = participantsFrame;
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
