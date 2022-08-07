////
////  FangTitleSwithFontChangeView.m
////  homezxb
////
////  Created by WangPan on 2019/8/9.
////  Copyright © 2019 soufunhome. All rights reserved.
////
//
//#import "FangTitleSwithFontChangeView.h"
//#import "UILabel+FangLabel.h"
//#import "NSString+FangSize.h"
//#import "Masonry.h"
//
//@implementation FangTitleSwithFontChangeItmeModel
//
//
//@end
//
//
//@interface FangTitleSwithFontChangeView () <UICollectionViewDelegate , UICollectionViewDataSource>
//
//@property (nonatomic, strong) UIFont * defalutFont;
//
//@property (nonatomic, strong) UIColor * defalutColor;
//
//@property (nonatomic, strong) UIFont * selectFont;
//
//@property (nonatomic, strong) UIColor * selectColor;
//
//@property (nonatomic, strong) UIColor * defalutBGColor;
//
//@property (nonatomic, strong) UIColor * selectBGColor;
//
//@property (nonatomic, strong) UICollectionView * collectionView;
//
////@property (nonatomic, strong) UIView * lineView;
//
//@property (nonatomic, strong) UIButton * cityBtn;
//
//@property (nonatomic, strong) UILabel * cityLabel;
//
//@end
//
//@implementation FangTitleSwithFontChangeView
//
//- (instancetype)initWithFrame:(CGRect)frame{
//    self = [super initWithFrame:frame];
//    if (self) {
//        self.defalutBGColor = [UIColor defaultBGColor];
//        self.selectBGColor = [UIColor defaultBGColor];
//        self.selectFont = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
//        self.defalutFont = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
//        self.selectColor = [UIColor light:kFColor_3295F6 dark:kFColor_007AFF];
//        self.defalutColor = [UIColor light:kFColor_0E131A dark:kFColor_989DA6];
//        [self addSubview:self.collectionView];
//        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.mas_top).offset(18);
//            make.left.equalTo(self.mas_left).offset(16);
//            make.size.mas_equalTo(CGSizeMake(168, frame.size.height - 36));
//        }];
//
////        [self addSubview:self.lineView];
//        [self addSubview:self.cityBtn];
//        [self.cityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.mas_top).offset(20);
//            make.right.equalTo(self.mas_right).offset(-16);
//            make.size.mas_equalTo(CGSizeMake(65, 20));
//        }];
//    }
//    return self;
//}
//
//- (void)setANewCityName:(NSString *)city{
//    self.cityLabel.text = city;
//}
//- (void)changeAction{
//    if (self.changeCityBlock) {
//        self.changeCityBlock();
//    }
//}
//
//- (void)setItems:(NSArray<FangTitleSwithFontChangeItmeModel *> *)items{
//    _items = items;
//    [self.collectionView reloadData];
//}
//
//
//- (UIButton *)cityBtn{
//    if (!_cityBtn) {
//        _cityBtn = [UIButton new];
//        [_cityBtn addSubview:self.cityLabel];
//        [self.cityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(_cityBtn.mas_top);
//            make.right.equalTo(_cityBtn.mas_right).offset(-20);
//            make.left.equalTo(_cityBtn.mas_left);
//            make.bottom.equalTo(_cityBtn.mas_bottom);
//        }];
//        UIImageView * imgv = [UIImageView new];
//        imgv.image = [UIImage imageNamed:@"peer_switch_citydown"];
//        [_cityBtn addSubview:imgv];
//        [imgv mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.size.mas_equalTo(CGSizeMake(20, 20));
//            make.top.equalTo(_cityBtn.mas_top);
//            make.right.equalTo(_cityBtn.mas_right);
//        }];
//        [_cityBtn addTarget:self action:@selector(changeAction) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _cityBtn;
//}
//
//- (UILabel*)cityLabel{
//    if (!_cityLabel) {
//        _cityLabel = [UILabel new];
//        _cityLabel.font = [UIFont systemFontOfSize:14];
//        _cityLabel.textColor = [UIColor light:kFColor_394043 dark:kFColor_989DA6];
//        _cityLabel.textAlignment = NSTextAlignmentRight;
//    }
//    return _cityLabel;
//}
//
//#pragma mark - Custom Accessors
//
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
//    return 1;
//}
//
//
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    return self.items.count;
//}
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//
//    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"kTitleSwitchCollectionId" forIndexPath:indexPath];
//    for (UIView * vc in cell.contentView.subviews) {
//        [vc removeFromSuperview];
//    }
//    FangTitleSwithFontChangeItmeModel * item = self.items[indexPath.row];
//    self.collectionView.backgroundColor = self.defalutBGColor;
//    UILabel * label = [UILabel labelWithFrame:cell.contentView.bounds text:item.title
//                                         font:self.defalutFont
//                                    textColor:self.defalutColor textAlignment:NSTextAlignmentCenter];
//    [cell.contentView addSubview:label];
//    [label mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.bottom.right.equalTo(cell.contentView).width.insets(UIEdgeInsetsMake(0, 0, 0, 0));
//    }];
//
//    if (item.isSelect) {
//        _index = indexPath.row;
//        label.font = self.selectFont;
//        label.textColor = self.selectColor;
//    }else{
//        label.font = self.defalutFont;
//        label.textColor = self.defalutColor;
//    }
//    return cell;
//}
//
//
//
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    [self selectAtIndex:indexPath.row];
//}
//
//- (void)selectAtIndex:(NSInteger)index{
//    FangTitleSwithFontChangeItmeModel * item = self.items[index];
//    if (index == 2) {
//        self.cityBtn.hidden = YES;
//    }else{
//        self.cityBtn.hidden = NO;
//    }
//    if (!item.isSelect) {
//        for (FangTitleSwithFontChangeItmeModel * it in self.items) {
//            it.isSelect = NO;
//        }
//        item.isSelect = YES;
//        if (self.ItemsChangeClick) {
//            self.ItemsChangeClick(item);
//        }
//        [self.collectionView reloadData];
////
////        UICollectionViewLayoutAttributes * att = [self.collectionView layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
////        CGRect cellRect = att.frame;
////        CGRect cellFrame = [self.collectionView  convertRect:cellRect toView:self];
////        [UIView animateWithDuration:0.3 animations:^{
////            self.lineView.frame = CGRectMake(cellFrame.origin.x + (cellFrame.size.width - 21) / 2.0, 50, 21, 4);
////        }];
//    }
//
//}
//
//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    FangTitleSwithFontChangeItmeModel * item = self.items[indexPath.row];
//    CGFloat width = [item.title boundingWidthWithFontOfSize:18];
//    return CGSizeMake(width, 25);
//}
//
//
//- (UICollectionView *)collectionView {
//    if (!_collectionView) {
//        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//        layout.minimumLineSpacing = 0;
//        layout.minimumInteritemSpacing = 20;
//        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
//        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
//        _collectionView.autoresizingMask =  UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//        _collectionView.backgroundColor = [UIColor defaultBGColor];
//        _collectionView.scrollEnabled = NO;
//        _collectionView.showsVerticalScrollIndicator = NO;
//        _collectionView.showsHorizontalScrollIndicator = NO;
//        _collectionView.delegate = self;
//        _collectionView.dataSource = self;
//        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"kTitleSwitchCollectionId"];
//    }
//    return _collectionView;
//}
////- (UIView *)lineView{
////    if (!_lineView) {
////        _lineView = [[UIView alloc] initWithFrame:CGRectMake(33, 50, 21, 4)];
////        _lineView.backgroundColor = [UIColor light:kFColor_3295F6 dark:kFColor_007AFF];
////        _lineView.layer.cornerRadius = 2;
////        _lineView.clipsToBounds = YES;
////    }
////    return _lineView;
////}
//
//@end
