//
//  MFBaseTableViewCell.m
//  duanyang
//
//  Created by duanyang on 4/20/16.
//  Copyright © 2017年 duanyang. All rights reserved.
//

#import "MFBaseTableViewCell.h"

@implementation MFBaseTableViewCell

- (NSString *)className {
    return NSStringFromClass([self class]);
}

+ (NSString *)className {
    return NSStringFromClass(self);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
