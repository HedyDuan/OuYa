//
//  UIStoryboard+FR.m
//  duanyang
//
//  Created by yang.duan on 2017/6/25.
//  Copyright © 2017年 duanyang. All rights reserved.
//

#import "UIStoryboard+Utils.h"

@implementation UIStoryboard (Utils)

+ (nullable __kindof UIViewController *)showControllerWithStoryBoardName:(nullable NSString *)name {
    return [[UIStoryboard storyboardWithName:name bundle:[NSBundle mainBundle]] instantiateInitialViewController];
}

+ (nullable __kindof UIViewController *)showControllerWithStoryBoardName:(nullable NSString *)name
                                                            VCIdentifier:(nullable NSString *)identifier {
    return [[UIStoryboard storyboardWithName:name bundle:[NSBundle mainBundle]]
        instantiateViewControllerWithIdentifier:identifier];
}

@end
