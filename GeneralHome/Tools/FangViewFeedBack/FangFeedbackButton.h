//
//  FangFeedbackButton.h
//  SouFun
//
//  Created by Guanglei Cheng on 2019/12/3.
//  Copyright © 2019 房天下 Fang.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FangTouchFeedbackView.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, FangFeedbackButtonLayoutDirection) {
    FangFeedbackButtonLayoutDirectionHorizental,
    FangFeedbackButtonLayoutDirectionVertical
};

typedef void(^ FangFeedbackButtonEventHandler)(UIView * _Nullable  view, CGPoint touchPoint);

@interface FangFeedbackButton : FangTouchFeedbackView

- (void)setTitle:(NSString *)title;
- (void)setImage:(UIImage *)image;
- (void)setTtitleColor:(UIColor *)titleColor;

//设置textLabel的font textColor title等属性
@property (nonatomic, strong, readonly) UILabel *textLabel;

/** 点击回调,view为本view, touchPoint为点击区域*/
@property (nonatomic, strong) FangFeedbackButtonEventHandler feedbackButtonEventHandler;

/** 布局方向,默认水平布局 */
@property (nonatomic, assign) FangFeedbackButtonLayoutDirection layoutDirection;

//自定义label和imageView的frame,当下面两个属性都没有被设置时,启用默认布局,类似UIButton,水平布局下,图片在左,label在右,间距为0,或者图片在上label在下,二者的共同体水平垂直居中.垂直布局下,图片在上,label在下,间距为3,二者结合体水平垂直居中.且完全占满整个view.
/** 自定义labelFrame,当仅设置labelFrame而没有设置imgFrame的时,水平布局下,图片在label左边,间距为0,垂直居中.垂直布局下,图片在label上方,间距为3,水平居中. */
@property (nonatomic, assign) CGRect labelFrame;
/** 自定义imgFrame,当仅设置imgFrame而没有设置labelFrame的时,水平布局下,label在图片右边,间距为0,垂直居中.垂直布局下,label在图片下方,间距为3,水平居中. */
@property (nonatomic, assign) CGRect imgFrame;

@end

NS_ASSUME_NONNULL_END
