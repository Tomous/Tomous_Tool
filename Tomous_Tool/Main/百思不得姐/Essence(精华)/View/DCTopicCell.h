//
//  DCTopicCell.h
//  Tomous_Tool
//
//  Created by Tomous on 2020/11/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class DCTopic;
@protocol topicCellDelegate <NSObject>
-(void)selectedWithBtn:(NSInteger)tag model:(DCTopic *)topic;
@end

@interface DCTopicCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView forRowAtIndexPath:(NSIndexPath *)indexPath;
/** 帖子模型数据 */
@property (nonatomic,strong) DCTopic *topic;

/**  点击cell下面的按钮 */
@property (nonatomic,weak) id<topicCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
