//
//  SubViewController.h
//  GeneralHome
//
//  Created by Guanglei Cheng on 2022/8/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SubViewController : UIViewController<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIViewController* mainVC;
@property (nonatomic, assign) BOOL isMainTableViewCanScroll;
@property (nonatomic, assign) BOOL isListCollectionViewCanScroll;

@end

NS_ASSUME_NONNULL_END
