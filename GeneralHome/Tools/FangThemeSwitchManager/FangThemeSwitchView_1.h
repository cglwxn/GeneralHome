//
//  FangThemeSwitchView_1.h
//  SouFun
//
//  Created by Guanglei Cheng on 2019/7/18.
//  Copyright © 2019 房天下 Fang.com. All rights reserved.
//  实现类似如淘宝店铺首页,今日头条顶部,b站顶部主题切换的控件,实现标题(字体,颜色),滑动条(颜色,大小)的自定义,以及关联UIPageViewController/UIScrollView滑动交互.

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**点击某index回调,内部使用 */
typedef void(^SelectThemeInternalHandler)(NSInteger index, UIButton *button, BOOL animationTransition);

/**点击某index回调,clent使用 */
typedef void(^SelectThemeExternalHandler)(NSInteger index);

@interface FangThemeSwitchView_1 : UIView


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
/** 本控件是否在父视图中居中. */
@property (nonatomic, assign) BOOL locateInCenter;



/****************************** 角标 ************************************/

/** 角标显示的数字,默认为0,不显示,只有大于0时才会予以显示.和titles元素一一对应,若没有一一对应,后面缺少的默认为0,不显示. */
@property (nonatomic, strong) NSMutableArray <NSNumber *>*badgeNums;




/****************************** 滚动条 ************************************/

/** 是否隐藏滚动条,默认NO. */
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




/******************************** 选中 ************************************/

/** 选中某标题回调.内部使用,比如封装时. */
@property (nonatomic, strong) SelectThemeInternalHandler selectThemeInternalHandler;

/** 选中某标题回调.clent使用 */
@property (nonatomic, strong) SelectThemeExternalHandler selectThemeExternalHandler;

/** 当前选中的标题的索引,默认选中0. */
@property (nonatomic, assign) NSInteger currentIndex;




/******************************** 关联scroll view ************************************/

/*需要以下两步
 1.调用scrollWithOffset:outRangeX:,将scroll view的contentOffset.x和UIViewController的view.width传入.以实现本控件跟随scroll view/UIPageViewController滑动而动态变化.
 2.调用didFinishTurningPageCurrentIndex:previousIndex:方法,将scroll view/UIPageViewController切换完的index和切换前的index传入.实现字体的变化.
 
 */
/*  类似今日头条,知乎等app,下面页面滑动时,顶部的主题控件会变换选中标题,并跟随移动.
    若想实现类似的效果,在scroll view滑动时,向本控件发送本方法.
 
    例:
 
    @interface customerViewController ()<UIScrollViewDelegate>
    @property (nonatomic, strong) FangThemeSwitchView *themeSwitchView;
    @end
 
    @implementation customerViewController
 
    ...
    //需要关联的scroll view的滚动代理方法
    - (void)scrollViewDidScroll:(UIScrollView *)scrollView {
        //前面逻辑
        ...
 
 
        [self.themeSwitchView translateSlideWithOffset:scrollView.contentOffset.x outRangeX:SCREEN_WIDTH];
 
 
        //后续逻辑
        ...
    }
 
 
    注意:
    UIPageViewController的scroll view系统经过处理,其contentOffset不可用,需要在UIPageViewController的scroll view的代理方法中手动构建真实的偏移量,比如以下面方式:
    
    ...
     
    //UIPageViewController的scroll view的滚动代理方法
     - (void)scrollViewDidScroll:(UIScrollView *)scrollView {

         //构建真实的contentOffset
         CGPoint originContentOffset = CGPointZero;
         UIView *view = ((UIViewController *)(_viewControllsers[_currentIndex])).view;
         originContentOffset = [view convertPoint:view.frame.origin toView:[UIApplication sharedApplication].keyWindow];
         CGFloat x = originContentOffset.x-_currentIndex*SCREEN_WIDTH;
         CGPoint contentOffset = CGPointMake(-x, 0);
         
         //使用真实的contentOffset作为参数
         [self.themeSwitchView translateSlideWithOffset:contentOffset.x outRangeX:SCREEN_WIDTH];
     }
 
    ...
 
 
    @param offset 本控件每个按钮对应的scroll view的contentOffset.x.
    @param outRangeX 本控件每个按钮对应的scroll view中单个页面的宽度.
 
 */
- (void)scrollWithOffset:(CGFloat)offset outRangeX:(CGFloat)outRangeX;

//实现page切换完成后,字体的变化
/**
 类似今日头条,知乎等app,下面页面滑动时,顶部的主题控件会变换选中标题,并跟随移动.
 若想实现类似的效果,在scroll view结束滑动时(通常是UIPageViewController在page切换完成后),向本控件发送本方法.
 
 通常是在UIPageViewController的pageViewController: didFinishAnimating:previousViewControllers transitionCompleted:
 或者在table View/collection View的collectionView:willDisplayCell:forItemAtIndexPath:中调用

 @param currentIndex 切换完成后的index
 @param previousIndex 切换前的index
 */
- (void)didFinishTurningPageCurrentIndex:(NSInteger)currentIndex previousIndex:(NSInteger)previousIndex;


/*
 切换成功与否
 @param finished 是否切换成功.
 */
- (void)didFinishScrollToPage:(BOOL)finished;

@end

NS_ASSUME_NONNULL_END
