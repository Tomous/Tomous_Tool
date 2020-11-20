//
//  DCTopicPictureView.h
//  Tomous_Tool
//
//  Created by Tomous on 2020/11/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class DCTopic;
@interface DCTopicPictureView : UIView
/** 模型数据 */
@property (nonatomic,strong) DCTopic *topic;
@end

NS_ASSUME_NONNULL_END
