//
//  OYSampleBookHomeCell.h
//  OuYaApp-iOS
//
//  Created by yang.duan on 2018/1/15.
//  Copyright © 2018年 duanyang. All rights reserved.
//

#import "MFBaseTableViewCell.h"
#import "YJTagView.h"
typedef void (^returnBlock)(NSString *title,NSInteger myIndex);

typedef void (^returncellheight)(NSString *title,NSIndexPath *indexPath);

@interface OYSampleBookHomeCell : MFBaseTableViewCell<YJTagViewDelegate, YJTagViewDataSource>
@property (weak, nonatomic) IBOutlet YJTagView *tagView;

@property (nonatomic, strong) NSArray *titleArray;
- (void)addValueWithArray:(NSArray *)array;
//- (CGFloat)getHeight;
@property (nonatomic, assign)CGFloat heights;
@property (nonatomic, strong)NSIndexPath * indexPath;
/**
 获取cell的高度
 */
//+ (CGFloat)rowHeight:(CalEvent *)event;
@property (nonatomic, copy)returnBlock block;
- (void)returnValue:(returnBlock)block;
@end
