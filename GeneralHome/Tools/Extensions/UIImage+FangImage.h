//
//  UIImage+FangImage.h
//  SouFun
//
//  Created by 邱 育良 on 16/7/4.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (FangImage)

+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
+ (UIImage *)captureFromView:(UIView *)view;

/**
 *  压缩到某一个宽度
 *
 *  @param sourceImage 原图
 *  @param targetWidth 压缩后的宽度
 *
 *  @return 压缩后的图
 */
+ (UIImage *)compressImage:(UIImage *)sourceImage toTargetWidth:(CGFloat)targetWidth;
+ (UIImage *)compressImage:(UIImage *)sourceImage toTargetHeight:(CGFloat)targetHeight;
/**
 *  压缩到某一个字节内
 *
 *  @param image       原图
 *  @param maxFileSize 最大容量
 *
 *  @return 压缩后的图
 */
+ (UIImage *)compressImage:(UIImage *)image toMaxFileSize:(NSInteger)maxFileSize;

+ (UIImage *)fixOrientation:(UIImage *)aImage;

+ (NSData *)compressImageDataFromImage:(UIImage *)image toMaxFileSize:(NSInteger)maxFileSize;
//微信分享压缩图片
+ (UIImage *)compressImage:(UIImage *)image toByte:(NSUInteger)maxLength;
// 压缩图片分辨率(因为data压缩到一定程度后，如果图片分辨率不缩小的话还是不行)
+ (UIImage *)returnNewImageWithData:(NSData *)data;
@end


@interface UIImage (Gradient)


/**
 从左到右渐变的图片

 @param colors 色值
 @param imageSize 图片大小
 @return 渐变图片
 */
+ (UIImage *)gradientImageFromColors:(NSArray*)colors imageSize:(CGSize)imageSize;

@end
