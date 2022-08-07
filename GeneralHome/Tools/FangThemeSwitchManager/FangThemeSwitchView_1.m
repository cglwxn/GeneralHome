//
//  FangThemeSwitchView_1.m
//  SouFun
//
//  Created by Guanglei Cheng on 2019/7/18.
//  Copyright © 2019 房天下 Fang.com. All rights reserved.
//  范例:
//  https://lanhuhu.com/web/#/item/project/board/detail?pid=68cd9572-15a1-40ba-ab60-6ef5fccd0c5d&project_id=68cd9572-15a1-40ba-ab60-6ef5fccd0c5d&image_id=e8eae925-bd77-45ac-a517-2196a3b803bf
//  https://lanhuhu.com/web/#/item/project/board/detail?pid=c27e756a-8c39-4d10-9e7d-c5fb78fe93d3&project_id=c27e756a-8c39-4d10-9e7d-c5fb78fe93d3&image_id=72db694d-8d4e-4f06-8433-3a373a0e0bb9

#import "FangThemeSwitchView_1.h"
#import "Masonry.h"
#import "UIButton+FangButton.h"
#import "NSString+Size.h"
#import "UILabel+FangLabel.h"

@interface FangThemeSwitchView_1 ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *contentV;

@property (nonatomic, strong) NSArray *buttons;

@property (nonatomic, strong) NSMutableArray *badges;

@property (nonatomic, strong) UIView *containerView;

@property (nonatomic, assign) CGFloat contentSizeWidth;

@property (nonatomic, assign) BOOL buttonClicked;

//slider初始centerX
@property (nonatomic, assign) MASConstraint *originCenter;
//button0的centerY到containerview顶部的约束
@property (nonatomic, assign) MASConstraint *originCenterYTopConstraint;

@property (nonatomic, assign) NSInteger previousIndex;

@end

@implementation FangThemeSwitchView_1

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _hideSlider = NO;
        self.backgroundColor = [UIColor defaultBGColor];
        [self addSubview:self.contentV];
        [self makeConstraints];
        _currentIndex = 0;
        _topSpacing = -1;
        _bottomSpacing = -1;
        _trailSpacing = -1;
        _leadSpacing = -1;
        _fixedSpacing = -1;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.locateInCenter) {
        [self.containerView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentV.mas_top).mas_offset(0);
            make.bottom.equalTo(self.contentV.mas_bottom).mas_offset(0);
            make.centerX.mas_equalTo(self.contentV);
        }];
    }
    
    
    UIButton *button = self.buttons[0];
    NSLayoutConstraint *constraint = [self.originCenterYTopConstraint valueForKey:@"layoutConstraint"];
    CGFloat centerYtop = constraint.constant;
    [button mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.containerView.mas_bottom).mas_offset(-CGRectGetHeight(self.bounds)+centerYtop);
    }];
    
    
}

- (void)makeConstraints {
    [self.contentV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).mas_offset(0);
        make.top.equalTo(self.mas_top).mas_offset(0);
        make.bottom.equalTo(self.mas_bottom).mas_offset(0);
        make.right.mas_equalTo(self.mas_right).mas_offset(0);
    }];
    
    [self.containerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentV.mas_left).mas_offset(0);
        make.top.equalTo(self.contentV.mas_top).mas_offset(0);
        make.bottom.equalTo(self.contentV.mas_bottom).mas_offset(0);
//        make.bottom.mas_equalTo(100);
        make.right.mas_equalTo(self.contentV.mas_right).mas_equalTo(0).priority(749);//containerView子view是UIButton,UIButton是拥有固有的约束(intrinsic content size,即可以根据内部标题+图片自动计算size),其固有约束的抗压缩约束优先级(Content Compression Resistance Priority)是750,抗拉伸优先级(Content Hugging Priority)是250.当内部所有约束不等于外部宽度/高度,会根据优先级进行拉伸/压缩固有大小.此处设置749,小于抗压缩优先级,从而当内部的button根据内容(标题+图片)自动计算出其固有约束后,因为其抗压缩优先级750,大于containerView右边距约束949,从而子view会"撑大"containerView,containerView增大后,contentV会根据containerView的大小更新其contentsize
    }];
}

