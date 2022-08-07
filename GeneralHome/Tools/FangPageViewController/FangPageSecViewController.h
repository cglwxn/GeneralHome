//
//  FangPageSecViewController.h
//  SouFun
//
//  Created by iPan on 2020/6/11.
//  Copyright © 2020 房天下 Fang.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FangPageSecViewControllerDelegate <NSObject>

@optional
/** 当前索引回调 */
- (void)didFinishTransitionAtIndex:(NSInteger)index;

/** 监听pageViewController滚动*/
- (void)pageViewControllerDidScroll:(UIScrollView *)scrollView;

@end

@interface FangPageSecViewController : UIViewController

/** 控制器集合 */
@property (nonatomic, strong) NSArray<UIViewController *> *viewControllers;

/** FangPageViewControllerDelegate */
@property (nonatomic, weak) id<FangPageSecViewControllerDelegate> pageDelegate;

/** 开始索引 */
@property (nonatomic, assign) NSInteger currentIndex;

/** controller切换是否带动画, 默认有动画 */
@property (nonatomic, assign) BOOL animated;

@property (nonatomic, assign) BOOL canScroll;

/** 初始化 */
- (instancetype)initWithViewControllers:(NSArray<UIViewController *> *)viewControllers;

/** 初始化带delegate */
- (instancetype)initWithViewControllers:(NSArray<UIViewController *> *)viewControllers
                               delegate:(id<FangPageSecViewControllerDelegate>)delegate;

/** 选中某一个控制器 */
- (void)didSelectViewControllerAtIndex:(NSInteger)index;

@end
NS_ASSUME_NONNULL_END
