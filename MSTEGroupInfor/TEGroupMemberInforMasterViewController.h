//
//  TEGroupMemberInforMasterViewController.h
//  MSTEGroupInfor
//
//  Created by Yukui Ye on 5/31/13.
//  Copyright (c) 2013 Yukui Ye. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TEGroupMemberInforDetailViewController;

@interface TEGroupMemberInforMasterViewController : UITableViewController

@property (strong, nonatomic) TEGroupMemberInforDetailViewController *detailViewController;
@property (strong,nonatomic) NSDictionary *TEINFOR;

@end