- (void)makeButtonsConstraints {
    CGFloat leadingSpace = self.leadSpacing>=0?self.leadSpacing:16;
    CGFloat trailSpace = self.trailSpacing>=0?self.trailSpacing:14;
    CGFloat topSpace = self.topSpacing>=0?self.topSpacing:10;
    CGFloat bottomSpace = self.bottomSpacing>=0?self.bottomSpacing:18;
    CGFloat fixSpace = self.fixedSpacing>=0?self.fixedSpacing:22;
    
    
    //布局前先设置为统一字体,以固定被选中按钮的centerX
    UIFont *titleFont = self.titleFont?self.titleFont:[UIFont fontWithName:@"PingFangSC-Regular" size:17];
    UIFont *selectedTitleFont = self.selectedTitleFont?self.selectedTitleFont:[UIFont fontWithName:@"PingFangSC-Medium" size:18];
    
    UIButton *selectedButton = self.buttons[_currentIndex];
    selectedButton.titleLabel.font = titleFont;
    if (self.buttons.count < 2) {
        UIButton *subView = [self.containerView viewWithTag:1000];
        CGSize btn0IntrinsicSize = subView.intrinsicContentSize;
        [subView mas_remakeConstraints:^(MASConstraintMaker *make) {
            self.originCenterYTopConstraint =  make.centerY.mas_equalTo(self.containerView.mas_top).mas_equalTo(btn0IntrinsicSize.height/2+topSpace).priority(749);
            make.centerY.mas_equalTo(self.containerView.mas_bottom).mas_equalTo(-btn0IntrinsicSize.height/2-bottomSpace).priority(248);
            make.centerX.mas_equalTo(self.containerView.mas_left).mas_offset(btn0IntrinsicSize.width/2+leadingSpace);
        }];
    }else{
        UIButton *button0 = _buttons[0];
        CGSize btn0IntrinsicSize = button0.intrinsicContentSize;
        for (int i = 0; i < _buttons.count; i ++) {
            if (i == 0) {
                [button0 mas_remakeConstraints:^(MASConstraintMaker *make) {
                    self.originCenterYTopConstraint =  make.centerY.mas_equalTo(self.containerView.mas_top).mas_equalTo(btn0IntrinsicSize.height/2+topSpace).priority(749);
                    make.centerX.mas_equalTo(self.containerView.mas_left).mas_offset(btn0IntrinsicSize.width/2+leadingSpace);
                }];
            }else{
                UIButton *button = _buttons[i];
                UIButton *preButton = _buttons[i-1];
                
                CGSize btnIntrinsicSize = button.intrinsicContentSize;
                CGSize preBtnIntrinsicSize = preButton.intrinsicContentSize;

                if (i!=self.buttons.count-1) {
                    [button mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.centerY.mas_equalTo(self.containerView.mas_top).mas_equalTo(btnIntrinsicSize.height/2+topSpace);
                        make.centerX.mas_equalTo(preButton).mas_offset(preBtnIntrinsicSize.width/2+fixSpace+btnIntrinsicSize.width/2);
                    }];
                }else{
                    if (i == 1) {
                        [button mas_remakeConstraints:^(MASConstraintMaker *make) {
                            make.centerY.mas_equalTo(self.containerView.mas_top).mas_equalTo(btnIntrinsicSize.height/2+topSpace);
                            make.centerX.mas_equalTo(self.containerView.mas_right).mas_offset(-btnIntrinsicSize.width/2-trailSpace);
                            make.centerX.mas_equalTo(button0).mas_offset(btn0IntrinsicSize.width/2+fixSpace+btnIntrinsicSize.width/2);
                        }];
                    }else{
                        [button mas_remakeConstraints:^(MASConstraintMaker *make) {
                            make.centerX.mas_equalTo(preButton).mas_offset(preBtnIntrinsicSize.width/2+fixSpace+btnIntrinsicSize.width/2);
                            make.centerY.mas_equalTo(self.containerView.mas_top).mas_equalTo(btnIntrinsicSize.height/2+topSpace);
                            make.centerX.mas_equalTo(self.containerView.mas_right).mas_offset(-btnIntrinsicSize.width/2-trailSpace);
                        }];
                    }
                }
            }
        }
    }
    //布局完成后单独设置选中button的字
    selectedButton.titleLabel.font = selectedTitleFont;
}

