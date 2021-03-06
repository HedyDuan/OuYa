//
//  YJTagView.m
//  tagsView
//
//  Created by Jake on 2017/6/22.
//  Copyright © 2017年 Jakey. All rights reserved.
//

#import "YJTagView.h"
#import "UICollectionViewLeftAlignedLayout.h"
#import "YJTagCollectionViewCell.h"
#import "EqualSpaceFlowLayout.h"

#define kDefaultCellHeight 30 * Radio_Y

@interface YJTagView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation YJTagView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self addSubview:self.collectionView];
        self.cellHeight = kDefaultCellHeight;
        self.width = 835 * Radio_X;
//        UICollectionViewLeftAlignedLayout *layout = (UICollectionViewLeftAlignedLayout *)_collectionView.collectionViewLayout;
//        [layout invalidateLayout];

    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.collectionView];
        self.cellHeight = kDefaultCellHeight;
//        UICollectionViewLeftAlignedLayout *layout = (UICollectionViewLeftAlignedLayout *)_collectionView.collectionViewLayout;
//        [layout invalidateLayout];

    }
    return self;
}
- (void)awakeFromNib{
    [super awakeFromNib];

}
#pragma mark - Layout
/** 适应布局变换 */
- (void) layoutSubviews
{
    UICollectionViewLeftAlignedLayout *layout = (UICollectionViewLeftAlignedLayout *)_collectionView.collectionViewLayout;
    [layout invalidateLayout];
//
//
//    if (!CGSizeEqualToSize(self.bounds.size, [self intrinsicContentSize])) {
////        [self invalidateIntrinsicContentSize];
//        [self layoutIfNeeded];
//    }
//    CGFloat height = _collectionView.collectionViewLayout.collectionViewContentSize.height;
//    if (height != 0 && height != self.bounds.size.height) {
//        CGRect frame = self.frame;
//        frame.size.height = height;
//        self.frame = frame;
//        if ([self.delegate respondsToSelector:@selector(tagView:heightUpdated:)]) {
//            [self.delegate tagView:self heightUpdated:height];
//        }
//    }
    _collectionView.frame = self.bounds;
    [super layoutSubviews];
//    [self.superview updateConstraints];
//    self.superview.frame = self.frame;
}



//每个item之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout*)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5 * Radio_Y;
}
//每个item之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout*)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.1;
}

- (CGSize)intrinsicContentSize
{
    NSLog(@"height---%f",_collectionView.collectionViewLayout.collectionViewContentSize.height);
    return _collectionView.collectionViewLayout.collectionViewContentSize;
}

#pragma mark - Actions

- (void)reloadData {
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.dataSource numOfItems];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YJTagCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.content = [self.dataSource tagView:self titleForItemAtIndex:indexPath.row];
    if (self.themeColor) {
        cell.tagLabel.textColor = self.themeColor;
    }
    if (indexPath.row == [self.dataSource numOfItems] - 1) {
        cell.lineView.hidden = YES;
    }else{
        cell.lineView.hidden = NO;
    }
    cell.backgroundColor = [UIColor clearColor];
//    CGFloat cornerRadius = self.tagCornerRadius;
//    cell.backgroundView = [self drawConnerView:cornerRadius rect:cell.bounds backgroudColor:cell.backgroundColor borderColor:cell.tagLabel.textColor];
    return cell;
}

#pragma mark - UI_Style

///** 绘画圆角 解决卡顿*/
//-(UIView *)drawConnerView:(CGFloat)cornerRadius rect:(CGRect)frame backgroudColor:(UIColor *)backgroud_color borderColor:(UIColor *)borderColor{
//    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
//    CGMutablePathRef pathRef = CGPathCreateMutable();
//    CGRect bounds = CGRectInset(frame, 0, 0);
//    CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
//    CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), cornerRadius);
//    CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMinY(bounds), cornerRadius);
//    CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMinX(bounds), CGRectGetMinY(bounds), cornerRadius);
//    CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMinX(bounds), CGRectGetMaxY(bounds), cornerRadius);
//    layer.path = pathRef;
//    CFRelease(pathRef);
//    layer.strokeColor = [borderColor CGColor];
//    layer.fillColor = backgroud_color.CGColor;
//    UIView *roundView = [[UIView alloc] initWithFrame:bounds];
//    [roundView.layer insertSublayer:layer atIndex:0];
//    roundView.backgroundColor = UIColor.clearColor;
//    return roundView;
//}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(tagView:didSelectedItemAtIndex:)]) {
        [self.delegate tagView:self didSelectedItemAtIndex:indexPath.row];
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [YJTagCollectionViewCell getSizeWithContent:[self.dataSource tagView:self titleForItemAtIndex:indexPath.row] maxWidth:_collectionView.frame.size.width customHeight:self.cellHeight];
}

#pragma mark - Lazy loading

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)) collectionViewLayout:[[UICollectionViewLeftAlignedLayout alloc] init]];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerNib:[UINib nibWithNibName:@"YJTagCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];
    }
    return _collectionView;
}

@end
