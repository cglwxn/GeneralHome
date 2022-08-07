//
//  FangMianCustomerTableView.m
//  homezxb
//
//  Created by WangPan on 2019/8/12.
//  Copyright © 2019 soufunhome. All rights reserved.
//

#import "FangMianCustomerTableView.h"

@interface FangMianCustomerTableView () <UIGestureRecognizerDelegate>

@end

@implementation FangMianCustomerTableView

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
//    gestureRecognizer.delaysTouchesBegan = NO;
//    return YES;
//}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isKindOfClass:[UIButton class]]) {
        gestureRecognizer.delaysTouchesBegan = YES;
    }else{
        gestureRecognizer.delaysTouchesBegan = NO;
    }
    return YES;
}

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//    BOOL result = YES;
//    if ([gestureRecognizer.view isKindOfClass:[FangMianCustomerTableView class]] && [otherGestureRecognizer.view isKindOfClass:[iCarouselContentView class]]) {
//        result = NO;
//    }
//    return result;
//}



@end
