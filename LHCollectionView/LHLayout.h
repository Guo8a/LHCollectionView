//
//  LHLayout.h
//  LHCollectionView
//
//  Created by Apach3 on 2018/5/8.
//  Copyright © 2018年 Apach3. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LHLayout : UICollectionViewLayout

@property (nonatomic, assign) CGFloat interItemSpacing;//item间距
@property (nonatomic, assign) CGFloat lineSpacing;//行间距
@property (nonatomic, strong) NSMutableArray *sectionArray;//item宽度数组
@property (nonatomic, assign) CGFloat maxWidthOfSection;

@end
