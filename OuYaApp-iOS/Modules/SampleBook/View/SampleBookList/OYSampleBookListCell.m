//
//  OYSampleBookListCell.m
//  OuYaApp-iOS
//
//  Created by yang.duan on 2018/1/18.
//  Copyright © 2018年 duanyang. All rights reserved.
//

#import "OYSampleBookListCell.h"

@interface OYSampleBookListCell()
@property (nonatomic, strong)IBOutlet UIImageView * imageView;
//@property (nonatomic, strong)IBOutlet UILabel * titleLabel;
@end

@implementation OYSampleBookListCell
- (void)awakeFromNib{
    [super awakeFromNib];
//    self.titleLabel.font = [UIFont fontWithName:SourceHanSansCN_Normal size:1];
}
- (void)addValueWithModel:(OYSampleBookListModel *)model{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.imageStr]];
   
//    self.titleLabel.text = model.titleStr;
}
@end
