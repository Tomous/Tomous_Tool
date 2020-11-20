//
//  DCTabBar.h
//  Tomous_Tool
//
//  Created by Tomous on 2020/11/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol tabBarDelegate <NSObject>

-(void)plusButtonDidClick;

@end
@interface DCTabBar : UITabBar

@property (nonatomic,weak) id<tabBarDelegate> tabBarDelegate;
@end

NS_ASSUME_NONNULL_END
