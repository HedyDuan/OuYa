//
//  UIBarButtonItem+Common.h
//  OuYaApp
//
//  Created by yang.duan on 17/8/1.
//  Copyright © 2017年 duanyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Common)
+ (UIBarButtonItem *)itemWithBtnTitle:(NSString *)title target:(id)obj action:(SEL)selector;

@end
