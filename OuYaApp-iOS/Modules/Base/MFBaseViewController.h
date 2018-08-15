//
//  MFBaseViewController.h
//  duanyang
//
//  Created by duanyang on 10/12/15.
//  Copyright © 2017年 duanyang. All rights reserved.
//

#import "NSNull+Addtions.h"
#import <UIKit/UIKit.h>

@class MFBaseChildView;

@interface MFBaseViewController : UIViewController

@property (nonatomic, weak) MFBaseChildView *mfChildView;

@property (nonatomic, strong) UIColor *tintColor;
@property (nonatomic, copy) NSString *titleText;
@property (nonatomic, strong) UIColor *titleColor;

+ (MFBaseViewController *)shareViewController;

- (NSString *)className;

+ (NSString *)className;

- (void)addChildView:(MFBaseChildView *)childView onView:(UIView *)superView;

- (UIButton *)setLeftNavButton;

- (UIButton *)setRightNavButton;

- (void)setLeftNavButtonIconName:(NSString *)iconName;

- (void)setLeftNavButtonText:(NSString *)text;
- (UIButton *)setLeftNavBtnText:(NSString *)text;

- (void)leftNavButtonPressed:(UIButton *)button;

- (void)setLeftNavButtonIconNameWithText:(NSString *)text;

- (UIButton *)setRightNavButtonIconName:(NSString *)iconName;

- (UIButton *)setRightNavButtonText:(NSString *)text;

- (void)rightNavButtonPressed:(UIButton *)button;

- (void)setLeftButtonHidden:(BOOL)hidden;

- (void)setRightButtonHidden:(BOOL)hidden;

- (void)setRightButtonEnable:(BOOL)enable;

#pragma mark - title

- (void)setTitleText:(NSString *)text;

- (void)setTitleText:(NSString *)text andTitleColor:(UIColor *)color;

#pragma mark--
- (void)gotoLoginVc;
@end
