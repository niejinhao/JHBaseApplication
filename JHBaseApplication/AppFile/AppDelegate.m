//
//  AppDelegate.m
//  JHBaseApplication
//
//  Created by 聂金浩 on 2022/9/30.
//

#import "AppDelegate.h"
#import "BaseTabBarVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    BaseTabBarVC *tabbar = [[BaseTabBarVC alloc] init];
    self.window.rootViewController = tabbar;
    [self.window makeKeyAndVisible];
    
    return YES;
}


@end
