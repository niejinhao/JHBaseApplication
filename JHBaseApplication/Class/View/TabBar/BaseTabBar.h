//
//  BaseTabBar.h
//  JHBaseApplication
//  自定义tabbar，添加特殊按钮
//  Created by guliwei on 2022/10/8.
//

#import <UIKit/UIKit.h>
@class BaseTabBarM;
NS_ASSUME_NONNULL_BEGIN

@interface BaseTabBar : UITabBar
/**
 特殊btn的配置model
 */
@property (nonatomic,strong) BaseTabBarM * btnModel;

/**
 是否要中间的特殊按钮
 */
@property (nonatomic,assign) BOOL isNeedCenterButton;

/**
 中间投稿按钮点击事件
 */
@property (nonatomic,copy) void (^tabBarPlusButtonClickHandle)(UIButton *plusButton);
@end

NS_ASSUME_NONNULL_END
