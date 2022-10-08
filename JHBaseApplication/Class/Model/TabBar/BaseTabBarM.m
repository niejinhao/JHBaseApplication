//
//  BaseTabBarM.m
//  JHBaseApplication
//  自定义tabbar模型，用于设置tabbar配置
//  Created by guliwei on 2022/10/8.
//

#import "BaseTabBarM.h"

@implementation BaseTabBarM
/** 快速构建一个tabbarmodel */

+ (instancetype)tabbarModelWithTitle:(NSString *)title ImageName:(NSString *)imageName SelectImageName:(NSString *)selectImageName ViewControllerClassString:(NSString *)viewControllerClassString NavigationControllerClassString:(NSString *)navigationControllerClassString IsSpecialItem:(BOOL)isSpecialItem BtnYOffset:(CGFloat)btnYOffset {
    
    BaseTabBarM *model = [[BaseTabBarM alloc] init];
    model.title = title;
    model.imageName = imageName;
    model.selectImageName = selectImageName;
    model.viewControllerClassString = viewControllerClassString;
    model.navigationControllerClassString = navigationControllerClassString;
    model.isSpecialItem = isSpecialItem;
    model.btnYOffset = btnYOffset;
    
    
    return model;
}

@end
