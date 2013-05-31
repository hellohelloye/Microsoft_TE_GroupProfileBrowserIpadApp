//
//  TEGroupMemberInforDetailViewController.m
//  MSTEGroupInfor
//
//  Created by Yukui Ye on 5/31/13.
//  Copyright (c) 2013 Yukui Ye. All rights reserved.
//

#import "TEGroupMemberInforDetailViewController.h"
#import <Twitter/Twitter.h>

@interface TEGroupMemberInforDetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation TEGroupMemberInforDetailViewController
@synthesize webProfileView;   ////////////////ADD BY SELF

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
    
    TWTweetComposeViewController *tweetViewController = [[TWTweetComposeViewController alloc] init];
    
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


@end
