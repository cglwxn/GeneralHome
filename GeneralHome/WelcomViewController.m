//
//  WelcomViewController.m
//  GeneralHome
//
//  Created by Guanglei Cheng on 2022/8/8.
//

#import "WelcomViewController.h"
#import "UILabel+FangLabel.h"
@interface WelcomViewController ()

@end

@implementation WelcomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [UILabel labelWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50) text:@"Welcome" font:UIFontWeightSemiboldMake(30) textColor:UIColor.fangBlueColor textAlignment:(NSTextAlignmentCenter)];
    label.center = self.view.center;
    [self.view addSubview:label];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
