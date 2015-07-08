//
//  FirstViewController.m
//  ios-partnerpush-sample
//
//  Created by jin on 15. 6. 29..
//  Copyright (c) 2015 jin. All rights reserved.
//


#import "FirstViewController.h"
#import "PartnerPushFramework/PartnerPushConnector.h"



#define APP_ID @"baa9753a5940b2c5dd8b3a58c52ed2d4"
#define API_KEY @"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJweCI6IjEzIiwicGYiOiIxIiwiZHQiOjE0MzU3MzE1MzkwNTF9.0WFMkMNjlkv5cLjvGGC97DdHZQk_z6GOn9yBVe-QYWA"
#define TEST_TOPIC @"PPChat"


@interface FirstViewController () {
    NSMutableArray *chatData;
}

@end

@implementation FirstViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    chatData = [[NSMutableArray alloc] init];

    _chatTableView.delegate = self;
    _chatTableView.dataSource = self;



    _messageTextField.delegate = self;
    
    //Create the MQTT client with an unique identifier
    NSString *clientID = [NSString stringWithFormat:@"partner_example_%@", [UIDevice currentDevice].identifierForVendor.UUIDString];

    [[PartnerPushConnector sharedService] partnerPushConnectWithAppId:APP_ID ApiKey:API_KEY ClientId:clientID];
    [PartnerPushConnector sharedService].delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [chatData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {


    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }

    cell.textLabel.text = [chatData objectAtIndex:[indexPath row]];




    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [_messageTextField resignFirstResponder];

}


#pragma mark -
#pragma PartnerPushDelegate

- (void)partnerPushReceivedWithPayload:(PPMessage *)message {

    NSLog(@"%@", message);

    @try {
        
        NSString *strMessage = [message.content objectForKey:@"text"];

        [chatData addObject:strMessage];



    } @catch(NSException *e) {

        UILocalNotification *noti = [[UILocalNotification alloc]init];
        noti.fireDate = [NSDate dateWithTimeIntervalSinceNow:5];
        noti.timeZone = [NSTimeZone systemTimeZone];
        noti.alertBody = @"모르는 알림이 도착했어요!";
        noti.alertAction = @"GOGO";
        noti.applicationIconBadgeNumber = 1;
        noti.soundName = UILocalNotificationDefaultSoundName;
        noti.userInfo = [NSDictionary dictionaryWithObject:@"My User Info" forKey:@"User Info"];
        [[UIApplication sharedApplication] scheduleLocalNotification:noti];

    }

    dispatch_async(dispatch_get_main_queue(), ^{
        [_chatTableView reloadData];

        if([chatData count] != 0) {
            [self.chatTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[chatData count]-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }
    });

}

- (void)partnerPushConnectedWithCode:(PPConnectionReturnCode)code {



}

- (IBAction)addTestTopic:(id)sender {

    [[PartnerPushConnector sharedService] partnerPushAddTopic:TEST_TOPIC];
    [self alertShow:@"토픽을 추가하였습니다."];

    [_chatTableView reloadData];

}

- (IBAction)removeTestTopic:(id)sender {

    [[PartnerPushConnector sharedService] partnerPushRemoveTopic:TEST_TOPIC];
    [self alertShow:@"토픽을 삭제하였습니다."];

}

- (IBAction)doSendMessage:(id)sender {

    NSString *strMessage = _messageTextField.text;

    if([strMessage length] == 0) {
        [self alertShow:@"내용을 입력하세요"];
        return;
    }

    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:@"PP_USER" forKey:@"nickname"];
    [dic setValue:strMessage forKey:@"text"];


    [[PartnerPushConnector sharedService] partnerPushSendMessageWithDictionary:dic Topic:TEST_TOPIC];

    [_messageTextField setText:@""];

}

- (void)alertShow:(NSString *)message {
    [[[UIAlertView alloc] initWithTitle:@"알림" message:message delegate:self cancelButtonTitle:@"확인" otherButtonTitles:nil] show];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {




    return NO;
}


- (void)textFieldDidBeginEditing:(UITextField *)textField{

    // keyboard 높이만큼 스크롤 뷰에 버퍼 공간 추가
    //self.view.contentInset = UIEdgeInsetsMake(0,0,216,0);

    CGRect rect = _sendView.frame;
    rect.size.height -= 216;
    _sendView.frame = rect;

    // cell이 선택되어 textField가 편집모드이면 scroll 메시지 전송 : UITableViewScrollPositionTop
    //[_chatTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:textField.tag inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];

//    if([chatData count] != 0) {
//        [self.chatTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[chatData count]-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
//    }



}


- (void)textFieldDidEndEditing:(UITextField*)textField{

    // 버퍼 공간 제거

    //_chatTableView.contentInset = UIEdgeInsetsZero;

    CGRect rect = _sendView.frame;
    rect.size.height += 216;
    _sendView.frame = rect;


}

@end