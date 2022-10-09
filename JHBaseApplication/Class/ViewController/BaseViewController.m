//
//  BaseViewController.m
//  JHBaseApplication
//
//  Created by 聂金浩 on 2022/10/9.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setStatusBarBackgroundColor:[UIColor whiteColor]];
}

- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    if(@available(iOS 13.0, *)) {
        
        static UIView *statusBar =nil;
        if(!statusBar) {
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                statusBar = [[UIView alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.windowScene.statusBarManager.statusBarFrame] ;
                [[UIApplication sharedApplication].keyWindow addSubview:statusBar];
                statusBar.backgroundColor= color;
                
            });
        }else{
            statusBar.backgroundColor= color;
        }
    }else{
        UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
        if([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
            statusBar.backgroundColor= color;
        }
    }
}

@end
