//
//  OYSampleBookHomeCell.m
//  OuYaApp-iOS
//
//  Created by yang.duan on 2018/1/15.
//  Copyright © 2018年 duanyang. All rights reserved.
//

#import "OYSampleBookHomeCell.h"

@implementation OYSampleBookHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.tagView.frame = self.bounds;
    self.tagView.dataSource = self;
    self.tagView.delegate = self;
    self.tagView.themeColor = [UIColor blackColor];
    self.tagView.tagCornerRadius = 0;
    self.tagView.backgroundColor = [UIColor clearColor];
}

- (void)addValueWithArray:(NSArray *)array{
//    [self.tagView layoutIfNeeded];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}
- (NSInteger)numOfItems {
    return self.titleArray.count;
}

- (NSString *)tagView:(YJTagView *)tagView titleForItemAtIndex:(NSInteger)index {
    return self.titleArray[index];
}

- (void)tagView:(YJTagView *)tagView didSelectedItemAtIndex:(NSInteger)index {
    NSLog(@"点击%@", self.titleArray[index]);
    if (self.block != nil) {
        self.block(self.titleArray[index], index);
    }
}
- (void)returnValue:(returnBlock)block{
    self.block = block;
}
- (void)tagView:(YJTagView *)tagView heightUpdated:(CGFloat)height{
    NSLog(@"高度%f", height);

    self.heights = height;
//    [self.tagView updateConstraints];
//    self.frame = self.tagView.frame;
    [self.contentView updateConstraints];
}
- (CGFloat)getHeight{
    return self.tagView.height;
}
@end
