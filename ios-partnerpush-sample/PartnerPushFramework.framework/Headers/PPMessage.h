//
//  PPMessage.h
//  PartnerPushFramework
//
//  Created by partner on 2015. 5. 27..
//  Copyright (c) 2015년 partner. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum PayloadMessageType : NSUInteger {
    PayloadMessageTypeText,
    PayloadMessageTypeXML,
    PayloadMessageTypeJSON,
    PayloadMEssageTypeData
} PayloadMessageType;

@interface PPMessage : NSObject

@property (nonatomic, assign) BOOL isSpecial;
@property (nonatomic, assign) PayloadMessageType msgType;
@property (nonatomic, assign) BOOL isMine;
@property (nonatomic, assign) NSDate *sendDate;
@property (nonatomic, assign) double msgKey;
@property (nonatomic, assign) NSDictionary *content;
@property (nonatomic, assign) NSData *binary;
@property (nonatomic, assign) NSString *topic;
@property (nonatomic, assign) NSInteger qos;


- (id)initWithPayload:(BOOL)isSpecial MessageType:(PayloadMessageType)msgType isMine:(BOOL)isMine SendDate:(NSDate *)sendDate MessageKey:(double)msgKey Content:(NSDictionary *)content Binary:(NSData *)binary Topic:(NSString *)topic Qos:(NSInteger)qos;

@end
