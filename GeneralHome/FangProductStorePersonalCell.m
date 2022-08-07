//
//  FangProductStorePersonalCell.m
//  SouFun
//
//  Created by Guanglei Cheng on 2020/4/9.
//  Copyright © 2020 房天下 Fang.com. All rights reserved.
//

#import "FangProductStorePersonalCell.h"


@interface FangProductStorePersonalCell ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource, UIGestureRecognizerDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *viewControllsers;

@property (nonatomic, strong) UIPageViewController *pageVC;

@property (nonatomic, strong) HandlerBlock willHandlerBlock;
@property (nonatomic, strong) HandlerBlock didHandlerBlock;

@property (nonatomic, weak) UIViewController *vc;

@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, assign) NSInteger previousIndex;

@end

@implementation FangProductStorePersonalCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        _pageVC = [[UIPageViewController alloc] initWithTransitionStyle:(UIPageViewControllerTransitionStyleScroll) navigationOrientation:(UIPageViewControllerNavigationOrientationHorizontal) options:nil];
        _pageVC.view.backgroundColor = UIColorMake(0xF5F5F5);
        for (UIView *view in _pageVC.view.subviews) {
            if ([view isKindOfClass:[UIScrollView class]]) {
                UIScrollView *scrollView = (UIScrollView *)view;
                scrollView.delegate = self;
            }
        }
        _pageVC.delegate = self;
        _pageVC.dataSource = self;
        _currentIndex = 0;

        [self.contentView addSubview:_pageVC.view];
    }
    return self;
}

- (void)congfigueCellWithModel:(id)model WillBlock:(HandlerBlock)willHandlerBlock didBlock:(HandlerBlock)didHandlerBlock withVC:(UIViewController *)vc {
    
//        FangProductStorePersonalCombinationVC *vc0 = [[FangProductStorePersonalCombinationVC alloc] init];
//        FangProductStorePersonalSingleVC *vc1 = [[FangProductStorePersonalSingleVC alloc] init];
        
        
        UIViewController *vc0 = [[UIViewController alloc] init];
    vc0.view.backgroundColor = UIColor.brownColor;
        
        UIViewController *vc1 = [[UIViewController alloc] init];
    vc1.view.backgroundColor = UIColor.redColor;
        
        self.viewControllsers = @[vc0,vc1].mutableCopy;
        [_pageVC setViewControllers:@[vc0] direction:(UIPageViewControllerNavigationDirectionReverse) animated:YES completion:^(BOOL finished) {
            
        }];
            
    //        FangMicroShopVC *vc2 = [[FangMicroShopVC alloc]init];
    //
    //
    //        JJYDouFangListViewController *vc3 = [[JJYDouFangListViewController alloc] init];
    //
    //        FangHotLiveListController * vc4 = [[FangHotLiveListController alloc] init];
    //        vc4.city = userInfo.city;
    //
    //        JJYDongTaiListViewController * vc5 = [[JJYDongTaiListViewController alloc] init];
    //
    //        FangPeerMomentsController * vc6 = [[FangPeerMomentsController alloc] init];
    //        vc6.city = userInfo.fangCity;
    //
    //        FangProductStorePersonalSingleVC *vc7 = [[FangProductStorePersonalSingleVC alloc] init];
            
    //        _viewControllsers = @[vc0,vc1,vc2,vc3,vc4,vc5,vc6,vc7].mutableCopy;
    
    
    
    self.pageVC.view.frame = self.bounds;
    [vc addChildViewController:self.pageVC];
    
    [self.pageVC.view didMoveToSuperview];
    self.willHandlerBlock = willHandlerBlock;
    self.didHandlerBlock = didHandlerBlock;
}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers API_AVAILABLE(ios(6.0)) {
//    FangProductStorePersonalCombinationVC *vc = (FangProductStorePersonalCombinationVC *)(pendingViewControllers.firstObject);
//    NSInteger idx = [self.viewControllsers indexOfObject:vc];
//    self.willHandlerBlock(self.pageVC, idx, vc);
//    NSLog(@"%s---%d",__func__,idx);
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    if (completed) {
        _currentIndex = [self.viewControllsers indexOfObject:_pageVC.viewControllers.lastObject];
        UIViewController *previousViewController = previousViewControllers.firstObject;
        NSInteger previoutIndex = [self.viewControllsers indexOfObject:previousViewController];
        UIViewController *currVc = (_viewControllsers[_currentIndex]);
        self.didHandlerBlock(self.pageVC, _currentIndex, currVc, previoutIndex);
        NSLog(@"\n\ncomplete\ncurrentIdx:%ld\npreIdx%ld\n\n ",_currentIndex,previoutIndex);
    }else{
        _currentIndex = [self.viewControllsers indexOfObject:_pageVC.viewControllers.lastObject];
        UIViewController *previousViewController = previousViewControllers.firstObject;
        NSInteger previoutIndex = [self.viewControllsers indexOfObject:previousViewController];
        UIViewController *currVc = (_viewControllsers[_currentIndex]);
        self.didHandlerBlock(self.pageVC, _currentIndex, currVc, previoutIndex);
        NSLog(@"\n\nuncomplete\ncurrentIdx:%ld\npreIdx%ld\n\n ",_currentIndex,previoutIndex);

    }
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [self.viewControllsers indexOfObject:viewController];
    NSLog(@"\n\nBefore--之前的index:%ld\ncurrentIdx:%ld\n\n",index,self.currentIndex);
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    NSLog(@"\n\nBefore--之后的index:%ld\ncurrentIdx:%ld\n\n",index,self.currentIndex);
//    NSLog(@"%s----_%d",__func__,index);
    return self.viewControllsers[index];
}
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger index = [self.viewControllsers indexOfObject:viewController];
    NSLog(@"\n\nAfter--之前的index:%ld\ncurrentIdx:%ld\n\n",index,self.currentIndex);

    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    NSLog(@"\n\nAfter--之后的index:%ld\ncurrentIdx:%ld\n\n",index,self.currentIndex);

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
    CGPoint contentOffset = CGPointMake(-x, 0);
    
    if (self.scrollHandler) {
        self.scrollHandler(contentOffset);
    }
}

- (void)pageScrollToIndex:(NSInteger)index animated:(BOOL)animated finishedHandler:(nonnull void (^)(BOOL))finishedHandler {
    WS(ws)
    NSLog(@"%s",__func__);
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
            NSLog(@"\nfinish:%ld-index:%ld\n",finished,ss.currentIndex);
            finishedHandler(finished);
        }];
    } else if (index < self.previousIndex) {
        __strong typeof(ws) ss = ws;
        [self.pageVC setViewControllers:@[self.viewControllsers[index]] direction:UIPageViewControllerNavigationDirectionReverse animated:animated completion:^(BOOL finished) {
            if (finished) {
            }else{
                ss.currentIndex = ss.previousIndex;
            }
            [ss pageViewController:ss.pageVC didFinishAnimating:animated previousViewControllers:@[ss.viewControllsers[ss.currentIndex]] transitionCompleted:YES];
            NSLog(@"\nfinish:%ld-index:%ld\n",finished,ss.currentIndex);
            finishedHandler(finished);
        }];
    } else {
        [self pageViewController:self.pageVC didFinishAnimating:animated previousViewControllers:@[self.viewControllsers[self.currentIndex]] transitionCompleted:YES];
        self.currentIndex = index;
    }
}

@end
