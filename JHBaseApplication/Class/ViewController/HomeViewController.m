//
//  HomeViewController.m
//  JHBaseApplication
//
//  Created by 聂金浩 on 2022/9/30.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    self.title = @"首页";
    self.view.backgroundColor = [UIColor purpleColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];

    NSLog(@"JDJR_StatusBarHeight:%f",JDJR_StatusBarHeight);
    NSLog(@"JDJR_NaviBarHeight:%f",JDJR_NaviBarHeight);
    NSLog(@"JDJR_BottomSafeInset:%f",JDJR_BottomSafeInset);
    NSLog(@"JDJR_Width:%f",JDJR_Width);
    NSLog(@"JDJR_Height:%f",JDJR_Height);
    NSLog(@"JDJR_RTO:%f",JDJR_RTO);
    NSLog(@"JDJR_R:%f",JDJR_R(200));
    NSLog(@"JDJR_isIphoneX:%d",JDJR_isIphoneX);
    
    
    JDJR_Request *requset = [[JDJR_Request alloc] init];
    
    [requset jTalkGetCustomerWithBlock:^(NSDictionary *result) {
        JDJR_SAFE_Dispatch_main_async(^{
            NSLog(@"result:%@",result);
        });
    } failure:^{
        JDJR_SAFE_Dispatch_main_async(^{
            NSLog(@"failure");
        })
    }];
}

@end
