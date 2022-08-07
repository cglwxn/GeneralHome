//
//  FangThemeSwitchManager.h
//  SouFun
//
//  Created by Guanglei Cheng on 2020/4/23.
//  Copyright © 2020 房天下 Fang.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FangThemeSwitchView_1.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^HandlerBlock)(UIPageViewController * _Nullable pageVC, NSInteger index, UIViewController *currentViewController, NSInteger previoutIndex);
typedef void(^FangProductStorePersonalScrollHandler)(CGPoint contentOffset);

@interface FangThemeSwitchManager : NSObject

@property (nonatomic, readonly) UIPageViewController *pageVC;
@property (nonatomic, readonly) FangThemeSwitchView_1 *themeSwitch;

- (void)congfigueWithChildViewControllers:(NSArray<UIViewController *> *)viewControllers willTransitionHandler:(HandlerBlock)willTransitionHandler didTransitionHandler:(HandlerBlock)didTransitionHandler;

@property (nonatomic, strong) FangProductStorePersonalScrollHandler scrollHandler;


//设置下列属性,会被同步到FangThemeSwitchView的同名属性.等同于直接用themeSwitch设置相关属性
/****************************** 标题 ************************************/

/** 标题数组,每个成员为标题字符串 */
@property (nonatomic, strong) NSArray <NSString *>*titles;
/** 未选中标题的颜色,默认0xA4A7A9. */
@property (nonatomic, strong) UIColor *titleColor;
/** 选中标题的颜色,默认0x0E131A. */
@property (nonatomic, strong) UIColor *selectedTitleColor;
/** 未选中标题字体大小,默认为[UIFont fontWithName:@"PingFangSC-Regular" size:17]. */
@property (nonatomic, strong) UIFont *titleFont;
/** 选中的标题字体大小,默认为[UIFont fontWithName:@"PingFangSC-Medium" size:18]. */
@property (nonatomic, strong) UIFont *selectedTitleFont;
/** 第一个标题左边距距离本控件左边距. */
@property (nonatomic, assign) CGFloat leadSpacing;
/** 最后标题右边距距离本控件右边距. */
@property (nonatomic, assign) CGFloat trailSpacing;
/** 标题与标题间距. */
@property (nonatomic, assign) CGFloat fixedSpacing;
/** 每个标题距本控件顶部间距. */
@property (nonatomic, assign) CGFloat topSpacing;
/** 每个标题距本控件底部部间距. */
@property (nonatomic, assign) CGFloat bottomSpacing;




/****************************** 角标 ************************************/

/** 角标显示的数字,默认为0,不显示,只有大于0时才会予以显示.和titles元素一一对应,若没有一一对应,后面缺少的默认为0,不显示. */
@property (nonatomic, strong) NSMutableArray <NSNumber *>*badgeNums;




/****************************** 滚动条 ************************************/

/** 是否有滚动条,默认YES. */
@property (nonatomic, assign) BOOL hideSlider;
/** 滑动条颜色,默认0x3295F6. */
@property (nonatomic, strong) UIColor *sliderColor;
/** 滑动条size,默认CGSizeMake(21, 4). */
@property (nonatomic, assign) CGSize sliderSize;

//下面两个属性正在完善中,暂且不可用.
/** 是否动态变化标题长度. 此时,高度默认4,修改高度设置可以用sliderSize来设置. */
@property (nonatomic, assign) BOOL dynamicSliderEnable;
/** 标题宽度与滑动条宽度的差/2
        --------------
           ----|-间距-|
 */
@property (nonatomic, assign) BOOL dynamicSliderSpacing;


/******************************** 交互 ************************************/
/**  是否支持滑动切换.默认YES */
@property (nonatomic, assign) BOOL pageScrollEnable;

/******************************** 选中标题 ************************************/

/** 选中某标题回调. */
@property (nonatomic, strong) SelectThemeExternalHandler selectThemeExternalHandler;
/** 当前选中的标题的索引,默认选中0. */
@property (nonatomic, assign) NSInteger currentIndex;


@end

NS_ASSUME_NONNULL_END