- (void)makeBadgesConstraints {
    for (int i = 0; i < self.badges.count; i ++) {
        UIButton *button = self.buttons[i];
        UILabel *badge = ((UILabel *)self.badges[i]);

        [badge mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(button.mas_right).offset(-3);
            make.top.mas_equalTo(button.mas_top).offset(-3);
            make.size.mas_equalTo(CGSizeMake(18, 18));
        }];
    }
}

#pragma mark - actions

- (void)buttonAction:(UIButton *)button {
    
    self.previousIndex = _currentIndex;
    self.buttonClicked = YES;
    UIButton *previousButton = self.buttons[_currentIndex];
    if (previousButton == button) {
        return;
    }
    NSInteger currentIndex = button.tag - 1000;

    //相邻的vc之间动画切换,不相邻的vc之间无动画切换
    BOOL animationTransition = NO;
    if (labs(self.previousIndex - currentIndex) == 1) {
        animationTransition = YES;
    }
    
    [self resetBtnColorAndFont:currentIndex];
    if (!self.hideSlider) {
        [self animateSlider:currentIndex];
    }

    if (self.badges.count > currentIndex) {
        UILabel *badge = self.badges[currentIndex];
        badge.hidden = YES;
    }

    _currentIndex = currentIndex;
    
    if (self.selectThemeInternalHandler) {
        self.selectThemeInternalHandler(currentIndex, button, animationTransition);
    }
    if (self.selectThemeExternalHandler) {
        self.selectThemeExternalHandler(currentIndex);
    }
}

- (void)didFinishScrollToPage:(BOOL)finished {
    if (finished == NO) {
        [self resetBtnColorAndFont:self.previousIndex];
        if (!self.hideSlider) {
            [self animateSlider:self.previousIndex];
        }
    }
}

