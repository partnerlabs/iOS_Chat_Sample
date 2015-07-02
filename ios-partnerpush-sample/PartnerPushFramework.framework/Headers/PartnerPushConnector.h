//
//  PartnerPushConnector.h
//
//  Created by sungwon park on 2015. 05. 18..
//

#import <Foundation/Foundation.h>
#import "PartnerPushConnection.h"
#import "PPMessage.h"
#import "JSONKit.h"

typedef enum PPQualityOfService : NSUInteger {
    PPQualityOfServiceAtMostOnce,
    PPQualityOfServiceAtLeastOnce,
    PPQualityOfServiceExactlyOnce
} PPQualityOfService;

typedef enum PPConnectionReturnCode : NSUInteger {
    PPConnectionAccepted,
    PPConnectionRefusedUnacceptableProtocolVersion,
    PPConnectionRefusedIdentiferRejected,
    PPConnectionRefusedServerUnavailable,
    PPConnectionRefusedBadUserNameOrPassword,
    PPConnectionRefusedNotAuthorized,
    PPConnectionLogout = 240
    
} PPConnectionReturnCode;

@class PartnerPushConnector;

@protocol PartnerPushDelegate <NSObject>

- (void)partnerPushReceivedWithPayload:(PPMessage *)message;

@optional

-(void)partnerPushConnectedWithCode:(PPConnectionReturnCode)code;
-(void)partnerPushFailWithCode:(PPConnectionReturnCode)code;

@end

@interface PartnerPushConnector:NSObject

// Delegate For getting message or code of connection complete
@property (nonatomic, assign) id<PartnerPushDelegate>delegate;

// Singleton
+(PartnerPushConnector *)sharedService;


// MQTT Connect
- (void)partnerPushConnectWithAppId:(NSString *)appId ApiKey:(NSString *)apiKey ClientId:(NSString *)clientId;
- (void)partnerPushConnectWithAppId:(NSString *)appId ApiKey:(NSString *)apiKey ClientId:(NSString *)clientId KeepAlive:(int)keepAlive;

// subscribe
- (void)partnerPushAddTopic:(NSString *)topic;
- (void)partnerPushAddTopics:(NSArray *)topics;

// unsubscribe
- (void)partnerPushRemoveTopic:(NSString *)topic;
- (void)partnerPushRemoveTopics:(NSArray *)topics;

// publish
- (void)partnerPushSendMessageWithString:(NSString *)content Topic:(NSString *)topic;
- (void)partnerPushSendMessageWithString:(NSString *)content Topic:(NSString *)topic Qos:(PPQualityOfService)qos;

- (void)partnerPushSendMessageWithDictionary:(NSDictionary *)content Topic:(NSString *)topic;
- (void)partnerPushSendMessageWithDictionary:(NSDictionary *)content Topic:(NSString *)topic Qos:(PPQualityOfService)qos;

- (void)partnerPushSendMessageWithData:(NSData *)content Topic:(NSString *)topic;
- (void)partnerPushSendMessageWithData:(NSData *)content Topic:(NSString *)topic Qos:(PPQualityOfService)qos;

// MQTT disconnect

- (void)partnerPushDisconnect;


// PartnerPush Log
- (void)partnerPushLog:(NSString *)message;


@end
