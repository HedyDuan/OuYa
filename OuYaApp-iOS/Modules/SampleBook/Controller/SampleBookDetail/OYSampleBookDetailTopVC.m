//
//  OYSampleBookDetailTopVC.m
//  OuYaApp-iOS
//
//  Created by yang.duan on 2018/1/19.
//  Copyright © 2018年 duanyang. All rights reserved.
//

#import "OYSampleBookDetailTopVC.h"

@interface OYSampleBookDetailTopVC ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelWidth;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation OYSampleBookDetailTopVC
+ (OYSampleBookDetailTopVC *)shareViewController{
    OYSampleBookDetailTopVC *mainCtrl =
    [UIStoryboard showControllerWithStoryBoardName:@"SampleBook" VCIdentifier:@"OYSampleBookDetailTopVC"];
    return mainCtrl;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.numLabel.font = [UIFont fontWithName:SourceHanSansCN_Normal size:21 * Radio_X];
    self.labelWidth.constant = 34 * Radio_X;
    self.labelHeight.constant = 21 * Radio_Y;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.imagestr]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
