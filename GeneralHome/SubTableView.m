//
//  SubTableView.m
//  GeneralHome
//
//  Created by Guanglei Cheng on 2022/8/8.
//

#import "SubTableView.h"
#import "FangMianCustomerTableView.h"

@implementation SubTableView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if (![otherGestureRecognizer.view isKindOfClass:[FangMianCustomerTableView class]]) {
        return NO;
    }
    return YES;
}

@end
