//
//  FangThemeSwitchManager.m
//  SouFun
//
//  Created by Guanglei Cheng on 2020/4/23.
//  Copyright © 2020 房天下 Fang.com. All rights reserved.
//

#import "FangThemeSwitchManager.h"



@interface FangThemeSwitchManager ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource, UIGestureRecognizerDelegate, UIScrollViewDelegate>

@property (nonatomic) UIPageViewController *pageVC;
@property (nonatomic) FangThemeSwitchView_1 *themeSwitch;

@property (nonatomic, strong) NSMutableArray *viewControllsers;

@property (nonatomic, assign) NSInteger previousIndex;

@property (nonatomic, strong) HandlerBlock willTransitionHandler;
@property (nonatomic, strong) HandlerBlock didTransitionHandler;

@property (nonatomic, strong) SelectThemeInternalHandler selectThemeInternalHandler;

@end

@implementation FangThemeSwitchManager

- (instancetype)init {
    self = [super init];
    if (self) {
        WS(ws)
        _themeSwitch = [[FangThemeSwitchView_1 alloc] initWithFrame:CGRectZero];
        _themeSwitch.selectThemeInternalHandler = ^(NSInteger index, UIButton * _Nonnull button, BOOL animationTransition) {
            __strong typeof(ws) ss = ws;
            [ss pageScrollToIndex:index animated:animationTransition];
        };
        
        _pageVC = [[UIPageViewController alloc] initWithTransitionStyle:(UIPageViewControllerTransitionStyleScroll) navigationOrientation:(UIPageViewControllerNavigationOrientationHorizontal) options:nil];
        for (UIView *view in _pageVC.view.subviews) {
            if ([view isKindOfClass:[UIScrollView class]]) {
                UIScrollView *scrollView = (UIScrollView *)view;
                scrollView.delegate = self;
            }
        }
        _pageVC.delegate = self;
        _pageVC.dataSource = self;
        _currentIndex = 0;
        _pageScrollEnable = YES;
    }
    return self;
}

- (void)congfigueWithChildViewControllers:(NSArray<UIViewController *> *)viewControllers willTransitionHandler:(HandlerBlock)willTransitionHandler didTransitionHandler:(HandlerBlock)didTransitionHandler {
    self.viewControllsers = [NSMutableArray arrayWithArray:viewControllers];
    [_pageVC setViewControllers:@[viewControllers[0]] direction:(UIPageViewControllerNavigationDirectionReverse) animated:YES completion:^(BOOL finished) {
        
    }];
    self.willTransitionHandler = willTransitionHandler;
    self.didTransitionHandler = didTransitionHandler;
}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers API_AVAILABLE(ios(6.0)) {
//    FangProductStorePersonalCombinationVC *vc = (FangProductStorePersonalCombinationVC *)(pendingViewControllers.firstObject);
//    NSInteger idx = [self.viewControllsers indexOfObject:vc];
//    self.willTransitionHandler(self.pageVC, idx, vc);
//    NSLog(@"%s---%d",__func__,idx);
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    if (completed) {
        _currentIndex = [self.viewControllsers indexOfObject:_pageVC.viewControllers.lastObject];
        UIViewController *previousViewController = previousViewControllers.firstObject;
        NSInteger previoutIndex = [self.viewControllsers indexOfObject:previousViewController];
        UIViewController *currVc = (_viewControllsers[_currentIndex]);
        [self.themeSwitch didFinishTurningPageCurrentIndex:_currentIndex previousIndex:previoutIndex];
        self.didTransitionHandler(self.pageVC, _currentIndex, currVc, previoutIndex);
//        NSLog(@"\n\ncomplete\ncurrentIdx:%ld\npreIdx%ld\n\n ",_currentIndex,previoutIndex);
    }else{
        _currentIndex = [self.viewControllsers indexOfObject:_pageVC.viewControllers.lastObject];
        UIViewController *previousViewController = previousViewControllers.firstObject;
        NSInteger previoutIndex = [self.viewControllsers indexOfObject:previousViewController];
        UIViewController *currVc = (_viewControllsers[_currentIndex]);
        [self.themeSwitch didFinishTurningPageCurrentIndex:_currentIndex previousIndex:previoutIndex];
        self.didTransitionHandler(self.pageVC, _currentIndex, currVc, previoutIndex);
//        NSLog(@"\n\nuncomplete\ncurrentIdx:%ld\npreIdx%ld\n\n ",_currentIndex,previoutIndex);
    }
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [self.viewControllsers indexOfObject:viewController];
//    NSLog(@"\n\nBefore--之前的index:%ld\ncurrentIdx:%ld\n\n",index,self.currentIndex);
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
//    NSLog(@"\n\nBefore--之后的index:%ld\ncurrentIdx:%ld\n\n",index,self.currentIndex);
//    NSLog(@"%s----_%d",__func__,index);
    return self.viewControllsers[index];
}
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger index = [self.viewControllsers indexOfObject:viewController];
//    NSLog(@"\n\nAfter--之前的index:%ld\ncurrentIdx:%ld\n\n",index,self.currentIndex);

    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
//    NSLog(@"\n\nAfter--之后的index:%ld\ncurrentIdx:%ld\n\n",index,self.currentIndex);

//    NSLog(@"%s++++++++++_%d",__func__,index);
    if (index == [self.viewControllsers count]) {
        return nil;
    }
    return self.viewControllsers[index];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGPoint originContentOffset = CGPointZero;
    UIView *view = ((UIViewController *)(_viewControllsers[_currentIndex])).view;
    originContentOffset = [view convertPoint:view.frame.origin toView:[UIApplication sharedApplication].keyWindow];
    CGFloat x = originContentOffset.x-_currentIndex*SCREEN_WIDTH;
    [self.themeSwitch scrollWithOffset:-x outRangeX:SCREEN_WIDTH];
}

