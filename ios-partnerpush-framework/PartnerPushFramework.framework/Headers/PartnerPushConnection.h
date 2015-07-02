//
//  PartnerPushConnection.h
//  PartnerPushFramework
//
//  Created by partner on 2015. 5. 19..
//  Copyright (c) 2015년 partner. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PartnerPushConnection : NSObject

@property (nonatomic, strong) NSString *mAppId;
@property (nonatomic, strong) NSString *mBrokerUri;
@property (nonatomic, strong) NSString *mApiKey;
@property (nonatomic, strong) NSString *mSessionId;
@property (nonatomic, assign) int mkeepAlive;

- (id)initWithAppId:(NSString *)appId BrokerUri:(NSString *)uri ApiKey:(NSString *)apiKey SessionId:(NSString *)sessionId KeepAlive:(int)keepAlive;

@end
