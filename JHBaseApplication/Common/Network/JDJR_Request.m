//
//  JDJR_Request.m
//  Pods
//
//  Created by zryy on 31/05/2019.
//

#import "JDJR_Request.h"
#import "JDJR_NetworkCode.h"

@interface JDJR_Request ()

@property (nonatomic, strong) NSURLSession *session;

@end

@implementation JDJR_Request

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        self.session = [NSURLSession sessionWithConfiguration:configuration];
    }
    return self;
}



#pragma mark 返回 request

- (NSMutableURLRequest *)jTalkRequestWithURL:(NSString *)urlStr body:(NSDictionary *)parameters {
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    
    /** 请求头 */
    [request setHTTPMethod:@"POST"];
    [request setTimeoutInterval:15];
    [request setValue:@"C_CLIENT_SDK" forHTTPHeaderField:@"clientType"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    return request;
}


#pragma mark 发送网络请求

- (NSURLSessionDataTask *)jTalkSendNetworkRequest:(NSURLRequest *)request success:(void(^)(id result))success failure:(void(^)(NSError *error))failure {
    
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error == nil) {
            
            NSError *resultError;
            id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&resultError];
            
            if (result) {
                
                if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                    
                    NSHTTPURLResponse *httpUrlResponse = (NSHTTPURLResponse *)response;
                    NSString *setCookie = httpUrlResponse.allHeaderFields[@"Set-Cookie"];
                    
                    if (setCookie != nil) {
                        
                    }
                }
                success(result);
            } else {
                failure(resultError);
            }
        } else {
            
            failure(error);
        }
    }];
    
    [dataTask resume];
    
    return dataTask;
}


#pragma mark JTalk 网络请求

- (void)jTalkGetCustomerWithBlock:(void (^)(NSDictionary *))block failure:(void (^)(void))failure {
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",JDJR_JTalkURL_TEST,JDJR_NetWork_test];

    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];

    NSMutableURLRequest *request = [self jTalkRequestWithURL:urlStr body:parameters];
    
    [self jTalkSendNetworkRequest:request success:^(id result) {
        
        block(result);
        
//        if ([result isKindOfClass:[NSDictionary class]] && result[@"resultCode"] != [NSNull null] && [result[@"resultCode"] isEqualToString:@"000000"] && [result[@"suc"] boolValue] && [result[@"suc"] boolValue] == 1) {
//            block(result[@"data"]);
//        } else {
//            failure();
//        }
        
    } failure:^(NSError *error) {
        
        failure();
    }];
}


@end
