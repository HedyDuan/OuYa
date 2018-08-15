//
//  YJTagCollectionViewCell.m
//  tagsView
//
//  Created by Jake on 2017/6/22.
//  Copyright © 2017年 Jakey. All rights reserved.
//

#import "YJTagCollectionViewCell.h"

@implementation YJTagCollectionViewCell
- (void)awakeFromNib{
    self.tagLabel.font = [UIFont fontWithName:SourceHanSansCN_Normal size:15  * Radio_X];
    [super awakeFromNib];
}
- (void)setContent:(NSString *)content
{
    _content = content;
    [_tagLabel setText:content];
}

+ (CGSize)getSizeWithContent:(NSString *)content maxWidth:(CGFloat)maxWidth customHeight:(CGFloat)cellHeight
{
    NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
    style.lineBreakMode = NSLineBreakByTruncatingTail;
    CGSize size = [content boundingRectWithSize:CGSizeMake(maxWidth, cellHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont fontWithName:SourceHanSansCN_Normal size:15 * Radio_X],NSParagraphStyleAttributeName:style} context:nil].size;
    return CGSizeMake(size.width+40 * Radio_X, cellHeight);
}

@end
