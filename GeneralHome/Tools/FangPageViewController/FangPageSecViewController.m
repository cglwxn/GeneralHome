//
//  FangPageSecViewController.m
//  SouFun
//
//  Created by iPan on 2020/6/11.
//  Copyright © 2020 房天下 Fang.com. All rights reserved.
//

#import "FangPageSecViewController.h"

@interface FangPageSecViewController ()<UIPageViewControllerDataSource, UIPageViewControllerDelegate, UIScrollViewDelegate>

@property (strong, nonatomic) UIPageViewController *pageViewController;

@end

@implementation FangPageSecViewController

#pragma mark - Lifecycle

- (instancetype)initWithViewControllers:(NSArray<UIViewController *> *)viewControllers
{
    self = [super init];
    if (self) {
        _viewControllers = viewControllers;
        _currentIndex = 0;
        _animated = YES;
        _canScroll = YES;
    }
    return self;
}

- (instancetype)initWithViewControllers:(NSArray<UIViewController *> *)viewControllers
                               delegate:(id<FangPageSecViewControllerDelegate>)delegate {
    self = [self initWithViewControllers:viewControllers];
    if (self) {
        _pageDelegate = delegate;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Configure the page view controller and add it as a child view controller.
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageViewController.delegate = self;
    
    UIViewController *startingViewController = self.viewControllers[self.currentIndex];
    
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    self.pageViewController.dataSource = self;
    
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    self.pageViewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    // Set the page view controller's bounds using an inset rect so that self's view is visible around the edges of the pages.
    CGRect pageViewRect = self.view.bounds;
    
    self.pageViewController.view.frame = pageViewRect;
    
    [self.pageViewController didMoveToParentViewController:self];
    
    
    for (UIView *view in self.pageViewController.view.subviews) {
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scollView = (UIScrollView *)view;
            scollView.scrollEnabled = self.canScroll;
            scollView.delegate = self;
            break;
        }
    }
}


#pragma mark - Public

- (void)didSelectViewControllerAtIndex:(NSInteger)index {
    FangPageSecViewController * weakSelf = self;

    if (index > self.currentIndex) {
        weakSelf.currentIndex = index;
        [self.pageViewController setViewControllers:@[self.viewControllers[index]] direction:UIPageViewControllerNavigationDirectionForward animated:_animated completion:^(BOOL finished) {
            if (finished) {
                if ([weakSelf.pageDelegate respondsToSelector:@selector(didFinishTransitionAtIndex:)]) {
                    [weakSelf.pageDelegate didFinishTransitionAtIndex:weakSelf.currentIndex];
                }
            }
        }];
    } else if (index < self.currentIndex) {
        weakSelf.currentIndex = index;
        [self.pageViewController setViewControllers:@[self.viewControllers[index]] direction:UIPageViewControllerNavigationDirectionReverse animated:_animated completion:^(BOOL finished) {
            if (finished) {
                if ([weakSelf.pageDelegate respondsToSelector:@selector(didFinishTransitionAtIndex:)]) {
                    [weakSelf.pageDelegate didFinishTransitionAtIndex:weakSelf.currentIndex];
                }
            }
        }];
    } else {
        self.currentIndex = index;
        if ([self.pageDelegate respondsToSelector:@selector(didFinishTransitionAtIndex:)]) {
            [self.pageDelegate didFinishTransitionAtIndex:self.currentIndex];
        }
    }
}


#pragma mark - Private

- (NSUInteger)indexOfViewController:(UIViewController *)viewController {
    // Return the index of the given view controller.
    return [self.viewControllers indexOfObject:viewController];
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([self.pageDelegate respondsToSelector:@selector(pageViewControllerDidScroll:)]) {
        [self.pageDelegate pageViewControllerDidScroll:scrollView];
    }
}

#pragma mark - UIPageViewControllerDataSource

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger index = [self indexOfViewController:viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return self.viewControllers[index];
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger index = [self indexOfViewController:viewController];
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.viewControllers count]) {
        return nil;
    }
    return self.viewControllers[index];
}


#pragma mark - UIPageViewControllerDelegate

- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation {
    
    UIViewController *currentViewController = self.pageViewController.viewControllers[0];
    NSArray *viewControllers = @[currentViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    self.pageViewController.doubleSided = NO;
    return UIPageViewControllerSpineLocationMin;
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    self.currentIndex = [self indexOfViewController:self.pageViewController.viewControllers.lastObject];
    if (completed) {
        if ([self.pageDelegate respondsToSelector:@selector(didFinishTransitionAtIndex:)]) {
            [self.pageDelegate didFinishTransitionAtIndex:self.currentIndex];
        }
    }
}


@end
