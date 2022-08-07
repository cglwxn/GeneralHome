
//  ViewController.m
//  SouFun
//
//  Created by Z on 2019/8/15.
//  Copyright © 2019 房天下 Fang.com. All rights reserved.
//

#import "ViewController.h"
#import "FangFeedbackButton.h"
#import "FangPageViewController.h"
#import "FangMianCustomerTableView.h"
#import "FangProductStorePersonalCell.h"
#import "FangThemeSwitchManager.h"
#import "SubViewController.h"
#import "ViewControllerCell.h"
#import "UILabel+FangLabel.h"
#import "WelcomViewController.h"

static NSString *FangProductStorePersonalCellID = @"FangProductStorePersonalCellID";
static NSString *ViewControllerCellID = @"ViewControllerCellID";

@interface ViewController ()<UIGestureRecognizerDelegate,UITableViewDataSource,UITableViewDelegate,FangPageViewControllerDelegate>

#pragma mark - - new home

@property (nonatomic, strong) FangMianCustomerTableView *mainView;
@property (nonatomic, assign) BOOL canScroll;
@property (nonatomic, assign) BOOL decelerate;

/** 假导航 */
@property (nonatomic, strong) UIView *naviView;
@property (nonatomic, strong) UIView *hiddenView;

/** 手指是否下滑 */
@property (nonatomic, assign) BOOL scrollDirectionDown;

/** 主页出屏 */
@property (nonatomic, assign) BOOL homeGoAway;

@property (nonatomic, strong) FangThemeSwitchManager *themeSwitchManager;

@end

@implementation ViewController

#pragma mark - - new home
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorMake(0xF5F5F5);
    self.canScroll = YES;
    [self.view addSubview:self.mainView];
    if (@available(iOS 11.0, *)) {
        self.mainView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.isMainTableViewCanScroll = YES;
    self.isListCollectionViewCanScroll = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBarHidden = YES;
    self.mainView.contentInset = UIEdgeInsetsMake(SCREEN_TOP_BAR_HEIGHT, 0, 0, 0);
    [self.mainView setContentOffset:CGPointMake(0, -SCREEN_TOP_BAR_HEIGHT) animated:NO];
    _scrollDirectionDown = NO;
    _homeGoAway = NO;
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)tableCanScroll:(NSNotification*)noti{
    NSString * str = [noti object];
    if ([str isEqualToString:@"0"]) {
        self.canScroll = NO;
    }
    if ([str isEqualToString:@"1"]) {
        self.canScroll = YES;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"maintabbarNoticeRocketStyle" object:@"1"];
    }
    if ([str isEqualToString:@"8"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"maintabbarNoticeRocketStyle" object:@"0"];
    }
}

- (FangMianCustomerTableView *)mainView {
    if (!_mainView) {
        CGRect mainFrame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        _mainView = [[FangMianCustomerTableView alloc] initWithFrame:mainFrame style:UITableViewStylePlain];
        _mainView.contentInset = UIEdgeInsetsMake(88, 0, 0, 0);
         [_mainView addSubview:self.hiddenView];
        [_mainView addSubview:self.naviView];
        _mainView.backgroundColor = UIColorMake(0xF5F5F5);
//        _mainView.backgroundColor = UIColor.brownColor;

        _mainView.dataSource = self;
        _mainView.delegate = self;
        _mainView.decelerationRate = 0.999;
        _mainView.estimatedRowHeight = 90;
        _mainView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainView.showsVerticalScrollIndicator = NO;
        _mainView.showsHorizontalScrollIndicator = YES;
        [_mainView registerClass:[ViewControllerCell class] forCellReuseIdentifier:ViewControllerCellID];
        [_mainView registerClass:[FangProductStorePersonalCell class] forCellReuseIdentifier:FangProductStorePersonalCellID];
        if (@available(iOS 15.0, *)) {
            _mainView.sectionHeaderTopPadding = 0;
        }
    }
    return _mainView;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    //手指刚开始触碰
    //添加广告消失动画,建议使用transform,frame应该也可以.
    self.decelerate = NO;
}