- (void)scrollWithOffset:(CGFloat)offset outRangeX:(CGFloat)outRangeX {
    if (self.buttonClicked) {
        return;
    }
    if (outRangeX <= 0) {
        outRangeX = SCREEN_WIDTH;
    }
    
    if (self.buttons.count > 1) {
        CGFloat remainder =  fmod(offset, outRangeX);
        
        if (offset <= -outRangeX) {
            NSInteger currentIndex = (NSInteger)(offset/outRangeX);
            NSInteger leftIndex = 0,rightIndex = 0;
            if (currentIndex == self.buttons.count-1) {
                leftIndex = currentIndex;
                rightIndex = currentIndex-1;
            }else{
                leftIndex = currentIndex;
                rightIndex = currentIndex + 1;
            }
        }
        if (remainder != 0&&offset>-outRangeX) {
//            NSLog(@"===================================remainder不等于0");
            NSInteger currentIndex = (NSInteger)(offset/outRangeX);
            NSInteger leftIndex = 0,rightIndex = 0;
            if (currentIndex == self.buttons.count-1) {
                leftIndex = currentIndex;
                rightIndex = currentIndex-1;
            }else{
                leftIndex = currentIndex;
                rightIndex = currentIndex + 1;
            }
            
            UIButton *buttonLeft = (UIButton *)(self.buttons[leftIndex]);
            UIButton *buttonRight = (UIButton *)(self.buttons[rightIndex]);
            CGFloat buttonInterval = fabs(buttonRight.center.x - buttonLeft.center.x);
            CGFloat factor = outRangeX/buttonInterval;
            
            if (!self.hideSlider) {
                //slider移动
                UIView *slider = [self.containerView viewWithTag:10086];
                
                CGSize sliderSize = CGSizeZero;
                if (self.sliderSize.width>0 && self.sliderSize.height>0) {
                    sliderSize = self.sliderSize;
                }else{
                    sliderSize = CGSizeMake(21, 4);
                }
            
                [slider mas_remakeConstraints:^(MASConstraintMaker *make) {
                    self.originCenter = make.centerX.mas_equalTo(buttonLeft).mas_offset(remainder/factor);
                    make.size.mas_equalTo(sliderSize);
                    make.bottom.mas_equalTo(self.containerView.mas_bottom).mas_offset(-6);
                }];
            }
            
//            if (self.contentV.contentSize.width > CGRectGetWidth(self.bounds)) {
//                //contentV移动
//                CGFloat newSliderCenter = buttonLeft.center.x+remainder/factor;
//
//                if (newSliderCenter > CGRectGetWidth(self.bounds)/2 && newSliderCenter < CGRectGetWidth(self.bounds) - CGRectGetWidth(self.bounds)/2) {
//                    [self.contentV setContentOffset:CGPointMake(newSliderCenter-CGRectGetWidth(self.bounds)/2, 0) animated:NO];
//                }else if (newSliderCenter > CGRectGetWidth(self.bounds) - CGRectGetWidth(self.bounds)/2){
//                    [self.contentV setContentOffset:CGPointMake(self.contentV.contentSize.width-CGRectGetWidth(self.bounds), 0) animated:NO];
//                }else if(newSliderCenter < CGRectGetWidth(self.bounds)/2){
//                    [self.contentV setContentOffset:CGPointMake(0, 0) animated:NO];
//                }
//            }
            
            if (self.contentV.contentSize.width > CGRectGetWidth(self.bounds)) {
                //contentV移动
                CGFloat newSliderCenter = buttonLeft.center.x+remainder/factor;
                
//                if (newSliderCenter > CGRectGetWidth(self.bounds)/2 && newSliderCenter < CGRectGetWidth(self.bounds) - CGRectGetWidth(self.bounds)/2) {
//                    [self.contentV setContentOffset:CGPointMake(newSliderCenter-CGRectGetWidth(self.bounds)/2, 0) animated:NO];
//                }else if (newSliderCenter > CGRectGetWidth(self.bounds) - CGRectGetWidth(self.bounds)/2){
//                    [self.contentV setContentOffset:CGPointMake(self.contentV.contentSize.width-CGRectGetWidth(self.bounds), 0) animated:NO];
//                }else if(newSliderCenter < CGRectGetWidth(self.bounds)/2){
//                    [self.contentV setContentOffset:CGPointMake(0, 0) animated:NO];
//                }
                
                CGFloat trasLen = newSliderCenter - self.contentV.contentOffset.x-self.contentV.bounds.size.width/2;
                CGFloat contentOffsetX = self.contentV.contentOffset.x+trasLen;
                if (contentOffsetX < 0) {
                    contentOffsetX = 0;
                }else if (contentOffsetX > self.contentV.contentSize.width - self.contentV.bounds.size.width){
                    contentOffsetX = self.contentV.contentSize.width - self.contentV.bounds.size.width;
                }
                [self.contentV setContentOffset:CGPointMake(contentOffsetX, self.contentV.contentOffset.y) animated:NO];
            }
        }
    }
}

