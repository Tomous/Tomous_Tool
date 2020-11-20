//
//  DCTitleButton.m
//  Tomous_Tool
//
//  Created by Tomous on 2020/11/20.
//

#import "DCTitleButton.h"

@implementation DCTitleButton
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 设置按钮颜色
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        self.titleLabel.font = FONT(14);
    }
    return self;
}

-(void)setHighlighted:(BOOL)highlighted{}

@end
