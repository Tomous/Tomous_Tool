//
//  DCEssenceViewController.m
//  Tomous_Tool
//
//  Created by Tomous on 2020/11/19.
//
/**
 * 技术无价，在于奉献。
 * GitHub地址：https://github.com/Tomous/Tomous_Tool
 * 简书地址：https://www.jianshu.com/u/3600d7861beb
 * CSDN：https://mp.csdn.net/console/article
 * 群号（511860085）您的每一个star和关注都是激励我坚持下去的动力😄😄。
*/

#import "DCEssenceViewController.h"
#import "DCAllViewController.h"
#import "DCVideoViewController.h"
#import "DCVoiceViewController.h"
#import "DCPictureViewController.h"
#import "DCWordViewController.h"
#import "DCTitleButton.h"

@interface DCEssenceViewController ()<UIScrollViewDelegate>
/** UIScrollView */
@property (nonatomic,weak) UIScrollView *scrollView;
/** 标题栏 */
@property (nonatomic, weak) UIView *titlesView;
/** 标题按钮底部的指示器 */
@property (nonatomic, weak) UIView *indicatorView;
/** 当前选中的标题按钮 */
@property (nonatomic, weak) DCTitleButton *selectedTitleButton;

@end

@implementation DCEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置导航栏
    [self setUpNav];
    //设置子控制器
    [self setUpChildViewControllers];
    //设置滚动容器
    [self setUpScrollView];
    //设置顶部的title
    [self setupTitlesView];
    
    // 默认添加子控制器的view
    [self addChildVcView];
}

-(void)setUpNav {
    self.view.backgroundColor = DCCommonBgColor;
    // 标题
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    // 左边
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(leftBtnDidClick)];
}
-(void)leftBtnDidClick
{
    DCLogFunc;
    UIViewController *vc = [[UIViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
//设置子控制器
-(void)setUpChildViewControllers {
    
    DCAllViewController *all = [[DCAllViewController alloc]init];
    [self addChildViewController:all];
    
    DCVideoViewController *video = [[DCVideoViewController alloc]init];
    [self addChildViewController:video];
    
    DCVoiceViewController *voice = [[DCVoiceViewController alloc]init];
    [self addChildViewController:voice];
    
    DCPictureViewController *picture = [[DCPictureViewController alloc]init];
    [self addChildViewController:picture];
    
    DCWordViewController *word = [[DCWordViewController alloc]init];
    [self addChildViewController:word];
}
-(void)setUpScrollView {

    // 不允许自动调整scrollView的内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = DCCommonBgColor;
    scrollView.frame = self.view.bounds;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.delegate = self;
    // 添加所有子控制器的view到scrollView中
    scrollView.contentSize = CGSizeMake(self.childViewControllers.count * scrollView.width, 0);
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
}

- (void)setupTitlesView {
    UIView *titlesView = [[UIView alloc]initWithFrame:CGRectMake(0, navHeight, self.view.width, 35)];
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    // 添加标题
    NSArray *titles = @[@"全部", @"视频", @"声音", @"图片", @"段子"];
    NSUInteger count = titles.count;
    CGFloat titleButtonW = titlesView.width / count;
    CGFloat titleButtonH = titlesView.height;
    for (int i = 0; i < count; i ++) {
        // 创建
        DCTitleButton *titleButton = [DCTitleButton buttonWithType:UIButtonTypeCustom];
        titleButton.tag = i;
        [titleButton addTarget:self action:@selector(titleDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:titleButton];
        
        // 设置数据
        [titleButton setTitle:titles[i] forState:UIControlStateNormal];
        
        // 设置frame
        titleButton.frame = CGRectMake(i*titleButtonW, 0, titleButtonW, titleButtonH);
    }
    // 按钮的选中颜色
    DCTitleButton *firstTitleButton = titlesView.subviews.firstObject;
    
    // 底部的指示器
    UIView *indicatorView = [[UIView alloc]init];
    indicatorView.backgroundColor = [firstTitleButton titleColorForState:UIControlStateSelected];
    indicatorView.height = 1;
    indicatorView.y = titlesView.height - indicatorView.height;
    [titlesView addSubview:indicatorView];
    self.indicatorView = indicatorView;
    
    // 立刻根据文字内容计算label的宽度
    [firstTitleButton.titleLabel sizeToFit];
    indicatorView.width = firstTitleButton.titleLabel.width;
    indicatorView.centerX = firstTitleButton.centerX;
    // 默认情况 : 选中最前面的标题按钮
    firstTitleButton.selected = YES;
    self.selectedTitleButton = firstTitleButton;
}
#pragma mark - 监听点击
-(void)titleDidClick:(DCTitleButton *)titleButton {
    // 控制按钮状态
    self.selectedTitleButton.selected = NO;
    titleButton.selected = YES;
    self.selectedTitleButton = titleButton;
    
    // 指示器
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = titleButton.titleLabel.width;
        self.indicatorView.centerX = titleButton.centerX;
    }];
    
    // 让UIScrollView滚动到对应位置
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = titleButton.tag * self.scrollView.width;
    [self.scrollView setContentOffset:offset animated:YES];
}
#pragma mark - 添加子控制器的view
-(void)addChildVcView {

    // 子控制器的索引
    NSUInteger index = self.scrollView.contentOffset.x / self.scrollView.width;
    
    // 取出子控制器
    UIViewController *childVc = self.childViewControllers[index];
    if ([childVc isViewLoaded]) return;
    
    childVc.view.frame = self.scrollView.bounds;
    [self.scrollView addSubview:childVc.view];
}

#pragma mark - <UIScrollViewDelegate>
/**
 * 在scrollView滚动动画结束时, 就会调用这个方法
 * 前提: 使用setContentOffset:animated:或者scrollRectVisible:animated:方法让scrollView产生滚动动画
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self addChildVcView];
}
/**
 * 在scrollView滚动动画结束时, 就会调用这个方法
 * 前提: 人为拖拽scrollView产生的滚动动画
 */
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 选中点击对应的按钮
    NSUInteger index = scrollView.contentOffset.x / scrollView.width;
    DCTitleButton *titleButton = self.titlesView.subviews[index];
    [self titleDidClick:titleButton];
    // 添加子控制器的view
    [self addChildVcView];
}

@end
