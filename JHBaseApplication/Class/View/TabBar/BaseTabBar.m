//
//  BaseTabBar.m
//  JHBaseApplication
//  自定义tabbar，添加特殊按钮
//  Created by guliwei on 2022/10/8.
//

#import "BaseTabBar.h"
#import "BaseTabBarM.h"
@interface BaseTabBar ()

/**投稿发布按钮*/
@property (nonatomic,weak) UIButton *centerButton;
/**上一次点击的按钮*/
@property (nonatomic,weak) UIControl *previousClickedTabBarButton;

@end

@implementation BaseTabBar

- (UIButton *)centerButton {
    if (!self.isNeedCenterButton) {
        return nil;
    }
    if (!self.btnModel) {
        return nil;
    }
    if (!_centerButton) {
        UIButton *centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        //        [plusButton setBackgroundImage:[UIImage imageNamed:@"switch_closs-1"] forState:UIControlStateNormal];
        [centerButton setImage:[UIImage imageNamed:self.btnModel.imageName] forState:UIControlStateNormal];
        [centerButton setImage:[UIImage imageNamed:self.btnModel.selectImageName] forState:UIControlStateSelected];
        [centerButton setTitle:self.btnModel.title forState:UIControlStateNormal];
        //文字字号是11
        centerButton.titleLabel.font = [UIFont systemFontOfSize:11];
        [centerButton setTitleColor:kTabBarItemColor forState:UIControlStateNormal];
        [centerButton setTitleColor:kTabBarItemSelectedColor forState:UIControlStateSelected];
        centerButton.tintAdjustmentMode = UIViewTintAdjustmentModeAutomatic;
        [centerButton addTarget:self action:@selector(plusButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //计算按钮的大小
        NSInteger count = self.items.count + 1;
        CGFloat btnW = self.bounds.size.width / count;
        CGFloat btnH = self.bounds.size.height;
        
        centerButton.frame = CGRectMake(0, 0, btnW, btnH);
        _centerButton = centerButton;
        //设置图片和文字垂直居中
        CGSize imgViewSize,titleSize,btnSize;
        UIEdgeInsets imageViewEdge,titleEdge;
        
//        我测试下来，当button的contentHorizontalAlignment为居中时，偏移的距离和实际传的值有些偏差，没有发现规律，看不到源码也没在研究，但把button的contentHorizontalAlignment设为居左时，contentVerticalAlignment设为居上时，可以很方便的通过EdgeInsets改变两个子控件的位置
        centerButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        centerButton.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
        //图片尺寸
        imgViewSize = centerButton.imageView.bounds.size;
        //文字尺寸
        titleSize = centerButton.titleLabel.bounds.size;
        //按钮尺寸
        btnSize = centerButton.bounds.size;
        
//        imageViewEdge = UIEdgeInsetsMake(-titleSize.height,titleSize.width, titleSize.height, -titleSize.width);
         imageViewEdge = UIEdgeInsetsMake(-5,(btnSize.width - imgViewSize.width) / 2, 0, 0);
        
        //文字和图片有的间距
        NSInteger screeW = (NSInteger)kSCREEN_W;
        if (screeW == 320) {
            titleEdge = UIEdgeInsetsMake(imgViewSize.height, (-imgViewSize.width + (btnSize.width / 2) - (titleSize.width / 2) - 5), 0.0, 0.0);
        }else {
            titleEdge = UIEdgeInsetsMake(imgViewSize.height, (-imgViewSize.width + (btnSize.width / 2) - (titleSize.width / 2)), 0.0, 0.0);
        
        }
        
        
        [centerButton setTitleEdgeInsets:titleEdge];
        [centerButton setImageEdgeInsets:imageViewEdge];
        [self addSubview:centerButton];
    }
    return  _centerButton;
}




/**中间发布按钮点击*/
- (void)plusButtonClick:(UIButton *)button {
    if (self.tabBarPlusButtonClickHandle) {
        self.tabBarPlusButtonClickHandle(button);
    }
}


- (void)layoutSubviews {
    [super layoutSubviews];
    if (!self.isNeedCenterButton) {
        return;
    }
    
    CGFloat bottomMargin = kSafeAreaInsetsBottomHeight;
    self.barStyle = UIBarStyleDefault;
//    self.backgroundColor = [UIColor blackColor];
    NSInteger count = self.items.count + 1;
    CGFloat btnW = self.bounds.size.width / count;
    CGFloat btnH = self.bounds.size.height - bottomMargin;
    
    CGFloat btnX = 0;
    NSInteger i = 0;
    //注意这里UITabBarButton也是UIcontrol
    for (UIControl *tabBarButton in self.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {//先布局tabBarButton
            if (count % 2) {//是奇数
                if (i == count / 2) {//中间那个item往后移
                    i += 1;
                }
            }else{//是偶数
                if (i == 2) {//第三个往后移
                    i += 1;
                }
            }
            btnX = i * btnW;
            tabBarButton.frame = CGRectMake(btnX, 0, btnW, btnH);
            i++;
            //监听点击
            [tabBarButton addTarget:self action:@selector(buttonDownRepeatClick:) forControlEvents:UIControlEventTouchUpInside];
            if ((i == 0) && self.previousClickedTabBarButton == nil) {//判断第一次进入第一个界面的时候，默认要记录点击了一次第一个tabbarItem
                self.previousClickedTabBarButton = tabBarButton;
            }
        }
    }
    self.centerButton.frame = CGRectMake(0, 0, btnW, btnH);
    if (count % 2) {//是奇数
        self.centerButton.center = CGPointMake(self.frame.size.width * 0.5, (self.frame.size.height - bottomMargin) * 0.5 + self.btnModel.btnYOffset);
    }else{//放在第三个位置处
        self.centerButton.center = CGPointMake(btnW * (count / 2 + 0.5), (self.frame.size.height - bottomMargin)  * 0.5 + self.btnModel.btnYOffset );
    }
    
    
}

//tabbar按钮被重复点击
- (void)buttonDownRepeatClick:(UIControl *)barButtonItem {
    if (self.previousClickedTabBarButton == barButtonItem) {
        //发送重复点击通知通知
        [[NSNotificationCenter defaultCenter] postNotificationName:TabBarDidRepeatClickNotification object:nil userInfo:nil];
    }
    self.previousClickedTabBarButton = barButtonItem;
    
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    //这一个判断是关键，不判断的话push到其他页面，点击发布按钮的位置也是会有反应的，这样就不好了
    //self.isHidden == NO 说明当前页面是有tabbar的，那么肯定是在导航控制器的根控制器页面
    //在导航控制器根控制器页面，那么我们就需要判断手指点击的位置是否在发布按钮身上
    //是的话让发布按钮自己处理点击事件，不是的话让系统去处理点击事件就可以了
    if (self.isHidden == NO) {
        
        //将当前tabbar的触摸点转换坐标系，转换到发布按钮的身上，生成一个新的点
        CGPoint newP = [self convertPoint:point toView:self.centerButton];
        //判断如果这个新的点是在发布按钮身上，那么处理点击事件最合适的view就是发布按钮
        if ( [self.centerButton pointInside:newP withEvent:event]) {
            return self.centerButton;
        }else{//如果点不在发布按钮身上，直接让系统处理就可以了
            return [super hitTest:point withEvent:event];
        }
    }
    else {//tabbar隐藏了，那么说明已经push到其他的页面了，这个时候还是让系统去判断最合适的view处理就好了
        return [super hitTest:point withEvent:event];
    }
}

@end
