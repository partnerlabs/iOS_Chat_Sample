//
//  FirstViewController.h
//  ios-partnerpush-sample
//
//  Created by jin on 15. 6. 29..
//  Copyright (c) 2015 jin. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <PartnerPushFramework/PartnerPushFramework.h>


@interface FirstViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, PartnerPushDelegate, UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet UITableView *chatTableView;
@property (nonatomic, strong) IBOutlet UITextField *messageTextField;
@property (nonatomic, strong) IBOutlet UIView *sendView;


- (IBAction)addTestTopic:(id)sender;
- (IBAction)removeTestTopic:(id)sender;
- (IBAction)doSendMessage:(id)sender;


@end