- (void)pageScrollToIndex:(NSInteger)index animated:(BOOL)animated {
    WS(ws)
//    NSLog(@"%s",__func__);
    self.previousIndex = _currentIndex;
    self.currentIndex = index;
    if (index > self.previousIndex) {
        [self.pageVC setViewControllers:@[self.viewControllsers[index]] direction:UIPageViewControllerNavigationDirectionForward animated:animated completion:^(BOOL finished) {
            __strong typeof(ws) ss = ws;
            if (finished) {
            }else{
                ss.currentIndex = ss.previousIndex;
            }
            [ss pageViewController:ss.pageVC didFinishAnimating:animated previousViewControllers:@[ss.viewControllsers[ss.currentIndex]] transitionCompleted:YES];
//            NSLog(@"\nfinish:%ld-index:%ld\n",finished,ss.currentIndex);
//            finishedHandler(finished);
            [ss.themeSwitch didFinishScrollToPage:finished];
        }];
    } else if (index < self.previousIndex) {
        __strong typeof(ws) ss = ws;
        [self.pageVC setViewControllers:@[self.viewControllsers[index]] direction:UIPageViewControllerNavigationDirectionReverse animated:animated completion:^(BOOL finished) {
            if (finished) {
            }else{
                ss.currentIndex = ss.previousIndex;
            }
            [ss pageViewController:ss.pageVC didFinishAnimating:animated previousViewControllers:@[ss.viewControllsers[ss.currentIndex]] transitionCompleted:YES];
//            NSLog(@"\nfinish:%ld-index:%ld\n",finished,ss.currentIndex);
//            finishedHandler(finished);
            [ss.themeSwitch didFinishScrollToPage:finished];
        }];
    } else {
        [self pageViewController:self.pageVC didFinishAnimating:animated previousViewControllers:@[self.viewControllsers[self.currentIndex]] transitionCompleted:YES];
        self.currentIndex = index;
    }
}

#pragma mark - accessors

- (void)setTitles:(NSArray<NSString *> *)titles {
    _titles = titles;
    self.themeSwitch.titles = _titles;
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    self.themeSwitch.titleColor = titleColor;
}

- (void)setSelectedTitleColor:(UIColor *)selectedTitleColor {
    _selectedTitleColor = selectedTitleColor;
    self.themeSwitch.selectedTitleColor = selectedTitleColor;
}

- (void)setTitleFont:(UIFont *)titleFont {
    _titleFont = titleFont;
    self.themeSwitch.titleFont = titleFont;
}

- (void)setSelectedTitleFont:(UIFont *)selectedTitleFont {
    _selectedTitleFont = selectedTitleFont;
    self.themeSwitch.selectedTitleFont = selectedTitleFont;
}

- (void)setLeadSpacing:(CGFloat)leadSpacing {
    _leadSpacing = leadSpacing;
    self.themeSwitch.leadSpacing = leadSpacing;
}

- (void)setFixedSpacing:(CGFloat)fixedSpacing {
    _fixedSpacing = fixedSpacing;
    self.themeSwitch.fixedSpacing = fixedSpacing;
}

- (void)setTrailSpacing:(CGFloat)trailSpacing {
    _trailSpacing = trailSpacing;
    self.themeSwitch.trailSpacing = trailSpacing;
}

- (void)setTopSpacing:(CGFloat)topSpacing {
    _topSpacing = topSpacing;
    self.themeSwitch.topSpacing = topSpacing;
}

- (void)setBottomSpacing:(CGFloat)bottomSpacing {
    _bottomSpacing = bottomSpacing;
    self.themeSwitch.bottomSpacing = bottomSpacing;
}

- (void)setBadgeNums:(NSMutableArray<NSNumber *> *)badgeNums {
    _badgeNums = badgeNums;
    self.themeSwitch.badgeNums = badgeNums;
}

- (void)setHideSlider:(BOOL)hideSlider {
    _hideSlider = hideSlider;
    self.themeSwitch.hideSlider = hideSlider;
}

- (void)setSliderSize:(CGSize)sliderSize {
    _sliderSize = sliderSize;
    self.themeSwitch.sliderSize = sliderSize;
}

- (void)setDynamicSliderEnable:(BOOL)dynamicSliderEnable {
    _dynamicSliderEnable = dynamicSliderEnable;
    self.themeSwitch.dynamicSliderEnable = dynamicSliderEnable;
}

- (void)setDynamicSliderSpacing:(BOOL)dynamicSliderSpacing {
    _dynamicSliderSpacing = dynamicSliderSpacing;
    self.themeSwitch.dynamicSliderSpacing = dynamicSliderSpacing;
}

- (void)setSelectThemeInternalHandler:(SelectThemeInternalHandler)selectThemeInternalHandler {
    _selectThemeInternalHandler = selectThemeInternalHandler;
    self.themeSwitch.selectThemeInternalHandler = selectThemeInternalHandler;
}

- (void)setSelectThemeExternalHandler:(SelectThemeExternalHandler)selectThemeExternalHandler {
    _selectThemeExternalHandler = selectThemeExternalHandler;
    self.themeSwitch.selectThemeExternalHandler = selectThemeExternalHandler;
}

- (void)setCurrentIndex:(NSInteger)currentIndex {
    _currentIndex = currentIndex;
    self.themeSwitch.currentIndex = currentIndex;
}

- (void)setPageScrollEnable:(BOOL)pageScrollEnable {
    _pageScrollEnable = pageScrollEnable;
    for (UIView *view in self.pageVC.view.subviews) {
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scollView = (UIScrollView *)view;
            scollView.scrollEnabled = self.pageScrollEnable;
            break;
        }
    }
}

@end
