//
//  UIStoryboard+FR.h
//  duanyang
//
//  Created by yang.duan on 2017/6/25.
//  Copyright © 2017年 duanyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIStoryboard (Utils)

+ (nullable __kindof UIViewController *)showControllerWithStoryBoardName:(nullable NSString *)name;

+ (nullable __kindof UIViewController *)showControllerWithStoryBoardName:(nullable NSString *)name
                                                            VCIdentifier:(nullable NSString *)identifier;

@end
