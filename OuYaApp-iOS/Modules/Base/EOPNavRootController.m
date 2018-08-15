//
//  EOPNavRootController.m
//  duanyang
//
//  Created by duanyang on 4/14/16.
//  Copyright © 2017年 duanyang. All rights reserved.
//

#import "EOPNavRootController.h"

@interface EOPNavRootController () <UIGestureRecognizerDelegate>

@end

@implementation EOPNavRootController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UIGestureRecognizerDelegate

/**
 左滑手势
 */
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.navigationController.viewControllers.count == 1) {
        return NO;
    } else {
        return YES;
    }
}

@end
