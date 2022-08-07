//
//  FangFeedbackButton.m
//  SouFun
//
//  Created by Guanglei Cheng on 2019/12/3.
//  Copyright © 2019 房天下 Fang.com. All rights reserved.
//

#import "FangFeedbackButton.h"
#import "UILabel+FangLabel.h"
#import "NSString+Size.h"

@interface FangFeedbackButton ()

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation FangFeedbackButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.contentView];
        self.layoutDirection = FangFeedbackButtonLayoutDirectionHorizental;
        WS(ws)
        self.feedbackViewTouchEndedHandler = ^(UIView * _Nullable view, CGPoint touchPoint) {
            __strong typeof(ws) ss = ws;
            if (ss.feedbackButtonEventHandler) {
                ss.feedbackButtonEventHandler(view,touchPoint);
            }
        };
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setImage:(UIImage *)image {
    if (image == nil) {
        self.imageView.image = [UIImage imageNamed:@""];
    }
    self.imageView.image = image;
    
    CGSize size = self.imageView.image.size;
    CGFloat textLen = [self.textLabel.text sizeWithFont:self.textLabel.font maxSize:CGSizeMake(self.bounds.size.width,self.bounds.size.height)].width;
    if (self.layoutDirection == FangFeedbackButtonLayoutDirectionHorizental) {
        if (!CGRectEqualToRect(self.labelFrame, CGRectZero) && CGRectEqualToRect(self.imgFrame, CGRectZero)) {
            //外界设置了labelFrame属性
            self.contentView.frame = self.bounds;
            self.textLabel.frame = self.labelFrame;
            self.imageView.frame = CGRectMake(CGRectGetMinX(self.labelFrame)-size.width, CGRectGetMidY(self.contentView.bounds)-size.height/2, size.width, size.height);
        }else if (CGRectEqualToRect(self.labelFrame, CGRectZero) && !CGRectEqualToRect(self.imgFrame, CGRectZero)){
            self.contentView.frame = self.bounds;
            self.imageView.frame = self.imgFrame;
            self.textLabel.frame = CGRectMake(CGRectGetMaxX(self.imgFrame), CGRectGetMidY(self.contentView.bounds)-self.textLabel.font.pointSize/2, textLen, self.textLabel.font.pointSize);
        }else if (!CGRectEqualToRect(self.labelFrame, CGRectZero) && !CGRectEqualToRect(self.imgFrame, CGRectZero)){
            self.contentView.frame = self.bounds;
            self.imageView.frame = self.imgFrame;
            self.textLabel.frame = self.labelFrame;
        }else{
            CGFloat contentLen = size.width + textLen;
            CGFloat contentHeight = MAX(size.height, self.textLabel.font.pointSize);
            self.contentView.frame = CGRectMake(0, 0, contentLen, contentHeight);
            CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
            self.contentView.center = center;
            self.imageView.frame = CGRectMake(0, CGRectGetMidY(self.contentView.bounds)-size.height/2, size.width, size.height);
            self.textLabel.frame = CGRectMake(CGRectGetMaxX(self.imageView.frame), CGRectGetMidY(self.contentView.bounds)-self.textLabel.font.pointSize/2, textLen, self.textLabel.font.pointSize);
        }
    }else{
        if (!CGRectEqualToRect(self.labelFrame, CGRectZero) && CGRectEqualToRect(self.imgFrame, CGRectZero)) {
            //外界只设置了labelFrame属性
            self.contentView.frame = self.bounds;
            self.textLabel.frame = self.labelFrame;
            self.imageView.frame = CGRectMake(CGRectGetMinX(self.labelFrame)-size.width, CGRectGetMinY(self.labelFrame)-3-size.height, size.width, size.height);
        }else if (CGRectEqualToRect(self.labelFrame, CGRectZero) && !CGRectEqualToRect(self.imgFrame, CGRectZero)){
            //外界只设置了imgFrame属性
            self.contentView.frame = self.bounds;
            self.imageView.frame = self.imgFrame;
            self.textLabel.frame = CGRectMake(0, CGRectGetMaxY(self.imgFrame)+3, textLen, self.textLabel.font.pointSize);
        }else if (!CGRectEqualToRect(self.labelFrame, CGRectZero) && !CGRectEqualToRect(self.imgFrame, CGRectZero)){
            //外界设置了labelFrame和imgFrame属性
            self.contentView.frame = self.bounds;
            self.imageView.frame = self.imgFrame;
            self.textLabel.frame = self.labelFrame;
        }else{
            //外界没有设置labelFrame和imgFrame属性
            CGFloat contentLen = MAX(size.width, textLen);
            CGFloat contentHeight = size.height + 3 + self.textLabel.font.pointSize;
            self.contentView.frame = CGRectMake(0, 0, contentLen, contentHeight);
            CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
            self.contentView.center = center;
            self.imageView.frame = CGRectMake((CGRectGetWidth(self.contentView.bounds)-size.width)/2, 0, size.width, size.height);
            self.textLabel.frame = CGRectMake(0, size.height+3, CGRectGetWidth(self.contentView.bounds), self.textLabel.font.pointSize);
        }
    }
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:self.bounds];
        [_contentView addSubview:self.imageView];
        [_contentView addSubview:self.textLabel];
    }
    return _contentView;
}

