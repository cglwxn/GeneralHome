//
//  UIImage+FangImage.m
//  SouFun
//
//  Created by 邱 育良 on 16/7/4.
//
//

#import "UIImage+FangImage.h"

@implementation UIImage (FangImage)

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
    
}

+ (UIImage *)captureFromView:(UIView *)view {
    
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}
//尺寸压缩(宽)
+ (UIImage *)compressImage:(UIImage *)sourceImage toTargetWidth:(CGFloat)targetWidth {
    CGSize imageSize = sourceImage.size;//图片的尺寸(以pt计)
    
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
    CGFloat targetHeight = (targetWidth / width) * height;//维持原来的宽高比的前提下,新的目标高度
    
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    [sourceImage drawInRect:CGRectMake(0, 0, targetWidth, targetHeight)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

//尺寸压缩(高)
+ (UIImage *)compressImage:(UIImage *)sourceImage toTargetHeight:(CGFloat)targetHeight {
    CGSize imageSize = sourceImage.size;//图片的尺寸(以pt计)
    
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
    CGFloat targetWidth = (targetHeight / height) * width;//维持原来的宽高比的前提下,新的目标宽度
    
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    [sourceImage drawInRect:CGRectMake(0, 0, targetWidth, targetHeight)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (UIImage *)compressImage:(UIImage *)image toMaxFileSize:(NSInteger)maxFileSize {
    CGFloat compression = 1.0f;
    CGFloat maxCompression = 0.1f;
    NSData *imageData = UIImageJPEGRepresentation(image, compression);
    NSLog(@"未压缩体积：%dk", [imageData length]/1024);
    while ([imageData length] > maxFileSize && compression > maxCompression) {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(image, compression);
    }
    NSLog(@"压缩后体积：%dk", [imageData length]/1024);
    UIImage *compressedImage = [UIImage imageWithData:imageData];
    return compressedImage;
}


//调整方向
+ (UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)//默认是向上的,如果向上,不作处理
        return aImage;
    
    /*通过调整图片的transformation
     1.如果方错误,转换方向
     2.如果有镜像,翻转
     */
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown://朝下
        case UIImageOrientationDownMirrored://朝下且镜像
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);//移动
            transform = CGAffineTransformRotate(transform, M_PI);//旋转
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);//缩放
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

//在压缩比0.1以上持续压缩图片,直到图片的byte数<= maxFileSize
//+ (NSData *)compressImageDataFromImage:(UIImage *)image toMaxFileSize:(NSInteger)maxFileSize {
//    CGFloat compression = 1.0f;
//    CGFloat maxCompression = 0.1f;
//    NSData *imageData = UIImageJPEGRepresentation(image, compression);
//    SouFunUserBasicInfo *userInfo = [SouFunUserBasicInfo sharedSouFunUserBasicInfo];
//    if (![userInfo.isOpenImgCompress isEqualToString:@"true"]) {
//        while ([imageData length] > maxFileSize && compression > maxCompression) {
//            compression -= 0.1;
//            imageData = UIImageJPEGRepresentation(image, compression);
//        }
//    }
//    return imageData;
//}

+ (UIImage *)compressImage:(UIImage *)image toByte:(NSUInteger)maxLength {
    // Compress by quality(质量压缩)
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);//未压缩  注意:如果已清除图像对象的基础图像数据，则调用此函数会强制将该数据重新加载到内存中。
    if (data.length < maxLength) return image;//length:The number of bytes contained by the data object. 本身就小于maxLength的话,返回
    
    /* data.length >= maxLength  需要压缩*/
    //压缩初始最大 最小阈值
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {//why 6?
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, compression);//取两个极端阈值的中间值作为压缩率  (这个算法是否可以优化???)
        if (data.length < maxLength * 0.9) {
            min = compression;//压缩过度,提高min
        } else if (data.length > maxLength) {
            max = compression;//压缩不足,减小max
        } else {// data >= 0.9*maxLength && data <= maxLength
            break;
        }
    }
    
    //获取到压缩率为(0.9~1)*maxLength之间质量的图像 或者 6次压缩完毕但是仍然>maxLength
    //1.如果当前的length < maxLength
    UIImage *resultImage = [UIImage imageWithData:data];
    if (data.length < maxLength) return resultImage;
    
    
    //当上述以质量压缩完后,data.length仍然>maxLength的话
    // Compress by size
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;//lastDataLength保存上次数据长度
        CGFloat ratio = (CGFloat)maxLength / data.length;//(算法是否可以优化?)
        
        //sqrtf 返回参数的平方根。
        //UIImage.size:This value reflects the logical size of the image and takes the image’s current orientation into account. Multiply the size values by the value in the scale property to get the pixel dimensions of the image. 以point计的UIImage的尺寸,如果想获得UIImage的像素尺寸,size*scale
        //下面生成的size是把UIImage的图像的宽高缩小了开三次方ratio倍
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        
        
        //将UIImage绘制到上面生成的size大小的区域(size是以point计的)
        //即缩小绘制区域 ---> 这样会缩小data的大小吗?
        UIGraphicsBeginImageContext(size);
        
        /*
         drawInRect:
         Draws the entire image in the specified rectangle, scaling it as needed to fit.
         
         This method draws the entire image in the current graphics context, respecting the image’s orientation setting. In the default coordinate system, images are situated down and to the right of the origin of the specified rectangle. This method respects any transforms applied to the current graphics context, however.
         
         This method draws the image at full opacity using the kCGBlendModeNormal blend mode.
         */
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        data = UIImageJPEGRepresentation(resultImage, compression);
    }
    
    return resultImage;
}

// 压缩图片分辨率(因为data压缩到一定程度后，如果图片分辨率不缩小的话还是不行)
+ (UIImage *)returnNewImageWithData:(NSData *)data {
    UIImage *image = [UIImage imageWithData:data];
    CGSize newSize = CGSizeMake(200, 200);
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,(NSInteger)newSize.width, (NSInteger)newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;//绘制在200x200区域(point计算)生成新的image
}

@end

@implementation UIImage (Gradient)

//横向绘制梯度颜色生成图片
+ (UIImage *)gradientImageFromColors:(NSArray*)colors imageSize:(CGSize)imageSize {
    NSMutableArray *ar = [NSMutableArray array];
    for(UIColor *c in colors) {
        [ar addObject:(id)c.CGColor];
    }
    UIGraphicsBeginImageContextWithOptions(imageSize, YES, 1);//设置绘制图像上下文环境
    
    /*
     获取bitmap 上下文  The current graphics context is nil by default. Prior to calling its drawRect: method, view objects push a valid context onto the stack, making it current. If you are not using a UIView object to do your drawing, however, you must push a valid context onto the stack manually using the UIGraphicsPushContext function.
     
     This function may be called from any thread of your app.
     */
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);//Pushes a copy of the current graphics state onto the graphics state stack for the context.
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    CGPoint start = CGPointMake(0.0, 0.0);
    CGPoint end = CGPointMake(imageSize.width, 0.0);
    
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
}

@end
