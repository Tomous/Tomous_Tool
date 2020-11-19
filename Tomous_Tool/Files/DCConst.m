#import <UIKit/UIKit.h>

/** 通用的按钮高度值 */
CGFloat const DCBtnHeight = 32;

/** 通用Title字体大小 */
CGFloat const DCTitleFont = 15;

/** 通用subTitle字体大小 */
CGFloat const DCSubTitleFont = DCTitleFont - 2;

/** 通用titleView的高度 */
CGFloat const DCTitleViewHeight = 44;

/**  检测登录状态 */
NSString * const DCLogin_stateChange = @"DCLogin_stateChange";

/**  从退出登录之后，登录成功返回刷新页面（重新请求数据） */
NSString * const DCRefreshPageWhenLoginAgain = @"DCRefreshPageWhenLoginAgain";

/**  切换用户让h5重新赋值数据 */
NSString * const SetUserInfoSync = @"SetUserInfoSync";

/**  记录用户名 */
NSString * const Login_userName = @"Login_userName";
NSString * const Login_phone = @"13912345670";


/**  App Store ID */
NSString * const AppStore_ID = @"1473889515";

/**  Bugly ID */
NSString * const Bugly_ID = @"d4d8c8c7be";
