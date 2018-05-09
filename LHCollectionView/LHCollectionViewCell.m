//
//  LHCollectionViewCell.m
//  LHCollectionView
//
//  Created by Apach3 on 2018/5/8.
//  Copyright © 2018年 Apach3. All rights reserved.
//

#import "LHCollectionViewCell.h"

@implementation LHCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.backgroundColor = [UIColor whiteColor];
    self.backGroundView.layer.masksToBounds = YES;
    self.backGroundView.layer.borderWidth = 1.;
    self.backGroundView.layer.borderColor = [UIColor colorWithRed:151/255.0 green:151/255.0 blue:151/255.0 alpha:1.0].CGColor;
    self.backGroundView.layer.cornerRadius = 3.;
}

+ (NSString*)cellIdentifier {
    return NSStringFromClass(self);
}

- (void)setTypeLevel:(NSInteger)typeLevel {
    _typeLevel = typeLevel;
    
    if (self.typeLevel == 1) {
        self.topLayout.constant = 0;
        self.bottomLayout.constant = 0;
        self.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:15.];
    }
    else if (self.typeLevel == 2) {
        self.topLayout.constant = 3.5;
        self.bottomLayout.constant = 3.5;
        self.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14.];
    }
}

- (void)setSelect:(NSString *)select {
    _select = select;
    if ([select isEqualToString:@"1"]) {
        self.backGroundView.backgroundColor = [UIColor colorWithRed:199/255.0 green:226/255.0 blue:255/255.0 alpha:1.0];
        self.backGroundView.layer.borderWidth = 0;
    }
    else if ([select isEqualToString:@"0"]) {
        self.backGroundView.backgroundColor = [UIColor whiteColor];
        self.backGroundView.layer.borderWidth = 1.;
    }
}

@end