//手指即将离开屏幕,velocity滑动方向
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
}

//手指离开屏幕,decelerate是否减速停止
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
//    NSLog(@"decelerationRate---%f",scrollView.decelerationRate);
    UITableView *tableView = (UITableView *)scrollView;
    CGPoint velocity = [tableView.panGestureRecognizer velocityInView:self.view];
    NSLog(@"scrollViewDidEndDragging--decelerationRate>>>>%f",velocity.y);
    if (velocity.y > 0) {
        //手指下滑
        _scrollDirectionDown = YES;
    }else{
        //手指上滑
        _scrollDirectionDown = NO;
    }

    if (decelerate == NO) {
        //手指离开立刻停止
    }
    self.decelerate = decelerate;

    if (scrollView == self.mainView) {
        if (scrollView.contentOffset.y < 2*(-SCREEN_TOP_BAR_HEIGHT)){
            if (!_scrollDirectionDown) {
                //上滑
            NSLog(@"up---%@---%@",NSStringFromUIEdgeInsets(scrollView.contentInset),NSStringFromCGPoint(scrollView.contentOffset));
                if (decelerate) {
                    //滚动减速停止,一起设置contentinset
                    scrollView.contentInset = UIEdgeInsetsMake(SCREEN_TOP_BAR_HEIGHT, 0, 0, 0);
                    [scrollView setContentOffset:CGPointMake(0, -SCREEN_TOP_BAR_HEIGHT) animated:YES];
                }else{
                    //立即停止,在动画停止的代理里设置contentinset
                    [scrollView setContentOffset:CGPointMake(0, -SCREEN_TOP_BAR_HEIGHT) animated:YES];
                }
                CGRect frame = self.tabBarController.tabBar.frame;
                frame.origin.y = [[UIScreen mainScreen] bounds].size.height - (49+25);
                self.tabBarController.tabBar.frame = frame;
            }else{
                //下滑
                scrollView.contentInset = UIEdgeInsetsMake((SCREEN_HEIGHT), 0, 0, 0);
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [scrollView setContentOffset:CGPointMake(0, -(SCREEN_HEIGHT)) animated:YES];
                });
            NSLog(@"down---%@---%@--%@",NSStringFromUIEdgeInsets(scrollView.contentInset),NSStringFromCGPoint(scrollView.contentOffset),NSStringFromCGRect(self.tabBarController.tabBar.frame));

                CGRect frame = self.tabBarController.tabBar.frame;
                frame.origin.y = [[UIScreen mainScreen] bounds].size.height+25;
                self.tabBarController.tabBar.frame = frame;
            }
        }
    }
}

//慢慢减速停止
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (self.decelerate) {
//        if (_scrollDirectionDown) {
//            CGRect frame = self.tabBarController.tabBar.frame;
//            frame.origin.y = [[UIScreen mainScreen] bounds].size.height+25;
//            self.tabBarController.tabBar.frame = frame;
//        }else{
//            CGRect frame = self.tabBarController.tabBar.frame;
//            frame.origin.y = [[UIScreen mainScreen] bounds].size.height - (49+25);
//            self.tabBarController.tabBar.frame = frame;
//        }
    }
}

