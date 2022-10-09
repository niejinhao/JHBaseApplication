//
//  JDJR_UIKitTool.h
//  JD_Peter
//
//  Created by zryy on 2019/7/10.
//

#import <UIKit/UIKit.h>

@interface JDJR_UIKitTool : NSObject

/**
 *  返当前最上层的控制器
 */
+ (UIViewController *)getTopVc;

/**
 *  返回当前 Normal windows
 */
+ (UIWindow *)returnWindowWithWindowLevelNormal;


+ (CGFloat)jdjr_screenWidth;
+ (CGFloat)jdjr_screenHeight;
+ (CGFloat)jdjr_statusBarHeight;
+ (CGFloat)jdjr_navigationBarHeight;
+ (CGFloat)jdjr_navigationHeight;
+ (CGFloat)jdjr_safeAreaInsets;


+ (BOOL)jdjr_deviceVersionIsIphoneX;


@end


