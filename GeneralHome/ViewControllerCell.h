//
//  ViewControllerCell.h
//  GeneralHome
//
//  Created by Guanglei Cheng on 2022/8/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ItemTapBlock) (NSInteger);


@interface ViewControllerCell : UITableViewCell

@property (nonatomic, copy) ItemTapBlock itemTapBlock;

@end

NS_ASSUME_NONNULL_END
