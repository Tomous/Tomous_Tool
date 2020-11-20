//
//  DCTabBar.m
//  Tomous_Tool
//
//  Created by Tomous on 2020/11/19.
//

#import "DCTabBar.h"

@interface DCTabBar ()
@property (nonatomic,weak) UIButton *plusButton;
@end
@implementation DCTabBar
-(UIButton *)plusButton
{
    if (!_plusButton) {
        UIButton *plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        plusButton.backgroundColor = [UIColor redColor];
        [plusButton addTarget:self action:@selector(plusButtonDidClick) forControlEvents:UIControlEventTouchUpInside];
        [plusButton setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [plusButton setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [self addSubview:plusButton];
        _plusButton = plusButton;
    }
    return _plusButton;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
//        self.backgroundImage = IMAGENAME(@"tabbar-light");
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat buttonW = self.width/5;
    //如果是刘海屏，tabBar的高度是83，需要减去下面34的高度
    CGFloat buttonH = self.height - bottomSafeHeight;
    CGFloat buttonY = 0;
    
    int buttonIndex = 0;
    
    for (UIView *subView in self.subviews) {
        if (subView.class != NSClassFromString(@"UITabBarButton")) continue;
        
        CGFloat buttonX = buttonIndex *buttonW;
        if (buttonIndex >= 2) {
            buttonX += buttonW;
        }
        subView.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        buttonIndex ++;
    }
    self.plusButton.size = CGSizeMake(buttonW, buttonH);
    self.plusButton.center = CGPointMake(self.width * 0.5, buttonH * 0.5);
}
-(void)plusButtonDidClick
{
    DCLogFunc
    if (_tabBarDelegate && [_tabBarDelegate respondsToSelector:@selector(plusButtonDidClick)]) {
        [_tabBarDelegate plusButtonDidClick];
    }
}

@end
