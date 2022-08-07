//
//  UIColor+FangColor.h
//  FangTableViewDemo
//
//  Created by 邱育良 on 16/6/4.
//  Copyright © 2016年 www.fang.com. All rights reserved.
//  功用：设计标准提供的几种搜房帮APP标准配色
//  版本：5.9.1，根据《搜房帮设计规范2.0》调整了相关配色
//  维护人：孟飞

#import <UIKit/UIKit.h>

@interface UIColor (FangColor)

+ (UIColor*)light:(UIColor*)light dark:(UIColor*)dark;
+ (UIColor*)defaultBGColor;

#define kFColor_FFFFFF UIColorMake(0xFFFFFF)
#define kFColor_17171A UIColorMake(0x17171A)
#define kFColor_E2E3EC UIColorMake(0xE2E3EC)
#define kFColor_989DA6 UIColorMake(0x989DA6)
#define kFColor_828892 UIColorMake(0x828892)
#define kFColor_686C74 UIColorMake(0x686C74)
#define kFColor_3E4044 UIColorMake(0x3E4044)
#define kFColor_0E131A UIColorMake(0x0E131A)
#define kFColor_363E48 UIColorMake(0x363E48)
#define kFColor_83868F UIColorMake(0x83868F)
#define kFColor_5F626A UIColorMake(0x5F626A)
#define kFColor_252529 UIColorMake(0x252529)
#define kFColor_E5E5E5 UIColorMake(0xE5E5E5)
#define kFColor_0E0E10 UIColorMake(0x0E0E10)
#define kFColor_596062 UIColorMake(0x596062)
#define kFColor_8D9496 UIColorMake(0x8D9496)
#define kFColor_007AFF UIColorMake(0x007AFF)
#define kFColor_0875E7 UIColorMake(0x0875E7)
#define kFColor_8E9395 UIColorMake(0x8E9395)
#define kFColor_A4A7A9 UIColorMake(0xA4A7A9)
#define kFColor_394043 UIColorMake(0x394043)
#define kFColor_BDC3C4 UIColorMake(0xBDC3C4)
#define kFColor_DFE3E4 UIColorMake(0xDFE3E4)
#define kFColor_3295F6 UIColorMake(0x3295F6)
#define kFColor_F7A32C UIColorMake(0xF7A32C)
#define kFColor_FAF9F9 UIColorMake(0xFAF9F9)
#define kFColor_EEEEEE UIColorMake(0xEEEEEE)
#define kFColor_83BDFC UIColorMake(0x83BDFC)
#define kFColor_04468E UIColorMake(0x04468E)
#define kFColor_333333 UIColorMake(0x333333)
#define kFColor_F5F5F5 UIColorMake(0xF5F5F5)
#define kFColor_0F0F0F UIColorMake(0x0F0F0F)
#define kFColor_0F161E UIColorMake(0x0F161E)
#define kFColor_C0C0C0 UIColorMake(0xC0C0C0)
#define kFColor_F7F7F7 UIColorMake(0xF7F7F7)
#define kFColor_202223 UIColorMake(0x202223)
#define kFColor_0072EA UIColorMake(0x0072EA)
#define kFColor_FD3254 UIColorMake(0xFD3254)
#define kFColor_FF3A30 UIColorMake(0xFF3A30)
#define kFColor_2C2C30 UIColorMake(0x2C2C30)
#define kFColor_131315 UIColorMake(0x131315)
#define kFColor_8B9099 UIColorMake(0x8B9099)
#define kFColor_8E8E93 UIColorMake(0x8E8E93)
#define kFColor_FAFAFA UIColorMake(0xFAFAFA)
#define kFColor_F6FBFF UIColorMake(0xF6FBFF)
#define kFColor_008AFF UIColorMake(0x008AFF)
#define kFColor_2F91F9 UIColorMake(0x2F91F9)
#define kFColor_C4C9CA UIColorMake(0xC4C9CA)
#define kFColor_DF3031 UIColorMake(0xDF3031)
#define kFColor_7D9CB2 UIColorMake(0x7D9CB2)
#define kFColor_999D9E UIColorMake(0x999D9E)
#define kFColor_C4C4C4 UIColorMake(0xC4C4C4)
#define kFColor_999999 UIColorMake(0x999999)
#define kFColor_FF3F33 UIColorMake(0xFF3F33)
#define kFColor_F3F3F3 UIColorMake(0xF3F3F3)
#define kFColor_F9F9F9 UIColorMake(0xF9F9F9)
#define kFColor_000000 UIColorMake(0x000000)
#define kFColor_F6F6F6 UIColorMake(0xF6F6F6)
#define kFColor_FFF6F0 UIColorMake(0xFFF6F0)
#define kFColor_525252 UIColorMake(0x525252)
#define kFColor_82BDFC UIColorMake(0x82BDFC)
#define kFColor_212125 UIColorMake(0x212125)
#define kFColor_DDDEE7 UIColorMake(0xDDDEE7)
#define kFColor_92979F UIColorMake(0x92979F)
#define kFColor_E8E8E8 UIColorMake(0xE8E8E8)
#define kFColor_F0F0F0 UIColorMake(0xF0F0F0)
#define kFColor_EEEDED UIColorMake(0xEEEDED)
#define kFColor_2E2E33 UIColorMake(0x2E2E33)
#define kFColor_C8CDDB UIColorMake(0xC8CDDB)
#define kFColor_222831 UIColorMake(0x222831)
#define kFColor_EBECF1 UIColorMake(0xEBECF1)
#define kFColor_96989C UIColorMake(0x96989C)
#define kFColor_707070 UIColorMake(0x707070)
#define kFColor_2F3034 UIColorMake(0x2F3034)
#define kFColor_70B1F8 UIColorMake(0x70B1F8)
#define kFColor_EFF7FF UIColorMake(0xEFF7FF)
#define kFColor_2E3644 UIColorMake(0x2E3644)
#define kFColor_3D3D44 UIColorMake(0x3D3D44)
#define kFColor_F1F0F7 UIColorMake(0xF1F0F7)
#define kFColor_879DB1 UIColorMake(0x879DB1)
#define kFColor_818489 UIColorMake(0x818489)
#define kFColor_BCBDC4 UIColorMake(0xBCBDC4)
#define kFColor_FF6666 UIColorMake(0xFF6666)
#define kFColor_F6F5FA UIColorMake(0xF6F5FA)
#define kFColor_E6F2FF UIColorMake(0xE6F2FF)
#define kFColor_5C5C5C UIColorMake(0x5C5C5C)
#define kFColor_6A6A6A UIColorMake(0x6A6A6A)
#define kFColor_F2F2F2 UIColorMake(0xF2F2F2)
#define kFColor_AC8D4D UIColorMake(0xAC8D4D)
#define kFColor_CBA77E UIColorMake(0xCBA77E)
#define kFColor_4F433B UIColorMake(0x4F433B)
#define kFColor_FFF5E5 UIColorMake(0xFFF5E5)
#define kFColor_CCCCCC UIColorMake(0xCCCCCC)
#define kFColor_7081A0 UIColorMake(0x7081A0)
#define kFColor_2A2A2E UIColorMake(0x2A2A2E)
#define kFColor_EDEDEE UIColorMake(0xEDEDEE)
#define kFColor_0D72FF UIColorMake(0x0D72FF)
#define kFColor_19191B UIColorMake(0x19191B)
#define kFColor_869DB2 UIColorMake(0x869DB2)
#define kFColor_7A7D82 UIColorMake(0x7A7D82)
#define kFColor_CBCECB UIColorMake(0xCBCECB)
#define kFColor_A0A7AA UIColorMake(0xA0A7AA)
#define kFColor_757575 UIColorMake(0x757575)
#define kFColor_E8372D UIColorMake(0xE8372D)
#define kFColor_959595 UIColorMake(0x959595)
#define kFColor_5D6168 UIColorMake(0x5D6168)
#define kFColor_707783 UIColorMake(0x707783)
#define kFColor_243248 UIColorMake(0x243248)
#define kFColor_DDDDDD UIColorMake(0xDDDDDD)
#define kFColor_47648F UIColorMake(0x47648F)
#define kFColor_1C1C1E UIColorMake(0x1C1C1E)
#define kFColor_8C929E UIColorMake(0x8C929E)
#define kFColor_212124 UIColorMake(0x212124)
#define kFColor_F8F8F8 UIColorMake(0xF8F8F8)
#define kFColor_DEDEDE UIColorMake(0xDEDEDE)
#define kFColor_D6D6D6 UIColorMake(0xD6D6D6)
#define kFColor_C2C2C2 UIColorMake(0xC2C2C2)
#define kFColor_DEE1E2 UIColorMake(0xDEE1E2)
#define kFColor_0774E5 UIColorMake(0x0774E5)
#define kFColor_228CE2 UIColorMake(0x228CE2)
#define kFColor_EEF6FF UIColorMake(0xEEF6FF)
#define kFColor_FA932D UIColorMake(0xFA932D)
#define kFColor_F9B42C UIColorMake(0xF9B42C)
#define kFColor_3F454F UIColorMake(0x3F454F)
#define kFColor_989898 UIColorMake(0x989898)
#define kFColor_E6F2FF UIColorMake(0xE6F2FF)
#define kFColor_507DAF UIColorMake(0x507DAF)
#define kFColor_E0E0E0 UIColorMake(0xE0E0E0)
#define kFColor_666666 UIColorMake(0x666666)
#define kFColor_6BADF1 UIColorMake(0x6BADF1)
#define kFColor_2B3133 UIColorMake(0x2B3133)
#define kFColor_7A8284 UIColorMake(0x7A8284)
#define kFColor_F0F3FA UIColorMake(0xF0F3FA)
#define kFColor_E1E6EB UIColorMake(0xE1E6EB)
#define kFColor_EAF3FA UIColorMake(0xEAF3FA)
#define kFColor_9D9FA4 UIColorMake(0x9D9FA4)
#define kFColor_F91543 UIColorMake(0xF91543)
#define kFColor_b2b2b2 UIColorMake(0xb2b2b2)
#define kFColor_D8D8D8 UIColorMake(0xD8D8D8)
#define kFColor_3c3f46 UIColorMake(0x3c3f46)
#define kFColor_FE0E0E UIColorMake(0xFE0E0E)
#define kFColor_A1A3A5 UIColorMake(0xA1A3A5)
#define kFColor_4FA4FC UIColorMake(0x4FA4FC)
#define kFColor_F0F9FF UIColorMake(0xF0F9FF)
#define kFColor_222222 UIColorMake(0x222222)
#define kFColor_EFF8FF UIColorMake(0xEFF8FF)
#define kFColor_FCF4F0 UIColorMake(0xFCF4F0)
#define kFColor_F8FCFF UIColorMake(0xF8FCFF)
#define kFColor_FFF1F1 UIColorMake(0xFFF1F1)
#define kFColor_FFB354 UIColorMake(0xFFB354)
#define kFColor_888888 UIColorMake(0x888888)
#define kFColor_999999 UIColorMake(0x999999)
#define kFColor_999999 UIColorMake(0x999999)
#define kFColor_999999 UIColorMake(0x999999)
#define kFColor_999999 UIColorMake(0x999999)
#define kFColor_999999 UIColorMake(0x999999)
#define kFColor_EEEEF0 UIColorMake(0xEEEEF0)
#define kFColor_F7F8F9 UIColorMake(0xF7F8F9)
#define kFColor_22292B UIColorMake(0x22292B)
#define kFColor_D2D2D2 UIColorMake(0xD2D2D2)
#define kFColor_BABABA UIColorMake(0xBABABA)
#define kFColor_FBF3E8 UIColorMake(0xFBF3E8)
#define kFColor_D0D0D0 UIColorMake(0xD0D0D0)
#define kFColor_999999 UIColorMake(0x999999)
#define kFColor_999999 UIColorMake(0x999999)
#define kFColor_999999 UIColorMake(0x999999)
#define kFColor_297EFF UIColorMake(0x297EFF)
#define kFColor_999999 UIColorMake(0x999999)
#define kFColor_b2b2b2 UIColorMake(0xb2b2b2)
#define kFColor_D8D8D8 UIColorMake(0xD8D8D8)
#define kFColor_3c3f46 UIColorMake(0x3c3f46)
#define kFColor_F4F9FF UIColorMake(0xF4F9FF)
#define kFColor_000000 UIColorMake(0x000000)
#define kFColor_000000 UIColorMake(0x000000)
#define kFColor_494B51 UIColorMake(0x494B51)
#define kFColor_2A2B2E UIColorMake(0x2A2B2E)
#define kFColor_2B2620 UIColorMake(0x2B2620)
#define kFColor_FFF9E4 UIColorMake(0xFFF9E4)
#define kFColor_D09E57 UIColorMake(0xD09E57)
#define kFColor_EEF5FF UIColorMake(0xEEF5FF)
#define kFColor_4392FF UIColorMake(0x4392FF)
#define kFColor_444444 UIColorMake(0x444444)
#define kFColor_FEF4E0 UIColorMake(0xFEF4E0)
#define kFColor_FFA22D UIColorMake(0xFFA22D)
#define kFColor_CBA77E UIColorMake(0xCBA77E)
#define kFColor_FFFBEE UIColorMake(0xFFFBEE)
#define kFColor_FFF6F6 UIColorMake(0xFFF6F6)
#define kFColor_FEF4F4 UIColorMake(0xFEF4F4)
#define kFColor_98CAFA UIColorMake(0x98CAFA)
#define kFColor_54575C UIColorMake(0x54575C)
#define kFColor_F8FCFF UIColorMake(0xF8FCFF)
#define kFColor_090F32 UIColorMake(0x090F32)
#define kFColor_FEFEFE UIColorMake(0xFEFEFE)
#define kFColor_D09E57 UIColorMake(0xD09E57)
#define kFColor_AB875B UIColorMake(0xAB875B)
#define kFColor_2F2810 UIColorMake(0x2F2810)
#define kFColor_FCB54E UIColorMake(0xFCB54E)
#define kFColor_FDD9A6 UIColorMake(0xFDD9A6)
#define kFColor_4CD964 UIColorMake(0x4CD964)
#define kFColor_E9F4FF UIColorMake(0xE9F4FF)
#define kFColor_5B9BE3 UIColorMake(0x5B9BE3)
#define kFColor_A27C49 UIColorMake(0xA27C49)
#define kFColor_9d9fa4 UIColorMake(0x9d9fa4)
#define kFColor_F1F1F1 UIColorMake(0xF1F1F1)
#define kFColor_60a5fb UIColorMake(0x60a5fb)
#define kFColor_3296FB UIColorMake(0x3296FB)
#define kFColor_FD675A UIColorMake(0xFD675A)
#define kFColor_F4F8FF UIColorMake(0xF4F8FF)
#define kFColor_FFF7F7 UIColorMake(0xFFF7F7)
#define kFColor_B8DAFC UIColorMake(0xB8DAFC)
#define kFColor_9FA3A4 UIColorMake(0x9FA3A4)
#define kFColor_F45549 UIColorMake(0xF45549)
#define kFColor_696969 UIColorMake(0x696969)
#define kFColor_26A69A UIColorMake(0x26A69A)
#define kFColor_297EFF UIColorMake(0x297EFF)

/** 随机色 */
+ (UIColor *)fangRandomColor;

/** 主体蓝色:0x0875E7 */
+ (UIColor *)fangBlueColor;

/** 主体红色:0xDF3031 */
+ (UIColor *)fangRedColor;

/** 绿色:0x6FCE4E */
+ (UIColor *)fangGreenColor;

/** 黄色:0xF7B23E */
+ (UIColor *)fangYellowColor;

/** 橙色:0xFF8462 */
+ (UIColor *)fangOrangeColor;

/** 主标题黑色:0x333333 */
+ (UIColor *)fangBlackColor;

/** 次要标题深灰色:0x757575 */
+ (UIColor *)fangDarkGrayColor;

/** 说明文字浅灰色:0x999999 */
+ (UIColor *)fangLightGrayColor;

/** 分割线色:0xEEEEEE */
+ (UIColor *)fangLineColor;

/** 主体背景色:0xF2F2F2 */
+ (UIColor *)fangBackgroundColor;

+ (UIColor *)fangCenterGrayColor;

//绘制渐变色颜色的方法
+ (CAGradientLayer *)setGradualChangingColor:(UIView *)view fromColor:(NSString *)fromHexColorStr toColor:(NSString *)toHexColorStr;

@end
