//
//  DCWebViewController.m
//  Tomous_Tool
//
//  Created by Tomous on 2020/11/20.
//
/**
 * 技术无价，在于奉献。
 * GitHub地址：https://github.com/Tomous/Tomous_Tool
 * 简书地址：https://www.jianshu.com/u/3600d7861beb
 * CSDN：https://mp.csdn.net/console/article
 * 群号（511860085）您的每一个star和关注都是激励我坚持下去的动力😄😄。
*/

#import "DCWebViewController.h"
#import <WebKit/WebKit.h>
@interface DCWebViewController ()<UIWebViewDelegate>
@property (strong, nonatomic) WKWebView *webView;
@property (strong, nonatomic) UIBarButtonItem *backItem;
@property (strong, nonatomic) UIBarButtonItem *forwardItem;
@end

@implementation DCWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, navHeight, ScreenWidth, viewHeight)];
    self.webView.backgroundColor = RandomColor;
    [self.view addSubview:self.webView];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    
//    self.backItem = [UIBarButtonItem creatBarButtonItemWithNorImageName:<#(NSString *)#> higImageName:<#(NSString *)#> target:<#(id)#> active:<#(SEL)#>]
}
- (void)back {
    [self.webView goBack];
}
- (void)forward {
    [self.webView goForward];
}
- (void)reload {
    [self.webView reload];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    self.backItem.enabled = webView.canGoBack;
    self.forwardItem.enabled = webView.canGoForward;
}

@end
