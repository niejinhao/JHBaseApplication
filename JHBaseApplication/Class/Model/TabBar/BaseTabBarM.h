//
//  BaseTabBarM.h
//  JHBaseApplication
//  自定义tabbar模型，用于设置tabbar配置
//  Created by guliwei on 2022/10/8.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#pragma  mark - 屏幕的尺寸
//屏幕的尺寸
#define kSCREEN_W    [[UIScreen mainScreen] bounds].size.width
#define kSCREEN_H    [[UIScreen mainScreen] bounds].size.height
//StatusBar高度
#define kStatusBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height)
//导航条高度
#define kNavBarHeight (44.0)
//导航条高度
#define kTopBarHeight (kStatusBarHeight + kNavBarHeight)
//Tabbar高度
#define kTabbarHeight (49.0)

//安全区域底部
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_10_3
    #define kSafeAreaInsetsBottomHeight UIApplication.sharedApplication.delegate.window.safeAreaInsets.bottom
#else
    #define kSafeAreaInsetsBottomHeight 0.0
#endif

//底部栏整个高度
#define kBottomBarHeight (kSafeAreaInsetsBottomHeight + kTabbarHeight)


#pragma mark -  获取一个弱引用
//获取一个弱引用
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#pragma mark -  颜色
#define kUIColorFromRGB(r,g,b) [UIColor colorWithRed:r/255. green:g/255. blue:b/255. alpha:1]
#define kUIColorFromRGBA(r,g,b,a) [UIColor colorWithRed:r/255. green:g/255. blue:b/255. alpha:a]
#define kUIColorFromValue(Value) [UIColor colorWithRed:((float)((Value & 0xFF0000) >> 16))/255.0 green:((float)((Value & 0xFF00) >> 8))/255.0 blue:((float)(Value & 0xFF))/255.0 alpha:1]

/**
 随机色
 */
#define kRandomColor kUIColorFromRGBA(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
/**tabBaritem未选中颜色*/
#define kTabBarItemColor kUIColorFromValue(0xaca4a4)
/**tabBaritem选中颜色*/
#define kTabBarItemSelectedColor kUIColorFromValue(0x3B7CFF)

/** tabbaritem重复点击通知名称 */
static NSString *const TabBarDidRepeatClickNotification = @"TabBarDidRepeatClickNotification";


@interface BaseTabBarM : NSObject
/**
 标题
 */
@property (nonatomic,copy) NSString *title;
/**
 图片的名称
 */
@property (nonatomic,copy) NSString *imageName;
/**
 选中图片的名称
 */
@property (nonatomic,copy) NSString *selectImageName;
/**
 控制器类名
 */
@property (nonatomic,copy) NSString *viewControllerClassString;
/**
 导航控制器类名
 */
@property (nonatomic,copy) NSString *navigationControllerClassString;

/**
 是否是一个特殊的按钮
 */
@property (nonatomic,assign) BOOL isSpecialItem;

/**
 按钮纵向偏移量
 */
@property (nonatomic,assign) CGFloat btnYOffset;


/** 快速构建一个tabbarmodel */
+ (instancetype)tabbarModelWithTitle:(NSString * )title ImageName:(NSString * )imageName SelectImageName:(NSString *)selectImageName ViewControllerClassString:(NSString *)viewControllerClassString NavigationControllerClassString:(NSString *)navigationControllerClassString IsSpecialItem:(BOOL)isSpecialItem BtnYOffset:(CGFloat)btnYOffset;

@end

NS_ASSUME_NONNULL_END
