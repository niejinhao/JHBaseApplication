//
//  JH_Common.h
//  JHBaseApplication
//
//  Created by 聂金浩 on 2022/10/8.
//


#import "JDJR_UIKitTool.h"

#define JDJR_StatusBarHeight            [JDJR_UIKitTool jdjr_statusBarHeight]
#define JDJR_NaviBarHeight              [JDJR_UIKitTool jdjr_navigationHeight]
#define JDJR_BottomSafeInset            [JDJR_UIKitTool jdjr_safeAreaInsets]
#define JDJR_Width                      [JDJR_UIKitTool jdjr_screenWidth]
#define JDJR_Height                     [JDJR_UIKitTool jdjr_screenHeight]
#define JDJR_RTO                        (JDJR_Width / 375.f)
#define JDJR_R(x)                       (floor((JDJR_RTO * x) * [UIScreen mainScreen].scale) / [UIScreen mainScreen].scale)
#define JDJR_isIphoneX                  [JDJR_UIKitTool jdjr_deviceVersionIsIphoneX]
