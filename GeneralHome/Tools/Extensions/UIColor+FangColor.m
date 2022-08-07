//
//  UIColor+FangColor.m
//  FangTableViewDemo
//
//  Created by 邱育良 on 16/6/4.
//  Copyright © 2016年 www.fang.com. All rights reserved.
//  功用：设计标准提供的几种搜房帮APP标准配色
//  版本：5.9.1，根据《搜房帮设计规范2.0》调整了相关配色
//  维护人：孟飞

#import "UIColor+FangColor.h"

@implementation UIColor (FangColor)

+ (UIColor *)fangRandomColor {
    return RGBACOLOR(arc4random_uniform(256), arc4random_uniform(156), arc4random_uniform(256), 1);
}

+ (UIColor *)fangBlueColor {
    return [UIColor light:kFColor_0875E7 dark:kFColor_007AFF];
}

+ (UIColor *)fangRedColor {
    //return UIColorMake(0xFB3C3C);   //1.0
    return UIColorMake(0xDF3031);
}

+ (UIColor *)fangGreenColor {
    //return UIColorMake(0x61cd70);   //1.0
    return UIColorMake(0x6FCE4E);
}

+ (UIColor *)fangYellowColor {
    return UIColorMake(0xF7B23E);
}

+ (UIColor *)fangOrangeColor {
    //return UIColorMake(0xFF8B23);   //1.0
    return UIColorMake(0xFF8462);
}

+ (UIColor *)fangBlackColor {
    return [UIColor light:kFColor_333333 dark:kFColor_E2E3EC];
}

+ (UIColor *)fangDarkGrayColor {
    //return UIColorMake(0x666666);   //1.0
    return UIColorMake(0x757575);
}

+ (UIColor *)fangLightGrayColor {
    return UIColorMake(0x999999);
}

+ (UIColor *)fangLineColor {
    //return UIColorMake(0xDDDDDD);   //1.0
    return [UIColor light:kFColor_EEEEEE dark:kFColor_252529];
}

+ (UIColor *)fangBackgroundColor {
    //return UIColorMake(0xEEEEEE);   //1.0
    return UIColorMake(0xF2F2F2);
}


+ (UIColor *)fangCenterGrayColor{
    return UIColorMake(0x394043);
}

//绘制渐变色颜色的方法
+ (CAGradientLayer *)setGradualChangingColor:(UIView *)view fromColor:(NSString *)fromHexColorStr toColor:(NSString *)toHexColorStr{
    
    //  CAGradientLayer类对其绘制渐变背景颜色、填充层的形状(包括圆角)
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = view.bounds;
    
    //  创建渐变色数组，需要转换为CGColor颜色
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithHex:fromHexColorStr].CGColor,(__bridge id)[UIColor colorWithHex:toHexColorStr].CGColor];
    
    //  设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
    gradientLayer.startPoint = CGPointMake(0.1, 0.95);
    gradientLayer.endPoint = CGPointMake(0.88, 0);
    
    //  设置颜色变化点，取值范围 0.0~1.0
    gradientLayer.locations = @[@0,@1];
    
    return gradientLayer;
}

//获取16进制颜色的方法
+ (UIColor *)colorWithHex:(NSString *)hexColor {
    hexColor = [hexColor stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([hexColor length] < 6) {
        return nil;
    }
    if ([hexColor hasPrefix:@"#"]) {
        hexColor = [hexColor substringFromIndex:1];
    }
    NSRange range;
    range.length = 2;
    range.location = 0;
    NSString *rs = [hexColor substringWithRange:range];
    range.location = 2;
    NSString *gs = [hexColor substringWithRange:range];
    range.location = 4;
    NSString *bs = [hexColor substringWithRange:range];
    unsigned int r, g, b, a;
    [[NSScanner scannerWithString:rs] scanHexInt:&r];
    [[NSScanner scannerWithString:gs] scanHexInt:&g];
    [[NSScanner scannerWithString:bs] scanHexInt:&b];
    if ([hexColor length] == 8) {
        range.location = 4;
        NSString *as = [hexColor substringWithRange:range];
        [[NSScanner scannerWithString:as] scanHexInt:&a];
    } else {
        a = 255;
    }
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:((float)a / 255.0f)];
}

+ (UIColor *)light:(UIColor *)light dark:(UIColor *)dark{
    
    if (@available(iOS 13.0,*)) {
        UIColor *dyColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull trainCollection) {
            if ([trainCollection userInterfaceStyle] == UIUserInterfaceStyleLight) {
                return light;
            }else {
                return dark;
            }
        }];
        return dyColor;
    }
    return light;
}

+ (UIColor *)defaultBGColor{
    return [UIColor light:kFColor_FFFFFF dark:kFColor_17171A];
}

@end
