//
//  OYSampleBookDetailMiddleVC.m
//  OuYaApp-iOS
//
//  Created by yang.duan on 2018/1/19.
//  Copyright © 2018年 duanyang. All rights reserved.
//

#import "OYSampleBookDetailMiddleVC.h"

@interface OYSampleBookDetailMiddleVC ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lavbelHeight;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation OYSampleBookDetailMiddleVC
+ (OYSampleBookDetailMiddleVC *)shareViewController{
    OYSampleBookDetailMiddleVC *mainCtrl =
    [UIStoryboard showControllerWithStoryBoardName:@"SampleBook" VCIdentifier:@"OYSampleBookDetailMiddleVC"];
    return mainCtrl;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.numLabel.font = [UIFont fontWithName:SourceHanSansCN_Normal size:21 * Radio_X];
    self.labelWidth.constant = 34 * Radio_X;
    self.lavbelHeight.constant = 21 * Radio_Y;
    self.imageView.image = [UIImage imageNamed:@"第二页图片_云上月光"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
