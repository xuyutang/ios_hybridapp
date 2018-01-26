//
//  HttpHelp.h
//  SalesManager
//
//  Created by iOS-Dev on 2017/12/19.
//  Copyright © 2017年 yutang xu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

typedef enum REQUEST_STATUS{
    
    DONE = 0,
    NETWROK_NOT_AVAILABLE,
    WEBSOCKET_NOT_OPEN,
    RECONNECT_WEBSOCKET,
    NETWORK_BUSSY
    
}REQUEST_STATUS;

@protocol HttpRequestDelegate <NSObject>

- (void) receiveMessage:(id)message;
- (void) didFailWithError:(NSError *)error;
- (void) didRejected;
- (void) didOpen;
- (void) didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean;


@end

@interface HttpRequestHelper : NSObject<ASIHTTPRequestDelegate> {
    NSMutableData* responseData;
}


@property(nonatomic,assign) id<HttpRequestDelegate>delegate;

+(HttpRequestHelper*)sharedInstance;

-(REQUEST_STATUS) postDataWithUrl:(NSString*)url withRequestMapping:(NSString*)requestMapping andCallBack:(id)callback andContent:(id)content withFiles:(id)files;

@end
