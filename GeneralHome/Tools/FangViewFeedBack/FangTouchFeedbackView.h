//
//  FangTouchFeedbackView.h
//  SouFun
//
//  Created by Guanglei Cheng on 2019/11/30.
//  Copyright © 2019 房天下 Fang.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger,FangFeedbackViewEventType) {
     FangFeedbackViewEventTypeBegan = 10,
     FangFeedbackViewEventTypeMoved,
     FangFeedbackViewEventTypeEnded,
     FangFeedbackViewEventTypeCancelled
};

typedef void(^ FangFeedbackViewTouchBeganHandler)(UIView * _Nullable  view, CGPoint touchPoint);
typedef void(^ FangFeedbackViewTouchEndedHandler)(UIView * _Nullable  view, CGPoint touchPoint);
typedef void(^ FangFeedbackViewTouchMovedHandler)(UIView * _Nullable  view, CGPoint touchPoint);
typedef void(^ FangFeedbackViewTouchCancelleddHandler)(UIView * _Nullable  view, CGPoint touchPoint);

@interface FangTouchFeedbackView : UIView

/** 手指离开view时的事件回调,通常只需在这一个回调中处理点击事件即可.
    默认是本view对点击作出反馈
    参数:view 当subViewTouchFeedback设置为YES时,view表示具体的接收点击的子view.当subViewTouchFeedback设置为NO时,view表示本view.
        touchPoint:触摸位置,相对于window的坐标系统中.
 */
@property (nonatomic, strong)  FangFeedbackViewTouchEndedHandler feedbackViewTouchEndedHandler;

/** 其他事件的回调 */
@property (nonatomic, strong)  FangFeedbackViewTouchBeganHandler feedbackViewTouchBeganHandler;
@property (nonatomic, strong)  FangFeedbackViewTouchMovedHandler feedbackViewTouchMovedHandler;
@property (nonatomic, strong)  FangFeedbackViewTouchCancelleddHandler feedbackViewTouchCancelleddHandler;

/** 是否子视图响应而不是本view对点击作出点击反馈.默认NO,本view作出点击反馈,而子视图不会作出点击反馈.当设置为YES时,点击子视图时,子视图作出点击反馈,本view不反馈.如果需要根据子视图处理相应事件,需要在回调中判断touchPoint是否在相应子视图的frame之内. */
@property (nonatomic, assign) BOOL subViewTouchFeedback;

/** 点击后按钮缩小过程的动画时长.默认为0.25.按钮恢复的动画时长为(duration-0.03)s */
@property (nonatomic, assign) CGFloat scaleDuration;

@end

NS_ASSUME_NONNULL_END
