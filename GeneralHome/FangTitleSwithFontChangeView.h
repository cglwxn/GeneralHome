//
//  FangTitleSwithFontChangeView.h
//  homezxb
//
//  Created by WangPan on 2019/8/9.
//  Copyright © 2019 soufunhome. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FangTitleSwithFontChangeItmeModel : NSObject

@property (nonatomic, copy) NSString * title;

@property (nonatomic, assign) BOOL isSelect; //

@property (nonatomic, assign) NSInteger  index; //id

@end


@interface FangTitleSwithFontChangeView : UIView

@property (nonatomic, assign , readonly) NSInteger index;

@property (nonatomic, strong) NSArray <FangTitleSwithFontChangeItmeModel*>* items;

@property (nonatomic, copy) void(^ItemsChangeClick)(FangTitleSwithFontChangeItmeModel * btnModel);

@property (nonatomic, copy) dispatch_block_t changeCityBlock;

- (void)setANewCityName:(NSString*)city;

- (void)selectAtIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
