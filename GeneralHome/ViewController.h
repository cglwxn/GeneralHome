//
//  ViewController.h
//  GeneralHome
//
//  Created by Guanglei Cheng on 2022/8/6.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, assign) BOOL isMainTableViewCanScroll;
@property (nonatomic, assign) BOOL isListCollectionViewCanScroll;
@property (nonatomic, strong) UIViewController *currentCategoryVC;

@end

