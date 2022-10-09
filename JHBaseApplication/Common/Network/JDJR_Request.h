//
//  Header.h
//  JDJR_Peter
//
//  Created by zryy on 31/05/2019.
//

#import <Foundation/Foundation.h>

@interface JDJR_Request: NSObject

#pragma mark jTalk客服接口

/** JTalk 用户信息接口 */
- (void)jTalkGetCustomerWithBlock:(void(^)(NSDictionary *result))block failure:(void(^)(void))failure;



@end
