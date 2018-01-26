//
//  HttpHelp.m
//  SalesManager
//
//  Created by iOS-Dev on 2017/12/19.
//  Copyright © 2017年 yutang xu. All rights reserved.
//

#import "HttpRequestHelper.h"
#import "AppSessionBoard.pb.h"
#import "NSString+Util.h"
#import "DataOutputStream.h"
#import "DataInputStream.h"
#import "ProductConstant.h"

@implementation HttpRequestHelper


+(HttpRequestHelper*)sharedInstance {
    static HttpRequestHelper *httpHelp = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        httpHelp = [[HttpRequestHelper alloc] init];
    });
    return httpHelp;
}

-(instancetype)init {
    if (responseData != nil) {
        [self resetResponseData];
        responseData = nil;
    }
    responseData = [[NSMutableData alloc] init];
    return self;
}

- (void)resetResponseData{
    [responseData resetBytesInRange:NSMakeRange(0, [responseData length])];
    [responseData setLength:0];
}

-(REQUEST_STATUS) postDataWithUrl:(NSString*)url withRequestMapping:(NSString*)requestMapping andCallBack:(id)callback andContent:(id)content withFiles:(id)files {
    NSData *dtRequest = nil;
    NSArray *fileArray= [NSJSONSerialization JSONObjectWithData:[files dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil] ;
    
    //AppSessionRequest 对象组装
    AppSessionRequest_Builder *asr = [AppSessionRequest builder];
    [asr setSequence:[NSString UUID]];
    [asr setRequestMapping:requestMapping];
    [asr setContent:content];
    
    NSMutableArray *sessinFileArray = [[NSMutableArray alloc] init];
     __block  NSMutableArray *itemsMulArray = [[NSMutableArray alloc] init];
    NSMutableArray *itemsMularry = [[NSMutableArray alloc] init];
    
    [fileArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SessionFile_Builder *sf = [SessionFile builder];

        [sf setFieldName:[obj objectForKey:@"fieldName"]];
        
        itemsMulArray = [obj objectForKey:@"items"];
        [itemsMulArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           SessionFileItem_Builder *item = [SessionFileItem builder];
            
            NSString *type = @"";
            type = [obj objectForKey:@"type"];
            [item setType:type];
            //图片／视频
            if ([type isEqualToString:@"jpg"]) {
                UIImage *tmpImg = [UIImage imageWithContentsOfFile:[obj objectForKey:@"file"] ];
                NSData *dataImg = UIImageJPEGRepresentation(tmpImg,0.5);
                [item setFile:dataImg];
            }else {
                NSData *data = [[NSData alloc] initWithContentsOfFile:[obj objectForKey:@"file"]];
                [item setFile:data];

            }
           
          //  [item setFile:[[obj objectForKey:@"file"] dataUsingEncoding:NSUTF8StringEncoding]];
            NSLog(@"*********%@*******",[[obj objectForKey:@"file"] dataUsingEncoding:NSUTF8StringEncoding]);
            SessionFileItem *it = [item build];
            [itemsMularry addObject:it];
            
        }];
        
       
        [sf setItemsArray:itemsMularry];
        
        SessionFile *file = [sf build];
        
        [sessinFileArray addObject:file];
}];
    
    //
    [asr setSessionFilesArray:sessinFileArray];
    NSTimeInterval timeInMiliseconds = [[NSDate date] timeIntervalSince1970];

    NSString* tokenStr = [NSString stringWithFormat:@"%@%@%f",APP_KEY,APP_SECRET,timeInMiliseconds];
    [asr setAuthToken:tokenStr];
    
    AppSessionRequest *cr = [asr build];
    dtRequest = [cr dataStream];
    
  if (dtRequest != nil) {
        NSLog(@"send data length:%lu",(unsigned long)dtRequest.length);
        //创建请求
        ASIHTTPRequest *httpRequest = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
        [httpRequest setRequestMethod:@"POST"];
        httpRequest.timeOutSeconds = 60.f;
        [httpRequest addRequestHeader:@"Content-Type" value:@"application/x-protobuf"];

        //加密传输数据
        DataOutputStream* stream = [[DataOutputStream alloc] init];
       // NSData* encryptData = [dtRequest AES256EncryptedDataWithKey:[APP_KEY substringToIndex:16] iv:IV_KEY];
      
       // NSLog(@"encrypt data size:%lu", (unsigned long)encryptData.length);
        [stream writeInt:dtRequest.length];
        [stream writeBytes:dtRequest];
        NSData* data = [stream toByteArray];
        [httpRequest setPostBody:[NSMutableData dataWithData:data]];
        
        httpRequest.delegate = self;
        [httpRequest startSynchronous];
   }
    return DONE;
}


#pragma mark 请求成功
-(void)requestFinished:(ASIHTTPRequest *)request {
    NSLog(@"request.responseStatusCode:%d",request.responseStatusCode);
    if (request.responseStatusCode == 502) {
        AppSessionResponse_Builder* crb = [AppSessionResponse builder];
        [crb setSequence:[NSString UUID]];
      //  [crb setResultMessage:NSLocalizedString(@"server_bad_error", nil)];
        return;
    }
    DataInputStream* inputStream = [DataInputStream dataInputStreamWithData:responseData];
    NSData* d = [inputStream readData];
//    //解密返回数据
//    decryptData = [d AES256DecryptedDataWithKey:[APP_KEY substringToIndex:16] iv:IV_KEY];
    AppSessionResponse* cr = [AppSessionResponse parseFromData:d];
    NSLog(@"HTTP Request Finished.");
    NSLog(@"Session Response Code:%@",cr.responseCode);
    
    if ([self.delegate respondsToSelector:@selector(receiveMessage:)]) {
        NSLog(@"callBack &&&&&&&回调");
        [self.delegate receiveMessage:cr.responseCode];

    }
}

#pragma mark 请求失败
-(void)requestFailed:(ASIHTTPRequest *)request {
    NSLog(@"request.error == %@",request.error);
    [self.delegate didFailWithError:request.error];
}

#pragma mark 返回HTTP头信息
- (void)request:(ASIHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders{
    
}

#pragma mark 返回HTTP数据
- (void)request:(ASIHTTPRequest *)request didReceiveData:(NSData *)data{
    [responseData appendData:data];
}

@end