- (void)didFinishTurningPageCurrentIndex:(NSInteger)currentIndex previousIndex:(NSInteger)previousIndex {
    if (self.buttonClicked) {
        self.buttonClicked = NO;
        return;
    }
    self.currentIndex = currentIndex;
    UIFont *selectedTitleFont = self.selectedTitleFont?self.selectedTitleFont:[UIFont fontWithName:@"PingFangSC-Medium" size:18];
    UIFont *titleFont = self.titleFont?self.titleFont:[UIFont fontWithName:@"PingFangSC-Regular" size:17];
    UIColor *selectedTitleColor = self.selectedTitleColor?self.selectedTitleColor:UIColorMake(0x0E131A);
    UIColor *titleColor = self.titleColor?self.titleColor:UIColorMake(0xA4A7A9);

    UIButton *currentButton = self.buttons[currentIndex];
    for (UIButton *otherBtn in self.buttons) {
        if (otherBtn != currentButton) {
            otherBtn.titleLabel.font = titleFont;
            [otherBtn setTitleColor:titleColor forState:(UIControlStateNormal)];
        }
    }
    
    
//    UIButton *previoutButton = self.buttons[previousIndex];
//    previoutButton.titleLabel.font = titleFont;
    currentButton.titleLabel.font = selectedTitleFont;
//    [previoutButton setTitleColor:titleColor forState:(UIControlStateNormal)];
    [currentButton setTitleColor:selectedTitleColor forState:(UIControlStateNormal)];
    
    
    self.buttonClicked = NO;
}

#pragma mark - private

- (void)addButtons:(NSArray *)titles {
    NSMutableArray *buttonArr = [NSMutableArray array];
    NSMutableArray *badges = [NSMutableArray array];
    [titles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        NSString *title = titles[idx];
        [button setTitle:title forState:(UIControlStateNormal)];
        if (self.titleFont) {
            button.titleLabel.font = self.titleFont;
        }else{
            UIFont *font = [UIFont fontWithName:@"PingFangSC-Regular" size:17];
            button.titleLabel.font = font;
        }
        if (idx == _currentIndex) {
            [button setTitleColor:self.selectedTitleColor?self.selectedTitleColor:UIColorMake(0x0E131A) forState:(UIControlStateNormal)];
        }else{
            [button setTitleColor:self.titleColor?self.titleColor:UIColorMake(0xA4A7A9) forState:(UIControlStateNormal)];
        }
        
        UIFont *titleFont = self.titleFont?self.titleFont:[UIFont fontWithName:@"PingFangSC-Regular" size:17];
        button.titleLabel.font = titleFont;
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [button setEnlargeEdgeInsets:UIEdgeInsetsMake(-10, 0, -10, 0)];
        button.tag = 1000+idx;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.containerView addSubview:button];
        [buttonArr addObject:button];
        
        
        UILabel *badge = [UILabel labelWithFrame:CGRectZero text:@"" font:[UIFont fontWithName:@"PingFangSC-Regular" size:12] textColor:UIColorMake(0xFFFFFF) textAlignment:NSTextAlignmentCenter];
        badge.hidden = YES;
        badge.layer.cornerRadius  = 9;
        badge.layer.masksToBounds = YES;
        badge.backgroundColor = UIColorMake(0xFF2429);
        [badges addObject:badge];
        [self.containerView addSubview:badge];
    }];
    self.buttons = buttonArr;
    self.badges = badges;
    [self makeButtonsConstraints];
    [self makeBadgesConstraints];
}


- (void)addSlider {
    UIView *slider = [[UIView alloc] initWithFrame:CGRectZero];
    slider.backgroundColor = self.sliderColor?self.sliderColor:UIColorMake(0x3295F6);
    CGSize sliderSize = CGSizeZero;
    if (self.sliderSize.width>0 && self.sliderSize.height>0) {
        sliderSize = self.sliderSize;
    }else{
        sliderSize = CGSizeMake(21, 4);
    }
    slider.tag = 10086;
    slider.layer.cornerRadius = 2;
    slider.layer.masksToBounds = YES;
    [self.containerView addSubview:slider];
    UIButton *button = self.buttons[_currentIndex];
    [self.containerView addSubview:slider];
    [slider mas_makeConstraints:^(MASConstraintMaker *make) {
        self.originCenter = make.centerX.mas_equalTo(button).mas_offset(0);
        make.size.mas_equalTo(sliderSize);
        make.bottom.mas_equalTo(self.containerView.mas_bottom).mas_offset(-6);
    }];
}

