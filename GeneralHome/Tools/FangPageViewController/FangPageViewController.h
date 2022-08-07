//
//  FangPageViewController.h
//  搜房帮
//
//  Created by 邱育良 on 16/6/13.
//  Copyright © 2016年 www.fang.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FangPageViewControllerDelegate <NSObject>

@optional
/** 当前索引回调 */
- (void)didFinishTransitionAtIndex:(NSInteger)index;

/** 监听pageViewController滚动*/
- (void)pageViewControllerDidScroll:(UIScrollView *)scrollView;

@end

@interface FangPageViewController : UIViewController

/** 控制器集合 */
@property (nonatomic, strong) NSArray<UIViewController *> *viewControllers;

/** FangPageViewControllerDelegate */
@property (nonatomic, weak) id<FangPageViewControllerDelegate> pageDelegate;

/** 开始索引 */
@property (nonatomic, assign) NSInteger currentIndex;

/** controller切换是否带动画, 默认有动画 */
@property (nonatomic, assign) BOOL animated;

@property (nonatomic, assign) BOOL canScroll;

/** 初始化 */
- (instancetype)initWithViewControllers:(NSArray<UIViewController *> *)viewControllers;

/** 初始化带delegate */
- (instancetype)initWithViewControllers:(NSArray<UIViewController *> *)viewControllers
                               delegate:(id<FangPageViewControllerDelegate>)delegate;

/** 选中某一个控制器 */
- (void)didSelectViewControllerAtIndex:(NSInteger)index;

@end