- (void)setTitle:(NSString *)title {
    self.textLabel.text = title;
    
    
    CGSize size = self.imageView.image.size;
    CGFloat textLen = [self.textLabel.text sizeWithFont:self.textLabel.font maxSize:CGSizeMake(self.bounds.size.width,self.bounds.size.height)].width;
    if (self.layoutDirection == FangFeedbackButtonLayoutDirectionHorizental) {
        if (!CGRectEqualToRect(self.labelFrame, CGRectZero) && CGRectEqualToRect(self.imgFrame, CGRectZero)) {
            //外界设置了labelFrame属性
            self.contentView.frame = self.bounds;
            self.textLabel.frame = self.labelFrame;
            self.imageView.frame = CGRectMake(CGRectGetMinX(self.labelFrame)-size.width, CGRectGetMidY(self.contentView.bounds)-size.height/2, size.width, size.height);
        }else if (CGRectEqualToRect(self.labelFrame, CGRectZero) && !CGRectEqualToRect(self.imgFrame, CGRectZero)){
            self.contentView.frame = self.bounds;
            self.imageView.frame = self.imgFrame;
            self.textLabel.frame = CGRectMake(CGRectGetMaxX(self.imgFrame), CGRectGetMidY(self.contentView.bounds)-self.textLabel.font.pointSize/2, textLen, self.textLabel.font.pointSize);
        }else if (!CGRectEqualToRect(self.labelFrame, CGRectZero) && !CGRectEqualToRect(self.imgFrame, CGRectZero)){
            self.contentView.frame = self.bounds;
            self.imageView.frame = self.imgFrame;
            self.textLabel.frame = self.labelFrame;
        }else{
            CGFloat contentLen = size.width + textLen;
            CGFloat contentHeight = MAX(size.height, self.textLabel.font.pointSize);
            self.contentView.frame = CGRectMake(0, 0, contentLen, contentHeight);
            CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
            self.contentView.center = center;
            self.imageView.frame = CGRectMake(0, CGRectGetMidY(self.contentView.bounds)-size.height/2, size.width, size.height);
            self.textLabel.frame = CGRectMake(CGRectGetMaxX(self.imageView.frame), CGRectGetMidY(self.contentView.bounds)-self.textLabel.font.pointSize/2, textLen, self.textLabel.font.pointSize);
        }
    }else{
        if (!CGRectEqualToRect(self.labelFrame, CGRectZero) && CGRectEqualToRect(self.imgFrame, CGRectZero)) {
            //外界只设置了labelFrame属性
            self.contentView.frame = self.bounds;
            self.textLabel.frame = self.labelFrame;
            self.imageView.frame = CGRectMake(CGRectGetMinX(self.labelFrame)-size.width, CGRectGetMinY(self.labelFrame)-3-size.height, size.width, size.height);
        }else if (CGRectEqualToRect(self.labelFrame, CGRectZero) && !CGRectEqualToRect(self.imgFrame, CGRectZero)){
            //外界只设置了imgFrame属性
            self.contentView.frame = self.bounds;
            self.imageView.frame = self.imgFrame;
            self.textLabel.frame = CGRectMake(0, CGRectGetMaxY(self.imgFrame)+3, textLen, self.textLabel.font.pointSize);
        }else if (!CGRectEqualToRect(self.labelFrame, CGRectZero) && !CGRectEqualToRect(self.imgFrame, CGRectZero)){
            //外界设置了labelFrame和imgFrame属性
            self.contentView.frame = self.bounds;
            self.imageView.frame = self.imgFrame;
            self.textLabel.frame = self.labelFrame;
        }else{
            //外界没有设置labelFrame和imgFrame属性
            CGFloat contentLen = MAX(size.width, textLen);
            CGFloat contentHeight = size.height + 3 + self.textLabel.font.pointSize;
            self.contentView.frame = CGRectMake(0, 0, contentLen, contentHeight);
            CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
            self.contentView.center = center;
            self.imageView.frame = CGRectMake((CGRectGetWidth(self.contentView.bounds)-size.width)/2, 0, size.width, size.height);
            self.textLabel.frame = CGRectMake(0, size.height+3, CGRectGetWidth(self.contentView.bounds), self.textLabel.font.pointSize);
        }
    }
}

- (void)setTtitleColor:(UIColor *)titleColor {
    self.textLabel.textColor = titleColor;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:nil];
        _imageView.frame = CGRectZero;
    }
    return _imageView;
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [UILabel labelWithFrame:CGRectZero text:@"" font:[UIFont fontWithName:@"PingFangSC-Medium" size:15] textColor:[UIColor blackColor] textAlignment:(NSTextAlignmentCenter)];
    }
    return _textLabel;
}

@end
