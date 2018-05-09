//
//  LHCollectionViewCell.h
//  LHCollectionView
//
//  Created by Apach3 on 2018/5/8.
//  Copyright © 2018年 Apach3. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LHCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIView *backGroundView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLayout;

@property (nonatomic, assign) NSInteger typeLevel;
@property (nonatomic, strong) NSString *select;

+ (NSString*)cellIdentifier;

@end
