//
//  JDJR_UIKitTool.m
//  JD_Peter
//
//  Created by zryy on 2019/7/10.
//

#import "JDJR_UIKitTool.h"

@implementation JDJR_UIKitTool

+ (UIViewController *)getTopVc {
    
    UIWindow *topWindow = [UIApplication sharedApplication].keyWindow;
    
    if (topWindow.windowLevel != UIWindowLevelNormal) {
        topWindow = [self returnWindowWithWindowLevelNormal];
    }
    
    UIViewController *topController = topWindow.rootViewController;
    if (topController == nil) {
        
        topWindow = [UIApplication sharedApplication].delegate.window;
        if (topWindow.windowLevel != UIWindowLevelNormal) {
            topWindow = [self returnWindowWithWindowLevelNormal];
        }
        topController = topWindow.rootViewController;
    }
    
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    
    if ([topController isKindOfClass:[UINavigationController class]]) {
        
        UINavigationController *nav = (UINavigationController*)topController;
        topController = [nav.viewControllers lastObject];
        while(topController.presentedViewController) {
            topController = topController.presentedViewController;
        }
    }
    return topController;
}

+ (UIWindow *)returnWindowWithWindowLevelNormal {
    
    NSArray *windows = [UIApplication sharedApplication].windows;
    for(UIWindow *topWindow in windows)
    {
        if (topWindow.windowLevel == UIWindowLevelNormal)
            return topWindow;
    }
    return [UIApplication sharedApplication].keyWindow;
}


+ (CGFloat)jdjr_screenWidth {
    
    return [UIScreen mainScreen].bounds.size.width;
}

+ (CGFloat)jdjr_screenHeight {
    
    return [UIScreen mainScreen].bounds.size.height;
}

+ (CGFloat)jdjr_statusBarHeight {
    
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    return rectStatus.size.height;
}

+ (CGFloat)jdjr_navigationBarHeight {
    
    return 44.0f;
}

+ (CGFloat)jdjr_navigationHeight {
    
    return [self jdjr_navigationBarHeight] + [self jdjr_statusBarHeight];
}

+ (CGFloat)jdjr_safeAreaInsets {
    
    CGFloat height = 0.0;
    if (@available(iOS 11.0, *)) {
        UIWindow *window = UIApplication.sharedApplication.delegate.window;
        height = window.safeAreaInsets.bottom;
    }
    return height;
}

+ (BOOL)jdjr_deviceVersionIsIphoneX {
    
    if ([self jdjr_statusBarHeight] == 44) {
        return YES;
    }else if ([self jdjr_statusBarHeight] == 48) {
        return YES;
    }
    return NO;
}


@end
