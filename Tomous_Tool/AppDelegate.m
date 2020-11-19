//
//  AppDelegate.m
//  Tomous_Tool
//
//  Created by Tomous on 2020/11/19.
//

#import "AppDelegate.h"
#import "DCBaseViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    DCBaseViewController *vc = [[DCBaseViewController alloc]init];
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
    return YES;
}


@end