- (void)resetBtnColorAndFont:(NSInteger)newIndexNumum {
    UIButton *previoutButton = self.buttons[_currentIndex];
    UIButton *currentButton = self.buttons[newIndexNumum];
    UIColor *titleColor = self.titleColor?self.titleColor:UIColorMake(0xA4A7A9);
    UIColor *selectedTitleColor = self.selectedTitleColor?self.selectedTitleColor:UIColorMake(0x0E131A);
    UIFont *titleFont = self.titleFont?self.titleFont:[UIFont fontWithName:@"PingFangSC-Regular" size:17];
    UIFont *selectedTitleFont = self.selectedTitleFont?self.selectedTitleFont:[UIFont fontWithName:@"PingFangSC-Medium" size:18];
    [currentButton setTitleColor:selectedTitleColor forState:(UIControlStateNormal)];
    [previoutButton setTitleColor:titleColor forState:(UIControlStateNormal)];
    currentButton.titleLabel.font = selectedTitleFont;
    previoutButton.titleLabel.font = titleFont;
}

- (void)animateSlider:(NSInteger)newIndexNumum {
    UIButton *currentButton = self.buttons[newIndexNumum];
    UIView *slider = [self.containerView viewWithTag:10086];
    CGSize sliderSize = CGSizeZero;
    if (self.sliderSize.width>0 && self.sliderSize.height>0) {
        sliderSize = self.sliderSize;
    }else{
        sliderSize = CGSizeMake(21, 4);
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        [slider mas_remakeConstraints:^(MASConstraintMaker *make) {
            self.originCenter = make.centerX.mas_equalTo(currentButton).mas_offset(0);
            make.size.mas_equalTo(sliderSize);
            make.bottom.mas_equalTo(self.containerView.mas_bottom).mas_offset(-6);
        }];
        [self.containerView layoutIfNeeded];
    }];
    
    CGFloat newSliderCenter = currentButton.center.x;
    CGRect sliderRectInScroll = [self.containerView convertRect:currentButton.frame toView:self];
    
    if (CGRectContainsRect(self.contentV.frame, sliderRectInScroll)) {
        return;
    }
    
    if (newSliderCenter > CGRectGetWidth(self.bounds)/2 && newSliderCenter < CGRectGetWidth(self.containerView.bounds) - CGRectGetWidth(self.bounds)/2) {
        [self.contentV setContentOffset:CGPointMake(newSliderCenter-CGRectGetWidth(self.bounds)/2, 0) animated:YES];
    }else if (newSliderCenter > CGRectGetWidth(self.containerView.bounds) - CGRectGetWidth(self.bounds)/2){
        [self.contentV setContentOffset:CGPointMake(self.contentV.contentSize.width-CGRectGetWidth(self.bounds), 0) animated:YES];
    }else if(newSliderCenter < CGRectGetWidth(self.bounds)/2){
        [self.contentV setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}

#pragma mark - UIScrollViewDelegate

#pragma mark - accessors

- (void)sethideSlider:(BOOL)hideSlider {
    _hideSlider = hideSlider;
    UIView *slider = [self.containerView viewWithTag:10086];
    [slider setHidden:hideSlider];
}

- (void)setTitles:(NSMutableArray<NSString *> *)titles {
    for (UIView *view in self.containerView.subviews) {
        [view removeFromSuperview];
    }
    self.originCenterYTopConstraint = nil;
    
    if ([titles isEqualToArray:_titles] && titles.count > 0) {
        return;
    }
    _titles = titles;
    
    _badgeNums = [NSMutableArray array];
    for (int i = 0; i < titles.count; i ++) {
        [_badgeNums addObject:@(0)];
    }
    
    for (UIView *subView in self.containerView.subviews) {
        [subView removeFromSuperview];
    }
    
    _currentIndex = 0;
    
    [self addButtons:_titles];
    
    if (_titles.count > 1&&!self.hideSlider) {
        [self addSlider];
    }
}

- (void)setBadgeNums:(NSMutableArray *)badgeNums {
        if (badgeNums.count <= self.titles.count) {
            if (badgeNums.count > 0) {
                for (int i = 0; i < self.titles.count;  i ++) {
                    _badgeNums[i] = badgeNums[i];
                }
            }
        }
        
        for (int i = 0; i < self.badges.count; i ++) {
            UILabel *badge = ((UILabel *)self.badges[i]);
            NSNumber *num = self.badgeNums[i];
            NSString *badgeStr = [NSString stringWithFormat:@"%d",num.integerValue];
            NSInteger badgeNum = badgeStr.intValue;
            if (badgeNum > 0) {
                badge.hidden = NO;
                badge.text = badgeStr;
            }else{
                badge.hidden = YES;
            }
        }
//    }
}

- (UIScrollView *)contentV {
    if (!_contentV) {
        _contentV = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _contentV.showsHorizontalScrollIndicator = NO;
        _contentV.delegate = self;
        [_contentV addSubview:self.containerView];
        _contentV.clipsToBounds = YES;
    }
    return _contentV;
}


- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _containerView;
}

