//
//  DCComment.h
//  Tomous_Tool
//
//  Created by Tomous on 2020/11/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class DCUser;
@interface DCComment : NSObject
/** 内容 */
@property (nonatomic, copy) NSString *content;
/** 用户(发表评论的人) */
@property (nonatomic, strong) DCUser *user;

@end

NS_ASSUME_NONNULL_END
