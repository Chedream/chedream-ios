//
//  FAQViewController.m
//  chedream-ios
//
//  Created by core on 08.04.15.
//  Copyright (c) 2015 Chedream. All rights reserved.
//

#import "FAQViewController.h"

static CGFloat expandedHeight = 300.0;
static CGFloat contractedHeight = 44.0;


@interface FAQViewController ()
@property (nonatomic, strong) NSMutableArray *faqTitlesArray;
@property (nonatomic, strong) NSMutableArray *faqTextArray;

//@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation FAQViewController

-(void)viewWillAppear:(BOOL)animated {
    
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
// addObjects for FAQTableViewCell Title here
    self.faqTitlesArray = [[NSMutableArray alloc] initWithObjects:
                           @"dreams",
                           @"make",
                           @"help",
                           @"how",
                           @"than what", nil];
    
// addObjects for FAQTableViewCell details here
    self.faqTextArray = [[NSMutableArray alloc] initWithObjects:
                           @"dreams details details details details details details details details sdgsg sdgsdgsdgsd sdgsdgsdsdgd sdfsfsdfsdfsd fdsfsdfsdfsd fdsfsdfsdfsd fdsfdfsdfsdf fdsfsdfsdf fdsfds fds fdsfdsfsfsd fdsfdsd fdsdfsdf fdsf fds fds fds fdsfdsfdsfsdfsdffsd   fdsfsdf fdsfsdfsdf",
                           @"make details details details details details details details details dreams details details details details details details details details sdgsg sdgsdgsdgsd sdgsdgsdsdgd sdfsfsdfsdfsd fdsfsdfsdfsd fdsfsdfsdfsd fdsfdfsdfsdf fdsfsdfsdf fdsfds fds fdsfdsfsfsd fdsfdsd fdsdfsdf fdsf fds",
                           @"help details details details details details details details dreams details details details details details details details details sdgsg sdgsdgsdgsd sdgsdgsdsdgd sdfsfsdfsdfsd fdsfsdfsdfsd fdsfsdfsdfsd fdsfdfsdfsdf fds ",
                           @"how details details details details details details details details dreams details details details details details details details details sdgsg sdgsdgsdgsd sdgsdgsdsdgd sdfsfsdfsdfsd fdsfsdfsdfsd fdsfsdfsdfsd fdsfdfsdfsdf fdsfsdfsdf fdsfds fds fdsfdsfsfsd fdsfdsd fdsdfsdf fdsf fds fds dreams details details details details details details details details sdgsg sdgsdgsdgsd  ",
                           @"than what details details details details details details dreams details details details details details details details details sdgsg sdgsdgsdgsd sdgsdgsdsdgd sdfsfsdfsdfsd fdsfsdfsdfsd fdsfsdfsdfsd fdsfdfsdfsdf fdsfsdfsdf fdsfds fds fdsfdsfsfsd fdsfdsd fdsdfsdf fdsf fds fds  ", nil];
    
    }

- (IBAction)onMenuTap:(id)sender {
    if (self.isOpened) {
        [self.slidingViewController resetTopViewAnimated:YES];
    }else{
        [self.slidingViewController anchorTopViewToRightAnimated:YES];
    }
    self.isOpened = !self.isOpened;
}



#pragma mark - TableМiew data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.faqTitlesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FaqTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"faqCell" forIndexPath:indexPath];
    NSString *stringWithSimbol = [ NSString stringWithFormat:@"• %@",[self.faqTitlesArray objectAtIndex:indexPath.row]];
    cell.faqTitle.text = stringWithSimbol;
    cell.faqText.text = [self.faqTextArray objectAtIndex:indexPath.row];
    cell.faqText.textColor = [UIColor blackColor];
    cell.faqTitle.highlightedTextColor = [UIColor orangeColor];

    return cell;
}



#pragma cellExpanding

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView indexPathsForSelectedRows].count) {
        
        if ([[tableView indexPathsForSelectedRows] indexOfObject:indexPath] != NSNotFound) {
            
            NSString * yourText = self.faqTextArray[indexPath.row]; // or however you are getting the text
            return 44.0f + [self heightForText:yourText];
           // return expandedHeight; // Expanded height
        }
        
        return contractedHeight; // Normal height
    }
    
    return contractedHeight; // Normal height
}

#pragma get size of content for cell height

-(CGFloat)heightForText:(NSString *)text
{
    NSInteger MAX_HEIGHT = 2000;
    UITextView * textView = [[UITextView alloc] initWithFrame: CGRectMake(0, 0, 320, MAX_HEIGHT)];
    textView.text = text;
    textView.font = [UIFont systemFontOfSize:13];
    [textView sizeToFit];
    return textView.frame.size.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self updateTableView];

    
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self updateTableView];
    
}

- (void)updateTableView
{
    [UIView setAnimationsEnabled:NO];
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    [UIView setAnimationsEnabled:YES];
}



#pragma - selected cell background color

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    UIView *bgColorView = [[UIView alloc] init];
//    bgColorView.backgroundColor = [UIColor whiteColor];
//    //[UIColor colorWithRed:252.0f/255.0f green:176.0f/255.0f blue:64.0f/255.0f alpha:1.0f];
//    [cell setSelectedBackgroundView:bgColorView];
//    
    
    
    // remove section heder
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
}

@end
