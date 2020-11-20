//
//  UIViewController+Extension.h
//  carrier
//
//  Created by 大橙子 on 2019/6/22.
//  Copyright © 2019 Tomous. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Extension)
//初始化控制器
+ (instancetype)controller;
//获取根控制器
+ (UIViewController *)rootViewController;
//获取当前导航控制器
+ (UINavigationController*)currentNavigationViewController;
//获取当前控制器
+ (UIViewController *)currentViewController;
@end

NS_ASSUME_NONNULL_END
