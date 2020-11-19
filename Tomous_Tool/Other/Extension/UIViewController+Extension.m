//
//  UIViewController+Extension.m
//  carrier
//
//  Created by 大橙子 on 2019/6/22.
//  Copyright © 2019 Tomous. All rights reserved.
//

#import "UIViewController+Extension.h"

@implementation UIViewController (Extension)
+ (instancetype)controller
{
    UIViewController* controller = [[self alloc] init];
    return controller;
}

+ (id<UIApplicationDelegate>)applicationDelegate {
    return [UIApplication sharedApplication].delegate;
}

+ (UIViewController *)rootViewController {
    return self.applicationDelegate.window.rootViewController;
}

+ (UINavigationController*)currentNavigationViewController {
    return self.currentViewController.navigationController;
}

+ (UIViewController *)currentViewController {
    return [self currentViewControllerFrom:self.rootViewController];
}

+ (UIViewController*)currentViewControllerFrom:(UIViewController*)viewController {
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController *)viewController;
        return [self currentViewControllerFrom:navigationController.viewControllers.lastObject];
    }
    else if([viewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tabBarController = (UITabBarController *)viewController;
        return [self currentViewControllerFrom:tabBarController.selectedViewController];
    }
    else if(viewController.presentedViewController != nil) {
        return [self currentViewControllerFrom:viewController.presentedViewController];
    }
    else {
        return viewController;
    }
}

@end
