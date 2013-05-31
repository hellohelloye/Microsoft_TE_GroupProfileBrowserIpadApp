//
//  TEGroupMemberInforDetailViewController.h
//  MSTEGroupInfor
//
//  Created by Yukui Ye on 5/31/13.
//  Copyright (c) 2013 Yukui Ye. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TEGroupMemberInforDetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@property (weak, nonatomic) IBOutlet UIWebView *webProfileView; 
@property (weak, nonatomic) IBOutlet UIBarButtonItem *tweetButton;
- (IBAction)tweetButtonPressed:(id)sender;

@end

