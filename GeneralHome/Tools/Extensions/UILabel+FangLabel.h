//
//  UILabel+FangLabel.h
//  FangTableViewDemo
//
//  Created by 邱育良 on 16/6/4.
//  Copyright © 2016年 www.fang.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (FangLabel)

/**
 *  自定义UILabel
 *
 *  @param frame        自动布局可以传CGRectZero
 *  @param text         文字内容
 *  @param fontSize     字号
 *  @param textColor    字体颜色
 *  @param textAlignmen 对齐方式
 *
 *  @return 自定义UILabel
 */
+ (UILabel *)labelWithFrame:(CGRect)frame
                       text:(NSString *)text
                 fontOfSize:(CGFloat)fontSize
                  textColor:(UIColor *)textColor
              textAlignment:(NSTextAlignment)textAlignmen;

+ (UILabel *)labelWithFrame:(CGRect)frame
                       text:(NSString *)text
                       font:(UIFont *)font
                  textColor:(UIColor *)textColor
              textAlignment:(NSTextAlignment)textAlignment;

+ (UILabel *)labelWithFrame:(CGRect)frame
                       text:(NSString *)text
                       font:(UIFont *)font
                  textColor:(UIColor *)textColor
            backgroundColor:(UIColor *)backgroundColor
              textAlignment:(NSTextAlignment)textAlignment;


@end
