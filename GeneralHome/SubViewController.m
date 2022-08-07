//
//  SubViewController.m
//  GeneralHome
//
//  Created by Guanglei Cheng on 2022/8/7.
//

#import "SubViewController.h"
#import "WelcomViewController.h"
#import "ViewController.h"
#import "SubTableView.h"
@interface SubViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) SubTableView *tableView;

@end

@implementation SubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([self.mainVC isKindOfClass:[ViewController class]]) {
        ViewController *vc = (ViewController *)(self.mainVC);
        if (!self.isListCollectionViewCanScroll) {
            scrollView.contentOffset = CGPointZero;
        }
        if (scrollView.contentOffset.y <= 0) {
            scrollView.contentOffset = CGPointZero;
            vc.isListCollectionViewCanScroll = NO;
            vc.isMainTableViewCanScroll = YES;
        }
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    cell.contentView.backgroundColor = UIColorMake(0xF5F5F5);
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld个cell",indexPath.row];
    cell.textLabel.font = UIFontMake(16);
    cell.textLabel.textColor = UIColor.fangDarkGrayColor;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        WelcomViewController *vc = [[WelcomViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    });
}


- (SubTableView *)tableView {
    if (!_tableView) {
        CGRect mainFrame = self.view.bounds;
        _tableView = [[SubTableView alloc] initWithFrame:mainFrame style:UITableViewStylePlain];
        _tableView.backgroundColor = UIColorMake(0xF5F5F5);

        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.decelerationRate = 0.999;
        _tableView.estimatedRowHeight = 90;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = YES;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
        if (@available(iOS 15.0, *)) {
            _tableView.sectionHeaderTopPadding = 0;
        }
    }
    return _tableView;
}

@end