- (void)setFixedSpacing:(CGFloat)fixedSpacing {
    _fixedSpacing = fixedSpacing;
    if (self.buttons.count > 0) {
        [self makeButtonsConstraints];
    }
}

- (void)setTrailSpacing:(CGFloat)trailSpacing {
    _trailSpacing = trailSpacing;
    if (self.buttons.count > 0) {
        [self makeButtonsConstraints];
    }
}

- (void)setLeadSpacing:(CGFloat)leadSpacing {
    _leadSpacing = leadSpacing;
    if (self.buttons.count > 0) {
        [self makeButtonsConstraints];
    }
}

- (void)setTopSpacing:(CGFloat)topSpacing {
    _topSpacing = topSpacing;
    if (self.buttons.count > 0) {
        [self makeButtonsConstraints];
    }
}

- (void)setBottomSpacing:(CGFloat)bottomSpacing {
    _bottomSpacing = bottomSpacing;
    if (self.buttons.count > 0) {
        [self makeButtonsConstraints];
    }
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    if (self.buttons.count > 0) {
        for (int i = 0; i < self.buttons.count; i ++) {
            UIButton *button = self.buttons[i];
            if (i != self.currentIndex) {
                [button setTitleColor:_titleColor forState:(UIControlStateNormal)];
            }
        }
    }
}

- (void)setSelectedTitleColor:(UIColor *)selectedTitleColor {
    _selectedTitleColor = selectedTitleColor;
    if (self.buttons.count > 0) {
        for (int i = 0; i < self.buttons.count; i ++) {
            UIButton *button = self.buttons[i];
            if (i == self.currentIndex) {
                [button setTitleColor:selectedTitleColor forState:(UIControlStateNormal)];
                break;
            }
        }
    }
}

- (void)setSliderColor:(UIColor *)sliderColor {
    _sliderColor = sliderColor;
    UIView *slide = [self.containerView viewWithTag:10086];
    if (slide) {
        slide.backgroundColor = sliderColor;
    }
}

- (void)setTitleFont:(UIFont *)titleFont {
    _titleFont = titleFont;
    if (self.buttons.count > 0) {
        for (UIButton *button in self.buttons) {
            button.titleLabel.font = titleFont;
        }
        [self makeButtonsConstraints];
    }
}

- (void)setSelectedTitleFont:(UIFont *)selectedTitleFont {
    _selectedTitleFont = selectedTitleFont;
    if (self.buttons.count > 0) {
        if (!self.titleFont) {
            UIFont *font = [UIFont fontWithName:@"PingFangSC-Regular" size:17];
            for (UIButton *button in self.buttons) {
                button.titleLabel.font = font;
            }
        }
        [self makeButtonsConstraints];
    }
}

@end
