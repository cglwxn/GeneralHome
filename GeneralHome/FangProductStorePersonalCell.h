//
//  FangProductStorePersonalCell.h
//  SouFun
//
//  Created by Guanglei Cheng on 2020/4/9.
//  Copyright © 2020 房天下 Fang.com. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^HandlerBlock)(UIPageViewController * _Nullable pageVC, NSInteger index, UIViewController *currentViewController, NSInteger previoutIndex);
typedef void(^FangProductStorePersonalScrollHandler)(CGPoint contentOffset);


NS_ASSUME_NONNULL_BEGIN

@interface FangProductStorePersonalCell : UITableViewCell

- (void)congfigueCellWithModel:(id)model WillBlock:(HandlerBlock)willHandlerBlock didBlock:(HandlerBlock)didHandlerBlock withVC:(UIViewController *)vc;
- (void)pageScrollToIndex:(NSInteger)index animated:(BOOL)animated finishedHandler:(void(^)(BOOL finished)) finishedHandler;
@property (nonatomic, strong) FangProductStorePersonalScrollHandler scrollHandler;

@end

NS_ASSUME_NONNULL_END