//滚动动画结束
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if (_scrollDirectionDown) {
        _homeGoAway = YES;
        self.hiddenView.center = CGPointMake(SCREEN_WIDTH/2, scrollView.contentOffset.y+SCREEN_TOP_BAR_HEIGHT+SCREEN_TOP_BAR_HEIGHT);
    }else{
        _homeGoAway = NO;
        scrollView.contentInset = UIEdgeInsetsMake(SCREEN_TOP_BAR_HEIGHT, 0, 0, 0);
        CGFloat alpha = 0;
        CGFloat tra = 0.5;
        self.hiddenView.alpha = alpha;
        self.hiddenView.transform = CGAffineTransformScale(CGAffineTransformIdentity, tra, tra);
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

//    if (scrollView == self.mainView) {
//        CGFloat sectionOffsetY = ceilf([self.mainView rectForSection:1].origin.y - 1);
//        CGFloat scrollOffsetY = ceilf(self.mainView.contentOffset.y);
//        if (scrollOffsetY >= sectionOffsetY) {
//            self.mainView.contentOffset = CGPointMake(0, sectionOffsetY);
//            if (self.canScroll) {
//                self.canScroll = NO;
//                [[NSNotificationCenter defaultCenter] postNotificationName:@"main_scroll_top" object:@"1"];
//            }
//        }else{
//            if (!self.canScroll) {//子视图没到顶部
//                self.mainView.contentOffset = CGPointMake(0, sectionOffsetY);
//            }
//        }
//
//    }
    CGFloat listTableViewCellOffset = [_mainView rectForSection:1].origin.y - SCREEN_TOP_BAR_HEIGHT;
    if (_mainView.contentOffset.y>=listTableViewCellOffset) {
        _mainView.contentOffset = CGPointMake(0, listTableViewCellOffset);
        if (self.isMainTableViewCanScroll) {
            self.isMainTableViewCanScroll = NO;
            self.isListCollectionViewCanScroll = YES;
        }
    }else{
        if (!self.isMainTableViewCanScroll) {
            _mainView.contentOffset = CGPointMake(0, listTableViewCellOffset);
        }else{
            self.isListCollectionViewCanScroll = NO;
        }
    }
    
    SubViewController *currVC = (SubViewController *)self.currentCategoryVC;
    currVC.isListCollectionViewCanScroll = self.isListCollectionViewCanScroll;
    currVC.isMainTableViewCanScroll = self.isMainTableViewCanScroll;
    
    
    CGPoint velocity = [self.mainView.panGestureRecognizer velocityInView:self.view];
//    NSLog(@"decelerationRate>>>>>%f",scrollView.decelerationRate);
    NSLog(@"%lf>>>%f>>>>%@",velocity.y,(scrollView.contentOffset.y),NSStringFromUIEdgeInsets(self.mainView.contentInset));

    if(scrollView.contentOffset.y < -SCREEN_TOP_BAR_HEIGHT){
        self.naviView.frame = CGRectMake(0, -SCREEN_TOP_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_TOP_BAR_HEIGHT);
    }else{
        self.naviView.frame = CGRectMake(0, scrollView.contentOffset.y, SCREEN_WIDTH, SCREEN_TOP_BAR_HEIGHT);
    }
    if (!_homeGoAway) {
        if (scrollView.contentOffset.y < -2.5 * SCREEN_TOP_BAR_HEIGHT && scrollView.contentOffset.y > -SCREEN_HEIGHT) {
//            NSLog(@"velocity>>%f",velocity.y);

            CGFloat alpha = (scrollView.contentOffset.y+2.5*SCREEN_TOP_BAR_HEIGHT)/(-SCREEN_HEIGHT+2.5*SCREEN_TOP_BAR_HEIGHT);
            CGFloat tra = 0.5 + 0.5*(scrollView.contentOffset.y+2.5*SCREEN_TOP_BAR_HEIGHT)/(-SCREEN_HEIGHT + 2.5 * SCREEN_TOP_BAR_HEIGHT);
            CGPoint center = CGPointMake(SCREEN_WIDTH/2, SCREEN_TOP_BAR_HEIGHT/2+SCREEN_TOP_BAR_HEIGHT/2*(scrollView.contentOffset.y+2.5*SCREEN_TOP_BAR_HEIGHT)/(-SCREEN_HEIGHT+2.5*SCREEN_TOP_BAR_HEIGHT)+scrollView.contentOffset.y+SCREEN_TOP_BAR_HEIGHT);
            self.hiddenView.alpha = alpha;
            self.hiddenView.transform = CGAffineTransformScale(CGAffineTransformIdentity, tra, tra);
            self.hiddenView.center = center;
            NSLog(@"alpha>>%f--transform>>%f>>>center:%f",alpha,tra,center.y);
        }
    }else{

    }
    if (scrollView.contentOffset.y < -SCREEN_TOP_BAR_HEIGHT) {
        self.naviView.backgroundColor = [UIColor clearColor];
        self.mainView.backgroundColor = UIColorMake(0xF5F5F5);
    }else{
        self.naviView.backgroundColor = UIColorMake(0xF5F5F5);
        self.mainView.backgroundColor = UIColorMake(0xF5F5F5);

    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 60;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
//        UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
//        header.backgroundColor = UIColor.greenColor;
        return  nil;
    }else{
        return self.themeSwitchManager.themeSwitch;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
//    footer.backgroundColor = UIColor.blueColor;
    return  nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        return 220;
    }else {
        return SCREEN_HEIGHT  - SCREEN_TOP_BAR_HEIGHT - 60;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        ViewControllerCell *cell = [tableView dequeueReusableCellWithIdentifier:ViewControllerCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        __weak ViewController *ws = self;
        cell.itemTapBlock = ^(NSInteger index) {
            __strong ViewController *ss = ws;
            WelcomViewController *vc = [[WelcomViewController alloc] init];
            [ss.navigationController pushViewController:vc animated:YES];
        };
        return cell;
    }else{
        FangProductStorePersonalCell *cell = [tableView dequeueReusableCellWithIdentifier:FangProductStorePersonalCellID forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (![self.themeSwitchManager.pageVC.view isDescendantOfView:cell.contentView]) {
            [cell.contentView addSubview:self.themeSwitchManager.pageVC.view];
            self.themeSwitchManager.pageVC.view.frame = cell.bounds;
            [self addChildViewController:self.themeSwitchManager.pageVC];
            [self.themeSwitchManager.pageVC.view didMoveToSuperview];
        }
        return cell;
    }
}

#pragma mark - page control

- (FangThemeSwitchManager *)themeSwitchManager {
    if (!_themeSwitchManager) {
        _themeSwitchManager = [[FangThemeSwitchManager alloc] init];
        _themeSwitchManager.themeSwitch.backgroundColor = UIColorMake(0xF5F5F5);
        self.themeSwitchManager.themeSwitch.titles = @[@"七里香",@"晴天",@"忘",@"布拉格广场",@"简单爱",@"稻香",@"安静",@"米兰的小铁匠"];
        _themeSwitchManager.themeSwitch.titleFont = [UIFont fontWithName:@"PingFangSC-Regular" size:17];
        _themeSwitchManager.selectedTitleFont = [UIFont fontWithName:@"PingFangSC-Medium" size:18];
        
        _themeSwitchManager.themeSwitch.titleColor = UIColor.fangDarkGrayColor;
        _themeSwitchManager.themeSwitch.selectedTitleColor = [UIColor light:kFColor_0E131A dark:kFColor_007AFF];
        _themeSwitchManager.themeSwitch.sliderColor = [UIColor light:kFColor_3295F6 dark:kFColor_007AFF];
        
        _themeSwitchManager.themeSwitch.leadSpacing = 16;
        _themeSwitchManager.themeSwitch.fixedSpacing = 22;
        _themeSwitchManager.themeSwitch.topSpacing = 10;
        _themeSwitchManager.themeSwitch.bottomSpacing = 17;
        _themeSwitchManager.themeSwitch.trailSpacing = 16;
        
        SubViewController *vc0 = [[SubViewController alloc] init];
        vc0.mainVC = self;
        vc0.view.backgroundColor = UIColorMake(0xF5F5F5);
        SubViewController *vc1 = [[SubViewController alloc] init];
        vc1.mainVC = self;
        vc1.view.backgroundColor = UIColorMake(0xF5F5F5);
        SubViewController *vc2 = [[SubViewController alloc] init];
        vc2.mainVC = self;
        vc2.view.backgroundColor = UIColorMake(0xF5F5F5);
        SubViewController *vc3 = [[SubViewController alloc] init];
        vc3.mainVC = self;
        vc3.view.backgroundColor = UIColorMake(0xF5F5F5);

        SubViewController *vc4 = [[SubViewController alloc] init];
        vc4.mainVC = self;
        vc4.view.backgroundColor = UIColorMake(0xF5F5F5);
        SubViewController *vc5 = [[SubViewController alloc] init];
        vc5.mainVC = self;
        vc5.view.backgroundColor = UIColorMake(0xF5F5F5);

        
        SubViewController *vc6 = [[SubViewController alloc] init];
        vc6.mainVC = self;
        vc6.view.backgroundColor = UIColorMake(0xF5F5F5);
        SubViewController *vc7 = [[SubViewController alloc] init];
        vc7.mainVC = self;
        vc7.view.backgroundColor = UIColorMake(0xF5F5F5);

        self.currentCategoryVC = vc0;
                
        WS(ws)
        [self.themeSwitchManager congfigueWithChildViewControllers:@[vc0,vc1,vc2,vc3,vc4,vc5,vc6,vc7] willTransitionHandler:^(UIPageViewController * _Nullable pageVC, NSInteger index, UIViewController * _Nonnull currentViewController, NSInteger previoutIndex) {
            
        } didTransitionHandler:^(UIPageViewController * _Nullable pageVC, NSInteger index, UIViewController * _Nonnull currentViewController, NSInteger previoutIndex) {
            __strong typeof(ws) ss = ws;
            ss.currentCategoryVC = currentViewController;
        }];
    }
    return _themeSwitchManager;;
}

- (UIView *)naviView {
    if (!_naviView) {
        _naviView = [[UIView alloc] initWithFrame:CGRectMake(0, -SCREEN_TOP_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_TOP_BAR_HEIGHT)];
        _naviView.backgroundColor = UIColorMake(0xF5F5F5);
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(SCREEN_WIDTH-47,6+STATUS_BAR_HEIGHT,32,32);
        [_naviView addSubview:button];


        NSString *title = @"往下滑动 ↓";
        UIFont *font = [UIFont systemFontOfSize:20 weight:UIFontWeightSemibold];
        CGFloat width = 200;
        UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(16, 8+STATUS_BAR_HEIGHT, width, 28)];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:UIColorMake(0x0E131A) forState:UIControlStateNormal];
        btn.titleLabel.font = font;
        [_naviView addSubview:btn];
        
//        NSString *title1 = @"感受↓按钮点击效果";
//        UIFont *font1 = [UIFont systemFontOfSize:20 weight:UIFontWeightSemibold];
//        CGFloat width1 = 200;
//        UIButton * btn1 = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-200- 16, 8+STATUS_BAR_HEIGHT, width1, 28)];
//        btn1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
////        [btn setBackgroundColor:[UIColor defaultBGColor]];
//        [btn1 setTitle:title1 forState:UIControlStateNormal];
//        [btn1 setTitleColor:UIColorMake(0x0E131A) forState:UIControlStateNormal];
//        btn1.titleLabel.font = font1;
//        [_naviView addSubview:btn1];

    }
    return _naviView;
}

