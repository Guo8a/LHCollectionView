//
//  LHLayout.m
//  LHCollectionView
//
//  Created by Apach3 on 2018/5/8.
//  Copyright © 2018年 Apach3. All rights reserved.
//

#import "LHLayout.h"

@interface LHLayout ()

@property (nonatomic, strong) NSMutableArray *itemWidthArray;//item宽度数组
@property (nonatomic, strong) NSArray *layoutInfoArray;//layout数组
@property (nonatomic, assign) CGSize contentSize;

@end


@implementation LHLayout

#pragma mark - set method

- (void)setLineSpacing:(CGFloat)lineSpacing {
    _lineSpacing = lineSpacing;
    [self invalidateLayout];
}

- (void)setInterItemSpacing:(CGFloat)interItemSpacing {
    _interItemSpacing = interItemSpacing;
    [self invalidateLayout];
}

- (void)setSectionArray:(NSMutableArray *)sectionArray {
    _sectionArray = sectionArray;
    [self invalidateLayout];
}

- (void)setMaxWidthOfSection:(CGFloat)maxWidthOfSection {
    _maxWidthOfSection = maxWidthOfSection;
    [self invalidateLayout];
}

#pragma mark - overwrite prepareLayout method

/*
 告诉布局刷新布局
 */
- (void)prepareLayout {
    [super prepareLayout];

    /*
     将每个item的UICollectionViewLayoutAttributes存进数组
     */
    NSMutableArray *layoutArray = [NSMutableArray array];
    for (NSInteger section = 0; section < self.sectionArray.count; section ++) {
        NSInteger itemCount = ((NSMutableArray *)self.sectionArray[section]).count;
        NSMutableArray *subArray = [NSMutableArray arrayWithCapacity:itemCount];
        for (NSInteger item = 0; item < itemCount; item ++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
            [subArray addObject:attributes];
        }
        [layoutArray addObject:[subArray copy]];
    }
    self.layoutInfoArray = [layoutArray copy];
    
    /*
     设置contentSize
     */
    self.contentSize = CGSizeMake(self.maxWidthOfSection, self.sectionArray.count * (40. + self.lineSpacing) - self.lineSpacing);
}

- (CGSize)collectionViewContentSize {
    return self.contentSize;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    NSInteger row = indexPath.item;
    NSInteger section = indexPath.section;
    CGFloat left = 0.;//距离左边距离
    CGFloat top = 0.;//距离顶部距离
    
    for (NSInteger item = 0; item < row; item ++) {
        left = left + [[(NSMutableArray *)self.sectionArray[section] objectAtIndex:item] floatValue] + self.interItemSpacing;
    }
    
    for (NSInteger item = 0; item < section; item ++) {
        top = top + 40. + self.lineSpacing;
    }
    
    /*
     因为是居中，这段代码计算居中后距离左边的距离
     */
    CGFloat marginLeft = 0.;
    CGFloat width = 0.;
    for (NSInteger i = 0; i < ((NSMutableArray *)self.sectionArray[section]).count; i ++) {
        width = width + [[((NSMutableArray *)self.sectionArray[section]) objectAtIndex:i] floatValue] + self.interItemSpacing;
    }
    width = width - self.interItemSpacing;
    marginLeft = (self.collectionView.frame.size.width - width) / 2;
    
    /*
     设置frame
     */
    attributes.frame = CGRectMake(left + marginLeft, top, [[(NSMutableArray *)self.sectionArray[section] objectAtIndex:row] floatValue], 40.);
    return attributes;
}


/*
 遍历数组，每个item的layout
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *layoutAttributesArr = [NSMutableArray array];
    [self.layoutInfoArray enumerateObjectsUsingBlock:^(NSArray *array, NSUInteger i, BOOL * _Nonnull stop) {
        [array enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if(CGRectIntersectsRect(obj.frame, rect)) {
                [layoutAttributesArr addObject:obj];
            }
        }];
    }];
    return layoutAttributesArr;
}

@end
