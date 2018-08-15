//
//  MFBaseChilldView.h
//  duanyang
//
//  Created by duanyang on 10/26/15.
//  Copyright © 2017年 duanyang. All rights reserved.
//

#import "NSNull+Addtions.h"
#import <UIKit/UIKit.h>

@interface MFBaseChildView : UIView

- (void)customDealloc;

+ (MFBaseChildView *)shareChildView;

- (void)initializationCode;

- (NSString *)className;

+ (NSString *)className;

- (void)customViewWillAppear:(BOOL)animated;

- (void)customViewDidAppear:(BOOL)animated;

- (void)customViewWillDisappear:(BOOL)animated;

- (void)customViewDidDisappear:(BOOL)animated;

- (void)registerTableView:(UITableView *)tableView WithNibName:(NSString *)nibName;

- (void)showStatusBarLoading;

- (void)hideStatusBarLoading;

@end