- (UIView *)hiddenView {
    if (!_hiddenView) {
        _hiddenView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_TOP_BAR_HEIGHT, SCREEN_WIDTH, 2*SCREEN_TOP_BAR_HEIGHT)];
        _hiddenView.alpha = 0;
        _hiddenView.backgroundColor = UIColorMake(0xF5F5F5);
        _hiddenView.backgroundColor = [UIColor clearColor];

        _hiddenView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.5, 0.5);
        FangFeedbackButton *saleHouseView = [self obtainViewFrame:CGRectMake(10, 0, (SCREEN_WIDTH-20)/5, 56) title:@"出售房源" imageName:@"FangMicroshop_SalehouseImg"];
        saleHouseView.feedbackButtonEventHandler = ^(UIView * _Nullable view, CGPoint touchPoint) {
            WelcomViewController *vr = [[WelcomViewController alloc] init];
            [self.navigationController pushViewController:vr animated:YES];
        };
        FangFeedbackButton *rentHouseView = [self obtainViewFrame:CGRectMake(CGRectGetMaxX(saleHouseView.frame), 0, (SCREEN_WIDTH-20)/5, 56) title:@"出租房源" imageName:@"FangMicroshop_RenthouseImg"];
        rentHouseView.feedbackButtonEventHandler = ^(UIView * _Nullable view, CGPoint touchPoint) {
            WelcomViewController *vr = [[WelcomViewController alloc] init];
            [self.navigationController pushViewController:vr animated:YES];
        };
         FangFeedbackButton *inputHouseView = [self obtainViewFrame:CGRectMake(CGRectGetMaxX(rentHouseView.frame), 0, (SCREEN_WIDTH-20)/5, 56) title:@"录入房源" imageName:@"FangMicroshop_InputhouseImg"];
        inputHouseView.feedbackButtonEventHandler = ^(UIView * _Nullable view, CGPoint touchPoint) {
            WelcomViewController *vr = [[WelcomViewController alloc] init];
            [self.navigationController pushViewController:vr animated:YES];
        };
        FangFeedbackButton *lookHouseRecordView = [self obtainViewFrame:CGRectMake(CGRectGetMaxX(inputHouseView.frame), 0, (SCREEN_WIDTH-20)/5, 56) title:@"看房记录" imageName:@"FangMicroshop_LookhouseImg"];
        lookHouseRecordView.feedbackButtonEventHandler = ^(UIView * _Nullable view, CGPoint touchPoint) {
            WelcomViewController *vr = [[WelcomViewController alloc] init];
            [self.navigationController pushViewController:vr animated:YES];
        };

        FangFeedbackButton *VRHouseView = [self obtainViewFrame:CGRectMake(CGRectGetMaxX(lookHouseRecordView.frame), 0, (SCREEN_WIDTH-20)/5, 56) title:@"VR管理" imageName:@"FangMicroshop_VRManageImg"];
        VRHouseView.feedbackButtonEventHandler = ^(UIView * _Nullable view, CGPoint touchPoint) {
            WelcomViewController *vr = [[WelcomViewController alloc] init];
            [self.navigationController pushViewController:vr animated:YES];
        };

        FangFeedbackButton *collectHouseView = [self obtainViewFrame:CGRectMake(10, CGRectGetMaxY(saleHouseView.frame)+44, (SCREEN_WIDTH-20)/5, 56) title:@"房源采集" imageName:@"FangMicroshop_CollecthouseImg"];
        collectHouseView.feedbackButtonEventHandler = ^(UIView * _Nullable view, CGPoint touchPoint) {
            WelcomViewController *vr = [[WelcomViewController alloc] init];
            [self.navigationController pushViewController:vr animated:YES];
            
        };

        FangFeedbackButton *commissionHouseView = [self obtainViewFrame:CGRectMake(CGRectGetMaxX(collectHouseView.frame), CGRectGetMaxY(saleHouseView.frame)+44, (SCREEN_WIDTH-20)/5, 56) title:@"委托房源" imageName:@"FangMicroshop_CommissionImg"];
        commissionHouseView.feedbackButtonEventHandler = ^(UIView * _Nullable view, CGPoint touchPoint) {
            WelcomViewController *vr = [[WelcomViewController alloc] init];
            [self.navigationController pushViewController:vr animated:YES];
        };

        [_hiddenView addSubview:saleHouseView];
        [_hiddenView addSubview:rentHouseView];
        [_hiddenView addSubview:inputHouseView];
        [_hiddenView addSubview:lookHouseRecordView];
        [_hiddenView addSubview:VRHouseView];
        [_hiddenView addSubview:collectHouseView];
        [_hiddenView addSubview:commissionHouseView];

    }
    return _hiddenView;
}

- (FangFeedbackButton *)obtainViewFrame:(CGRect)frame title:(NSString *)title imageName:(NSString *)imageName {
    FangFeedbackButton *funView = [[FangFeedbackButton alloc] initWithFrame:frame];
    funView.backgroundColor = UIColor.clearColor;
    funView.scaleDuration = 0.15;
    funView.layoutDirection = FangFeedbackButtonLayoutDirectionVertical;
    [funView setImage:[UIImage imageNamed:imageName]];
    [funView setTitle:title];
    [funView setTtitleColor:[UIColor grayColor]];
    funView.textLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:13];
    return funView;
}

@end
