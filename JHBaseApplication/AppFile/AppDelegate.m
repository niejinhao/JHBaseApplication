//
//  AppDelegate.m
//  JHBaseApplication
//
//  Created by 聂金浩 on 2022/9/30.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "MusicViewController.h"
#import "SettingViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    HomeViewController *home = [[HomeViewController alloc] init];
    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:home];
    homeNav.navigationBar.backgroundColor = [UIColor whiteColor];
    home.title = @"首页";
    home.view.backgroundColor = [UIColor orangeColor];
    
    MusicViewController *music = [[MusicViewController alloc] init];
    UINavigationController *musicNav = [[UINavigationController alloc] initWithRootViewController:music];
    musicNav.navigationBar.backgroundColor = [UIColor whiteColor];
    music.title = @"音乐";
    music.view.backgroundColor = [UIColor grayColor];
    
    SettingViewController *setting = [[SettingViewController alloc] init];
    UINavigationController *settingNav = [[UINavigationController alloc] initWithRootViewController:setting];
    setting.title = @"设置";
    setting.view.backgroundColor = [UIColor purpleColor];
    
    NSArray *array = [NSArray arrayWithObjects:homeNav,musicNav,settingNav, nil];
    
    UITabBarController *tabar = [[UITabBarController alloc] init];
    tabar.tabBar.backgroundColor = [UIColor whiteColor];
    tabar.viewControllers = array;
    
    self.window.rootViewController = tabar;
    [self.window makeKeyAndVisible];
    
    return YES;
}


@end
