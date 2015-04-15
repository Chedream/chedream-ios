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
@property (weak, nonatomic) IBOutlet UITextView *dreamTitle;
@property (weak, nonatomic) IBOutlet UITextView *dreamDescription;


@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    NSLog(@"%@", self.selectedRowSlug);
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
//    _dreamPoster.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_currentDream.posterLink]]];
    [_dreamPoster sd_setImageWithURL:[NSURL URLWithString:_currentDream.posterLink]
                      placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    _authorName.text = [_currentDream.dreamAuthor authorFullName];
    _dreamTitle.text = _currentDream.title;
    _dreamDescription.attributedText = [[NSAttributedString alloc]
                              initWithData: [_currentDream.dreamDescription dataUsingEncoding:NSUnicodeStringEncoding]
                              options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
                              documentAttributes: nil
                              error: nil];
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
