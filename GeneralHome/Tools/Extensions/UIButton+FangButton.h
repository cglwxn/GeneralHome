//
//  UIButton+FangButton.h
//  SouFun
//
//  Created by 邱 育良 on 16/6/29.
//
//

#import <UIKit/UIKit.h>

@interface UIButton (FangButton)

/**
 *  扩大按钮点击区域
 *
 *  @param enlargeEdgeInsets 内边距，扩大点击区域时均传负值
 */
- (void)setEnlargeEdgeInsets:(UIEdgeInsets)enlargeEdgeInsets;


/**
 交换按钮图片和标题位置(外加间隔)

 @param state state
 @param space 间隔
 */
- (void)judgeButtonTitleAndImage:(UIControlState)state space:(CGFloat)space;

/**
 返回按钮图片和标题总长度
 
 @param state state
 */
- (CGFloat)sumWidthOfButtonTitleAndImg:(UIControlState)state;

@end

@interface UIButton (Gradient)

+ (UIButton *)gradinetButtonFrame:(CGRect)frame title:(NSString *)title;
+ (UIButton *)commonButtonFrame:(CGRect)frame title:(NSString *)title;
@end
