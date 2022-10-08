//
//  BaseTabBarVC.m
//  JHBaseApplication
//  自定义tabbar控制器
//  Created by guliwei on 2022/10/8.
//

#import "BaseTabBarVC.h"
#import "BaseTabBarM.h"
#import "BaseTabBar.h"

#import "HomeViewController.h"
#import "MusicViewController.h"
#import "SettingViewController.h"

@interface BaseTabBarVC ()
/** 配置model的model数组 */
@property (nonatomic,strong) NSArray <BaseTabBarM *> * modelArray;

/** 将要传给baseTabbar的特殊按钮model */
@property (nonatomic,strong) BaseTabBarM * specialModel;
/** 为了能修改plusBtn的状态所以拿出来 */
@property (nonatomic,strong) UIButton * plusBtn;
@end

@implementation BaseTabBarVC

/** 在这里配置tabbar就可以了 */
/**
 * title                            : item的标题 NSString
 * imageName                        : item未选中时刻的图片名称 NSString
 * selectImageName                  : item选中时刻的图片民称 NSSTring
 * viewControllerClassString        : item控制器类名
 * navigationControllerClassString  : item导航控制器类名（可以不设置） NSString
 * btnYOffset                       : 中间btn的偏移量
 */
- (NSArray<BaseTabBarM *> *)modelArray {
    if (!_modelArray) {
        _modelArray = @[

                        [BaseTabBarM tabbarModelWithTitle:@"首页"
                                                    ImageName:@"tab_home_nol"
                                              SelectImageName:@"tab_home_sel"
                                    ViewControllerClassString:[HomeViewController description]
                              NavigationControllerClassString:[UINavigationController description]
                                                IsSpecialItem:NO
                                                   BtnYOffset:0
                         ],
                        [BaseTabBarM tabbarModelWithTitle:@""
                                                    ImageName:@"tab-bar-tag"
                                              SelectImageName:@""
                                    ViewControllerClassString:[MusicViewController description]
                              NavigationControllerClassString:[UINavigationController description]
                                                IsSpecialItem:YES
                                                   BtnYOffset:-10
                         ],
                        [BaseTabBarM tabbarModelWithTitle:@"设置"
                                                    ImageName:@"tab_mine_nol"
                                              SelectImageName:@"tab_mine_sel"
                                    ViewControllerClassString:[SettingViewController description]
                              NavigationControllerClassString:[UINavigationController description]
                                                IsSpecialItem:NO
                                                   BtnYOffset:0
                         ]
                        ];
    }
    return _modelArray;
}


- (void)configItemStyle {

#warning 注意：在这设置tabbaritem的字体颜色和字体大小。。。
    //正常状态字体颜色(ios10之后用这个)
    [[UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[[self class]]] setTitleTextAttributes:@{NSForegroundColorAttributeName:kTabBarItemColor} forState:UIControlStateNormal];
    //（iOS10之前用这个）
    //    [[UITabBarItem appearanceWhenContainedIn:[self class],  nil] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor clearColor]} forState:UIControlStateNormal];
    
    //文字缩进(可以让文字往上点)
    [[UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[[self class]]] setTitlePositionAdjustment:UIOffsetMake(0, 0)];
#warning 设置选中的字体颜色
    //选中时字体颜色
    [[UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[[self class]]] setTitleTextAttributes:@{NSForegroundColorAttributeName : kTabBarItemSelectedColor} forState:UIControlStateSelected];
    
#warning 设置tab的颜色
    //TabBar栏颜色
    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_W, kBottomBarHeight)];
    backView.backgroundColor = [UIColor whiteColor];
    [[UITabBar appearanceWhenContainedInInstancesOfClasses:@[[self class]]] insertSubview:backView atIndex:0];
//    [[UITabBar appearanceWhenContainedInInstancesOfClasses:@[[self class]]] setBackgroundImage:[UIImage imageNamed:@"pageControlCurrentDot"]];

}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTabBar];
    
}


- (void)createTabBar {
    
    if (self.modelArray) {
    
        __weak typeof(self)weakSelf = self;
        
        for (BaseTabBarM *obj in self.modelArray) {
            if (obj.isSpecialItem) {
                weakSelf.specialModel = obj;
                continue;
            }else{
                
            }
            UIViewController *vc = [[NSClassFromString(obj.viewControllerClassString) alloc] init];
            UINavigationController *nav;
            UITabBarItem *item;
            if (obj.navigationControllerClassString) {
                nav = [[NSClassFromString(obj.navigationControllerClassString) alloc] initWithRootViewController:vc];
                item = nav.tabBarItem;
            }else{
                item = vc.tabBarItem;
            }
            item.title = vc.title = obj.title;
            
            item.image = [[UIImage imageNamed:obj.imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            item.selectedImage = [[UIImage imageNamed:obj.selectImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            
            if (nav) {
                [weakSelf addChildViewController:nav];
            }else{
                [weakSelf addChildViewController:vc];
            }
        }
  
    }
    //配置item的样式
    [self configItemStyle];
    
    //添加自定义tabbar
    [self setTabBar];
    
}


- (void)setTabBar {
    BaseTabBar *tabBar = [[BaseTabBar alloc] init];
    if (self.specialModel) {
        tabBar.btnModel = self.specialModel;
        tabBar.isNeedCenterButton = YES;
    }
    WS(weakSelf);
    //中间投稿页点击事件
    [tabBar setTabBarPlusButtonClickHandle:^(UIButton *plusBtn) {
      //配置中间按钮点击事件
        
        weakSelf.plusBtn = plusBtn;
        
        [weakSelf plusBtnClick:plusBtn];
        
    }];
    //设置自定义的tabBar
    [self setValue:tabBar forKey:@"tabBar"];
    //让tabbar默认选中第一个
//    self.selectedIndex = 0;
}





#pragma mark - btnClick

- (void)plusBtnClick:(UIButton *)plusBtn{
    MusicViewController *vc = [[MusicViewController alloc] init];
    [self pushVc:vc];
}




#pragma mark - 带tabbar的页面PUSH
//push隐藏tabBar
- (void)pushVc:(UIViewController *)vc {
    if ([vc isKindOfClass:[UIViewController class]] == NO) return ;
    if (vc.hidesBottomBarWhenPushed == NO) {
        vc.hidesBottomBarWhenPushed = YES;
    }
    [self.selectedViewController pushViewController:vc animated:YES];
}

@end
