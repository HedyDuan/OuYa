//
//  MFBaseChilldView.m
//  duanyang
//
//  Created by duanyang on 10/26/15.
//  Copyright © 2017年 duanyang. All rights reserved.
//

#import "MFBaseChildView.h"

@implementation MFBaseChildView

- (void)customDealloc {
    NSLog(@">>>>> %@ VIEW 销毁了 >>>>>", [NSString stringWithUTF8String:object_getClassName(self)]);
}

+ (MFBaseChildView *)shareChildView {
    return nil;
}

- (void)initializationCode {
}

- (NSString *)className {
    return NSStringFromClass([self class]);
}

+ (NSString *)className {
    return NSStringFromClass(self);
}

- (void)customViewWillAppear:(BOOL)animated {
}

- (void)customViewDidAppear:(BOOL)animated {
}

- (void)customViewWillDisappear:(BOOL)animated {
}

- (void)customViewDidDisappear:(BOOL)animated {
}

- (void)registerTableView:(UITableView *)tableView WithNibName:(NSString *)nibName {
    UINib *nib = [UINib nibWithNibName:nibName bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:nibName];
}



@end
