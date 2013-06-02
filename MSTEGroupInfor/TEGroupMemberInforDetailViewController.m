//
//  TEGroupMemberInforDetailViewController.m
//  MSTEGroupInfor
//
//  Created by Yukui Ye on 5/31/13.
//  Copyright (c) 2013 Yukui Ye. All rights reserved.
//

#import "TEGroupMemberInforDetailViewController.h"
#import <Twitter/Twitter.h>
#import "popOverTweetFromTwitterViewController.h"

@interface TEGroupMemberInforDetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation TEGroupMemberInforDetailViewController
@synthesize webProfileView,popover;


#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        [webProfileView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[self.detailItem description]]]]; 
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

- (IBAction)tweetButtonPressed:(id)sender
{
    if(![TWTweetComposeViewController canSendTweet]){
        NSLog(@"Cannot tweet ! Disabling button");
        self.tweetButton.enabled = FALSE;
    }
    TWTweetComposeViewController *tweetViewController=[[TWTweetComposeViewController alloc] init];    
    [tweetViewController setInitialText:@"HelloHelloYe. Tweet From IOS6 Ipad simulator."];
    [tweetViewController addURL:[NSURL URLWithString:@"http://www.apple.com"]];
    
    [tweetViewController setCompletionHandler:^(TWTweetComposeViewControllerResult result) {
        switch (result) {
            case TWTweetComposeViewControllerResultCancelled:
                NSLog(@"Tweet Cancelled.");
                self.tweetButton.title = @"Cancelled";
                break;
            case TWTweetComposeViewControllerResultDone:
                NSLog(@"Tweet Done.");
                self.tweetButton.title = @"Done";
                break;
            default:
                break;
        }
     [self dismissModalViewControllerAnimated:YES];
     }];    
    [self presentModalViewController:tweetViewController animated:YES];    
}
/*
-(void)getTweetFromTwitter
{
    NSURL *searchURL = [NSURL URLWithString:@"http://search.twitter.com/search.json"];
    NSDictionary *params = [NSDictionary dictionaryWithObject:@"bobfamiliar" forKey:@"q"];
    TWRequest *req = [[TWRequest alloc] initWithURL:searchURL
                                         parameters:params
                                      requestMethod:TWRequestMethodGET];
    [req performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
        NSDictionary *results = [NSJSONSerialization JSONObjectWithData:responseData
                                                                options:NSJSONReadingMutableLeaves
                                                                  error:&error];
        NSDictionary *allTweets = [results objectForKey:@"results"];
        NSLog(@"All Tweets: %@",allTweets);
    }];
}*/


- (IBAction)getDataFromTwitter:(id)sender {
    
    NSURL *searchURL = [NSURL URLWithString:@"http://search.twitter.com/search.json"];
    NSDictionary *params = [NSDictionary dictionaryWithObject:@"bobfamiliar" forKey:@"q"];
    TWRequest *req = [[TWRequest alloc] initWithURL:searchURL
                                         parameters:params
                                      requestMethod:TWRequestMethodGET];
    [req performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
        NSDictionary *results = [NSJSONSerialization JSONObjectWithData:responseData
                                                                options:NSJSONReadingMutableLeaves
                                                                  error:&error];
        NSDictionary *allTweets = [results objectForKey:@"results"];
        NSLog(@"All Tweets: %@",allTweets);
    }];
}
/*›
    if([popover isPopoverVisible]) {
        [popover dismissPopoverAnimated:YES];
    }else{
        popOverTweetFromTwitterViewController *popTweets = [[popOverTweetFromTwitterViewController alloc] init];
        popover = [[UIPopoverController alloc] initWithContentViewController:popTweets];
        popover.popoverContentSize = CGSizeMake(250, 250);
        [popover presentPopoverFromBarButtonItem:sender
                        permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }*/
    



/*
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([sender isKindOfClass:[popOverTweetFromTwitterViewController class]]){
            if([segue.identifier isEqualToString:@"ShowImage"]){
                if([segue.destinationViewController respondsToSelector:@selector(setImageURL:)]){
                    NSURL *url = @"http://b72.photo.store.qq.com/psu?/289887743/qldH*gLHXOy46Tu8HkJJdJabaxPgoEmX7pIvlge9hfg!/b/YWQD9SpCMgAAYqvp7ioUMwAA&bo=gALgAQAAAAABAEQ!";
                    [segue.destinationViewController performSelector:@selector(setImageURL:)withObject:url];
                }
            }
        }
}
*/


@end
