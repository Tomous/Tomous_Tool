//
//  DCRefreshFooter.m
//  Tomous_Tool
//
//  Created by Tomous on 2020/11/20.
//

#import "DCRefreshFooter.h"

@implementation DCRefreshFooter
- (void)prepare
{
    [super prepare];
    
    self.stateLabel.textColor = [UIColor redColor];
    
//    [self addSubview:[UIButton buttonWithType:UIButtonTypeContactAdd]];
    
    // 刷新控件出现一半就会进入刷新状态
    //    self.triggerAutomaticallyRefreshPercent = 0.5;
    
    // 不要自动刷新
    //    self.automaticallyRefresh = NO;
}

@end
