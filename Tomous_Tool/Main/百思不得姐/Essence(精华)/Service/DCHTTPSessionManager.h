//
//  DCHTTPSessionManager.h
//  Tomous_Tool
//
//  Created by Tomous on 2020/11/20.
//

#import "AFHTTPSessionManager.h"
/**
 * 最好是自己创建一个类继承AFHTTPSessionManager，这样就能在这个类里面根据项目需要做各种处理
 */
NS_ASSUME_NONNULL_BEGIN

@interface DCHTTPSessionManager : AFHTTPSessionManager

@end

NS_ASSUME_NONNULL_END
