//
//  FangTouchFeedbackView.m
//  SouFun
//
//  Created by Guanglei Cheng on 2019/11/30.
//  Copyright © 2019 房天下 Fang.com. All rights reserved.
//

#import "FangTouchFeedbackView.h"

@interface FangTouchFeedbackView ()<CAAnimationDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, assign) BOOL isFirstTouchMoved;
@property (nonatomic, assign) CGPoint touchedEndedPoint;
@property (nonatomic, strong) UIView *touchedView;

@end

@implementation FangTouchFeedbackView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (touches.allObjects.count > 0) {
        UITouch *touch = touches.allObjects[0];
        if (self.subViewTouchFeedback == YES && touch.view == self) {
            return [super touchesBegan:touches withEvent:event];
        }
        UIWindow *window = [UIApplication sharedApplication].delegate.window;
        CGPoint p = [touch locationInView:window];
        UIView *responseView = self.subViewTouchFeedback == YES? touch.view:self;
        [self judgeBackView:responseView eventType:(FangFeedbackViewEventTypeBegan)];
        if (self.feedbackViewTouchBeganHandler) {
            self.feedbackViewTouchBeganHandler(responseView,p);
        }
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (touches.allObjects.count > 0) {
        UITouch *touch = touches.allObjects[0];
        if (self.subViewTouchFeedback == YES && touch.view == self) {
            return [super touchesBegan:touches withEvent:event];
        }
        UIWindow *window = [UIApplication sharedApplication].delegate.window;
        self.touchedEndedPoint = [touch locationInView:window];
        self.touchedView = touch.view;
        UIView *responseView = self.subViewTouchFeedback == YES? self.touchedView:self;
        [self judgeBackView:responseView eventType:(FangFeedbackViewEventTypeEnded)];
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (touches.allObjects.count > 0) {
        UITouch *touch = touches.allObjects[0];
        if (self.subViewTouchFeedback == YES && touch.view == self) {
            return [super touchesBegan:touches withEvent:event];
        }
        UIWindow *window = [UIApplication sharedApplication].delegate.window;
        CGPoint p = [touch locationInView:window];
        UIView *responseView = self.subViewTouchFeedback == YES? touch.view:self;
        [self judgeBackView:responseView eventType:(FangFeedbackViewEventTypeMoved)];
        if (self.feedbackViewTouchMovedHandler) {
            self.feedbackViewTouchMovedHandler(responseView, p);
        }
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (touches.allObjects.count > 0) {
        UITouch *touch = touches.allObjects[0];
        if (self.subViewTouchFeedback == YES && touch.view == self) {
            return [super touchesBegan:touches withEvent:event];
        }
        UIWindow *window = [UIApplication sharedApplication].delegate.window;
        CGPoint p = [touch locationInView:window];
        UIView *responseView = self.subViewTouchFeedback == YES? touch.view:self;
        [self judgeBackView:responseView eventType:(FangFeedbackViewEventTypeCancelled)];
        if (self.feedbackViewTouchCancelleddHandler) {
            self.feedbackViewTouchCancelleddHandler(responseView, p);
        }
    }
}


- (void)judgeBackView:(UIView *)view eventType:(FangFeedbackViewEventType)eventType {
    switch (eventType) {
        case FangFeedbackViewEventTypeBegan:
        {
            [self startBackViweAnimation:view eventType:eventType];
        }
            break;
        case FangFeedbackViewEventTypeMoved:
        {
            if (self.isFirstTouchMoved == YES) {
            self.isFirstTouchMoved = NO;
            }
        }
            break;
        case FangFeedbackViewEventTypeEnded:
        {
//            if (view.layer.presentationLayer.transform.m11 < 1) {
//                [self resetBackViewAnimation:view eventType:eventType];
//            }
            [self resetBackViewAnimation:view eventType:eventType];
        }
            break;
        case FangFeedbackViewEventTypeCancelled:
        {
            if (view.layer.presentationLayer.transform.m11 < 1) {
                [self resetBackViewAnimation:view eventType:eventType];
            }
        }
            break;
        default:
            break;
    }
}

- (void)startBackViweAnimation:(UIView *)view eventType:(FangFeedbackViewEventType)eventType {
    self.isFirstTouchMoved = YES;
    CAMediaTimingFunction *timeFx = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    CABasicAnimation *anix  = [CABasicAnimation animationWithKeyPath:@"transform.scale.x"];
    if (self.scaleDuration > 0.03) {
        anix.duration = self.scaleDuration;
    }else{
        anix.duration = 0.25;
    }
    anix.timingFunction = timeFx;
    anix.fromValue = @(view.layer.presentationLayer.transform.m11);
    anix.toValue = @(0.955);
    [view.layer addAnimation:anix forKey:@"transform.scale.x"];
    
    CABasicAnimation *aniy  = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
    if (self.scaleDuration > 0.03) {
        anix.duration = self.scaleDuration;
    }else{
        anix.duration = 0.25;
    }
    CAMediaTimingFunction *timeFy = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];

    aniy.timingFunction = timeFy;
    
    aniy.fromValue = @(view.layer.presentationLayer.transform.m11);
    aniy.toValue = @(0.955);
    [view.layer addAnimation:aniy forKey:@"transform.scale.y"];
    view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.955, 0.955);
}

- (void)resetBackViewAnimation:(UIView *)view eventType:(FangFeedbackViewEventType)eventType {
    CAMediaTimingFunction *timex = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    CAMediaTimingFunction *timey = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [view.layer removeAnimationForKey:@"transform.scale.x"];
    [view.layer removeAnimationForKey:@"transform.scale.y"];
    CABasicAnimation *anix  = [CABasicAnimation animationWithKeyPath:@"transform.scale.x"];
    if (eventType == FangFeedbackViewEventTypeEnded) {
        anix.delegate = self;
    }
    if (self.scaleDuration > 0.03) {
        anix.duration = self.scaleDuration-0.03;
    }else{
        anix.duration = 0.22;
    }
    anix.timingFunction = timex;
    anix.fromValue = @(view.layer.presentationLayer.transform.m11);
    anix.toValue = @(1);
    [view.layer addAnimation:anix forKey:@"transform.scale.x"];

    CABasicAnimation *aniy  = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
    if (self.scaleDuration > 0.03) {
        anix.duration = self.scaleDuration-0.03;
    }else{
        anix.duration = 0.22;
    }
    aniy.timingFunction = timey;
    aniy.fromValue = @(view.layer.presentationLayer.transform.m11);
    aniy.toValue = @(1);
    [view.layer addAnimation:aniy forKey:@"transform.scale.y"];
    view.layer.transform = CATransform3DIdentity;
}

#pragma mark - CAAnimationDelegate

- (void)animationDidStart:(CAAnimation *)anim {
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.feedbackViewTouchEndedHandler) {
            if (@available(iOS 10.0, *)) {
                [self feedbackGenerator:UIImpactFeedbackStyleLight];
            }
            UIView *responseView = self.subViewTouchFeedback == YES? self.touchedView:self;
            self.feedbackViewTouchEndedHandler(responseView,self.touchedEndedPoint);
        }
    });
}

#pragma mark - ImpactFeedbackGenerator

- (void)feedbackGenerator:(UIImpactFeedbackStyle)feedbackStyle {
    UIImpactFeedbackGenerator *generator = [[UIImpactFeedbackGenerator alloc] initWithStyle:feedbackStyle];
    [generator prepare];
    [generator impactOccurred];
}

@end
