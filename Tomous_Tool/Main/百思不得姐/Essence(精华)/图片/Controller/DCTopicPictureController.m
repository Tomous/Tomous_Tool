//
//  DCTopicPictureController.m
//  百思不得姐
//
//  Created by 大橙子 on 2019/5/9.
//  Copyright © 2019 Tomous. All rights reserved.
//

#import "DCTopicPictureController.h"
#import "DCTopic.h"
#import "DCPhotoKit.h"
#import <SVProgressHUD.h>
@interface DCTopicPictureController ()<UIScrollViewDelegate>
@property (nonatomic,strong) UIButton *backBtn;
/** 图片控件 */
@property (nonatomic, weak) FLAnimatedImageView *imageView;
/**  保存图片控件 */
@property (strong, nonatomic) UIButton *saveButton;
@end
@implementation DCTopicPictureController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpUI];
}
-(void)setUpUI {
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backBtn.frame = CGRectMake(DCMargin, statusHeight+DCMargin, 35, 35);
    [self.backBtn setImage:IMAGENAME(@"show_image_back_icon") forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backBtn];
    
    self.saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.saveButton.size = CGSizeMake(55, 35);
    self.saveButton.right = self.view.right - DCMargin;
    self.saveButton.bottom = self.view.bottom - DCMargin;
    [self.saveButton setTitle:@"保存" forState:UIControlStateNormal];
    self.saveButton.backgroundColor = [UIColor lightGrayColor];
    [self.saveButton addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.saveButton];
    
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.frame = [UIScreen mainScreen].bounds;
    scrollView.delegate = self;
    [self.view insertSubview:scrollView atIndex:0];
    
    // imageView
    FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (image == nil) return; // 图片下载失败
        
        if ([self.topic.large_image.pathExtension.lowercaseString isEqualToString:@"gif"]) {
            [self DC_gifForUrl:self.topic.large_image];
        }
    }];
    [scrollView addSubview:imageView];
    imageView.width = scrollView.width;
    imageView.height = self.topic.d_height * imageView.width / self.topic.d_width;
    imageView.x = 0;
    if (imageView.height >= scrollView.height) {
        //图片高度超过整个屏幕
        imageView.y = 0;
        scrollView.contentSize = CGSizeMake(0, imageView.height);
    }else {// 居中显示
        imageView.centerY = scrollView.height*0.5;
    }
    self.imageView = imageView;
    
    // 缩放比例
    CGFloat scale =  self.topic.d_width / imageView.width;
    if (scale > 1.0) {
        scrollView.maximumZoomScale = scale;
    }
}
/**  gif图片处理 */
- (void)DC_gifForUrl:(NSString*)url {
    
    id obj = [[self getCache] objectForKey:url];
    if (obj != nil ) {
        self.imageView.animatedImage= [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
        DCLog(@"缓存中的 -- %@",url);
        return;
    }
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        FLAnimatedImage *flImage = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
        [[self
          getCache] setObject:flImage forKey:url];
        dispatch_async(dispatch_get_main_queue(), ^{
            //TGLog(@"下载的 -- %@",url);
            if (self.topic.large_image == url){
                self.imageView.animatedImage= flImage;
            }else{
                DCLog(@"# 错位了 不用设置gif（重用机制造成的，原理请参考SDWebImage）#");
            }
        });
    });
}
- (NSCache*)getCache{
    static NSCache * cache =nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cache = [[NSCache alloc]init];
        cache.countLimit = GIFCacheCountLimit;//关键
        DCLog(@"-- 自己的缓存策略 --");
    });
    return cache;
}
-(void)back {
    [self dismissViewControllerAnimated:NO completion:nil];
}
-(void)save {
    [DCPhotoKit savePhotosToAppPhotoCollection:self.imageView.image];
}

- (void)showSuccess:(NSString *)text
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD showSuccessWithStatus:text];
    });
}

- (void)showError:(NSString *)text
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD showErrorWithStatus:text];
    });
}

#pragma mark - <UIScrollViewDelegate>
/**
 *  返回一个scrollView的子控件进行缩放
 */
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}
@end
