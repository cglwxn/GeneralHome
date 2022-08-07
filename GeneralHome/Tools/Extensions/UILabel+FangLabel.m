//
//  UILabel+FangLabel.m
//  FangTableViewDemo
//
//  Created by 邱育良 on 16/6/4.
//  Copyright © 2016年 www.fang.com. All rights reserved.
//

#import "UILabel+FangLabel.h"
#import "FangCommonDefines.h"

@implementation UILabel (FangLabel)

+ (UILabel *)labelWithFrame:(CGRect)frame
                       text:(NSString *)text
                 fontOfSize:(CGFloat)fontSize
                  textColor:(UIColor *)textColor
              textAlignment:(NSTextAlignment)textAlignment
{
    return [UILabel labelWithFrame:frame text:text font:UIFontMake(fontSize) textColor:textColor textAlignment:textAlignment];
}

+ (UILabel *)labelWithFrame:(CGRect)frame
                       text:(NSString *)text
                       font:(UIFont *)font
                  textColor:(UIColor *)textColor
              textAlignment:(NSTextAlignment)textAlignment
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.text = text;
    label.font = font;
    label.textColor = textColor;
    label.textAlignment = textAlignment;
    return label;
}

+ (UILabel *)labelWithFrame:(CGRect)frame
                       text:(NSString *)text
                       font:(UIFont *)font
                  textColor:(UIColor *)textColor
            backgroundColor:(UIColor *)backgroundColor
              textAlignment:(NSTextAlignment)textAlignment
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = backgroundColor;
    label.text = text;
    label.font = font;
    label.textColor = textColor;
    label.textAlignment = textAlignment;
    return label;
}

@end
