//
//  ViewControllerCell.m
//  GeneralHome
//
//  Created by Guanglei Cheng on 2022/8/8.
//

#import "ViewControllerCell.h"
#import "FangFeedbackButton.h"

@interface ViewControllerCell ()
@property (nonatomic, strong) UIView *cellView;
@end

@implementation ViewControllerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.cellView];
        return  self;
    }
    return  self;
}


- (UIView *)cellView {
    if (!_cellView) {
        _cellView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 220)];
        _cellView.backgroundColor = UIColorMake(0xF5F5F5);
//        _cellView.backgroundColor = UIColorMake(0xF53262);

        __weak ViewControllerCell *ws = self;
        FangFeedbackButton *saleHouseView = [self obtainViewFrame:CGRectMake(24, 24, (SCREEN_WIDTH - 120)/4, (SCREEN_WIDTH - 120)/4) title:@"出售房源" imageName:@"FangMicroshop_SalehouseImg"];
        saleHouseView.layer.cornerRadius = 20;
        saleHouseView.feedbackButtonEventHandler = ^(UIView * _Nullable view, CGPoint touchPoint) {
            __strong ViewControllerCell *ss = ws;
            if (ss.itemTapBlock) {
                ss.itemTapBlock(0);
            }
        };
        FangFeedbackButton *rentHouseView = [self obtainViewFrame:CGRectMake(CGRectGetMaxX(saleHouseView.frame) + 24, 24, (SCREEN_WIDTH-120)/4, (SCREEN_WIDTH - 120)/4) title:@"出租房源" imageName:@"FangMicroshop_RenthouseImg"];
        rentHouseView.layer.cornerRadius = 20;
        rentHouseView.feedbackButtonEventHandler = ^(UIView * _Nullable view, CGPoint touchPoint) {
            __strong ViewControllerCell *ss = ws;
            if (ss.itemTapBlock) {
                ss.itemTapBlock(1);
            }
        };
         FangFeedbackButton *inputHouseView = [self obtainViewFrame:CGRectMake(CGRectGetMaxX(rentHouseView.frame) + 24, 24, (SCREEN_WIDTH-120)/4, (SCREEN_WIDTH - 120)/4) title:@"录入房源" imageName:@"FangMicroshop_InputhouseImg"];
        inputHouseView.layer.cornerRadius = 20;
        inputHouseView.feedbackButtonEventHandler = ^(UIView * _Nullable view, CGPoint touchPoint) {
            __strong ViewControllerCell *ss = ws;
            if (ss.itemTapBlock) {
                ss.itemTapBlock(2);
            }
        };
        FangFeedbackButton *lookHouseRecordView = [self obtainViewFrame:CGRectMake(CGRectGetMaxX(inputHouseView.frame) + 24, 24, (SCREEN_WIDTH-120)/4, (SCREEN_WIDTH - 120)/4) title:@"看房记录" imageName:@"FangMicroshop_LookhouseImg"];
        lookHouseRecordView.layer.cornerRadius = 20;
        lookHouseRecordView.feedbackButtonEventHandler = ^(UIView * _Nullable view, CGPoint touchPoint) {
            __strong ViewControllerCell *ss = ws;
            if (ss.itemTapBlock) {
                ss.itemTapBlock(3);
            }
        };

        FangFeedbackButton *VRHouseView = [self obtainViewFrame:CGRectMake(24, CGRectGetMaxY(saleHouseView.frame)+24, (SCREEN_WIDTH-120)/4, (SCREEN_WIDTH - 120)/4) title:@"VR管理" imageName:@"FangMicroshop_VRManageImg"];
        VRHouseView.layer.cornerRadius = 20;
        VRHouseView.feedbackButtonEventHandler = ^(UIView * _Nullable view, CGPoint touchPoint) {
            __strong ViewControllerCell *ss = ws;
            if (ss.itemTapBlock) {
                ss.itemTapBlock(4);
            }
        };

        FangFeedbackButton *collectHouseView = [self obtainViewFrame:CGRectMake(CGRectGetMaxX(VRHouseView.frame) + 24, CGRectGetMaxY(saleHouseView.frame)+24, (SCREEN_WIDTH-120)/4, (SCREEN_WIDTH - 120)/4) title:@"房源采集" imageName:@"FangMicroshop_CollecthouseImg"];
        collectHouseView.layer.cornerRadius = 20;
        collectHouseView.feedbackButtonEventHandler = ^(UIView * _Nullable view, CGPoint touchPoint) {
            __strong ViewControllerCell *ss = ws;
            if (ss.itemTapBlock) {
                ss.itemTapBlock(5);
            }
            
        };

        FangFeedbackButton *commissionHouseView = [self obtainViewFrame:CGRectMake(CGRectGetMaxX(collectHouseView.frame) + 24, CGRectGetMaxY(saleHouseView.frame)+24, (SCREEN_WIDTH-120)/4, (SCREEN_WIDTH - 120)/4) title:@"委托房源" imageName:@"FangMicroshop_CommissionImg"];
        commissionHouseView.layer.cornerRadius = 20;
        commissionHouseView.feedbackButtonEventHandler = ^(UIView * _Nullable view, CGPoint touchPoint) {
            __strong ViewControllerCell *ss = ws;
            if (ss.itemTapBlock) {
                ss.itemTapBlock(6);
            }
        };

        [_cellView addSubview:saleHouseView];
        [_cellView addSubview:rentHouseView];
        [_cellView addSubview:inputHouseView];
        [_cellView addSubview:lookHouseRecordView];
        [_cellView addSubview:VRHouseView];
        [_cellView addSubview:collectHouseView];
        [_cellView addSubview:commissionHouseView];

    }
    return _cellView;
}

- (FangFeedbackButton *)obtainViewFrame:(CGRect)frame title:(NSString *)title imageName:(NSString *)imageName {
    FangFeedbackButton *funView = [[FangFeedbackButton alloc] initWithFrame:frame];
    funView.scaleDuration = 0.15;
    funView.layoutDirection = FangFeedbackButtonLayoutDirectionVertical;
    [funView setImage:[UIImage imageNamed:imageName]];
    [funView setTitle:title];
    [funView setTtitleColor:[UIColor grayColor]];
    funView.textLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:13];
    return funView;
}


@end
