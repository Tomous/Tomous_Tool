//
//  UIBarButtonItem+Extension.m
//  包子微博
//
//  Created by 尚承教育 on 15/6/4.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+ (UIBarButtonItem *)creatBarButtonItemWithNorImageName:(NSString *)norImageName higImageName:(NSString *)higImageName target:(id)target active:(SEL)action
{
    UIButton *Btn = [[UIButton alloc]init];
    [Btn setImage:[UIImage imageNamed:norImageName] forState:UIControlStateNormal];
    [Btn setImage:[UIImage imageNamed:higImageName] forState:UIControlStateHighlighted];
    Btn.size = CGSizeMake(30, 44);
    [Btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:Btn];
    
}
+(UIBarButtonItem *)creatBarButtonItemWithtitle:(NSString *)title titleColor:(UIColor *)titleColor target:(id)target active:(SEL)action {
    
    UIButton *Btn = [[UIButton alloc]init];
    [Btn setTitle:title forState:UIControlStateNormal];
    [Btn setTitleColor:titleColor forState:UIControlStateNormal];
    
    Btn.size = Btn.titleLabel.size;
    [Btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:Btn];
}


+(UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(UIImage *)image {
    return [self itemWithTarget:target action:action nomalImage:image higeLightedImage:nil imageEdgeInsets:UIEdgeInsetsZero];
}

+(UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(UIImage *)image imageEdgeInsets:(UIEdgeInsets)imageEdgeInsets {
    return [self itemWithTarget:target action:action nomalImage:image higeLightedImage:nil imageEdgeInsets:imageEdgeInsets];
}

+(UIBarButtonItem *)itemWithTarget:(id)target
                            action:(SEL)action
                        nomalImage:(UIImage *)nomalImage
                  higeLightedImage:(UIImage *)higeLightedImage
                   imageEdgeInsets:(UIEdgeInsets)imageEdgeInsets {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    [button setImage:[nomalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    if (higeLightedImage) {
        [button setImage:higeLightedImage forState:UIControlStateHighlighted];
    }
    [button sizeToFit];
    if (button.bounds.size.width < 40) {
        CGFloat width = 40 / button.bounds.size.height * button.bounds.size.width;
        button.bounds = CGRectMake(0, 0, width, 40);
    }
    if (button.bounds.size.height > 40) {
        CGFloat height = 40 / button.bounds.size.width * button.bounds.size.height;
        button.bounds = CGRectMake(0, 0, 40, height);
    }
    DCLog(@"-----%@",NSStringFromCGRect(button.frame));
    button.imageEdgeInsets = imageEdgeInsets;
    return [[UIBarButtonItem alloc] initWithCustomView:button];
    
}

+(UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action title:(NSString *)title {
    return [self itemWithTarget:target action:action title:title font:nil titleColor:nil highlightedColor:nil titleEdgeInsets:UIEdgeInsetsZero];
}

+(UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action title:(NSString *)title titleEdgeInsets:(UIEdgeInsets)titleEdgeInsets {
    return [self itemWithTarget:target action:action title:title font:nil titleColor:nil highlightedColor:nil titleEdgeInsets:titleEdgeInsets];
}

+(UIBarButtonItem *)itemWithTarget:(id)target
                            action:(SEL)action
                             title:(NSString *)title
                              font:(UIFont *)font
                        titleColor:(UIColor *)titleColor
                  highlightedColor:(UIColor *)highlightedColor
                   titleEdgeInsets:(UIEdgeInsets)titleEdgeInsets {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = font?font:nil;
    [button setTitleColor:titleColor?titleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:highlightedColor?highlightedColor:nil forState:UIControlStateHighlighted];
    
    [button sizeToFit];
    if (button.bounds.size.width < 40) {
        CGFloat width = 40 / button.bounds.size.height * button.bounds.size.width;
        button.bounds = CGRectMake(0, 0, width, 40);
    }
    if (button.bounds.size.height > 40) {
        CGFloat height = 40 / button.bounds.size.width * button.bounds.size.height;
        button.bounds = CGRectMake(0, 0, 40, height);
    }
    button.titleEdgeInsets = titleEdgeInsets;
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+(UIBarButtonItem *)fixedSpaceWithWidth:(CGFloat)width {
    
    UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedSpace.width = width;
    return fixedSpace;
}

@end
