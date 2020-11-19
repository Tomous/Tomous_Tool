/*
 *  打印
 */
#ifdef DEBUG
#define DCLog(...) NSLog(__VA_ARGS__)
#else
#define DCLog(...)
#endif

/*
 *  <#Description#>
 */
#define DCLogFunc DCLog(@"%s",__func__);
#define IMAGENAME(a) [UIImage imageNamed:a]
#define FONT(a) [UIFont systemFontOfSize:a]

#define DEFAULT [NSUserDefaults standardUserDefaults]
#define NOTIFICATION [NSNotificationCenter defaultCenter]


// ios7
#define iOS7 ([UIDevice currentDevice].systemVersion.doubleValue >= 7.0)


/*
 *  处理颜色
 */
#define DCColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define DCAlphaColor(r,g,b,alpha) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:alpha]
/** rgb颜色转换（16进制->10进制）*/
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
//随机色
#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]
#define RandomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
#define DCColorR(r) DCColor(r,r,r)

#define Btn_color DCColor(74, 76, 90)
#define DCGrayColor(v) DCColor((v), (v), (v))
#define DCCommonBgColor DCGrayColor(206)

/*
 *  处理屏幕
 */
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
//宽高比例
#define WIDTHSCALE6 ScreenWidth/375.0f
#define HEIGHTSCALE6 ScreenHeight/667.0f
//判断是否是iPhone
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//判断是否是iPad
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define SCREEN_MAX_LENGTH (MAX(ScreenWidth, ScreenHeight))
#define SCREEN_MIN_LENGTH (MIN(ScreenWidth, ScreenHeight))
#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5_5S (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6_7_8 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P_7P_8P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
#define ISiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define ISiPhoneXR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)
#define ISiPhoneXS ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define ISiPhoneXS_MAX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)
//异性全面屏
#define   isFullScreen    (ISiPhoneX || ISiPhoneXR || ISiPhoneXS || ISiPhoneXS_MAX)
#define navHeight (isFullScreen?88.0f:64.0f)//导航栏高度
#define statusHeight (isFullScreen?44.0f:20.0f)//电池条高度
#define tabbarHeight (isFullScreen?83.0f:49.0f)//tabBar高度
// 去除上下导航栏剩余中间视图高度
#define viewHeight   (ScreenHeight - navHeight - tabbarHeight)
#define bottomSafeHeight (isFullScreen?34.0f:0.0f)

/*
 *  app版本号
 */
#define DEVICE_APP_VERSION      (NSString *)[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]


/*
 *  判断字符串是否为空
 */
#define Str_IsEmpty(str)    (((str) == nil) || ([(str) isEqual:[NSNull null]]) || ([@"" isEqualToString:(str)]))


