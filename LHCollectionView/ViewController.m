//
//  ViewController.m
//  LHCollectionView
//
//  Created by Apach3 on 2018/5/8.
//  Copyright © 2018年 Apach3. All rights reserved.
//

#import "ViewController.h"
#import "LHLayout.h"
#import "LHCollectionViewCell.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, assign) CGFloat interItemSpacing;//item间距
@property (nonatomic, assign) CGFloat lineSpacing;//行间距
@property (nonatomic, strong) NSMutableArray *itemsArray;//内容数组
@property (nonatomic, strong) NSMutableArray *itemWidthArray;//item宽度数组
@property (nonatomic, strong) NSMutableArray *sectionArray;//行数组，是一个二维数组，存的是每行每个元素的宽度
@property (nonatomic, strong) NSMutableArray *sectionObjArray;//行内容数组，是一个二维数组，存的是每行每个元素
@property (nonatomic, assign) CGFloat maxWidthOfSection;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.interItemSpacing = 10.;
    self.lineSpacing = 12.5;
    self.maxWidthOfSection = 320.;
    self.itemsArray = [NSMutableArray arrayWithObjects:
                       @{@"type_level": @"1", @"title": @"个人动态",    @"type":@"", @"selected": @"0"},
                       @{@"type_level": @"1", @"title": @"闲置",       @"type":@"", @"selected": @"0"},
                       @{@"type_level": @"2", @"title": @"团购拼单",    @"type":@"", @"selected": @"0"},
                       @{@"type_level": @"2", @"title": @"商家优惠",    @"type":@"", @"selected": @"0"},
                       @{@"type_level": @"2", @"title": @"租房",       @"type":@"", @"selected": @"0"},
                       @{@"type_level": @"2", @"title": @"出租",       @"type":@"", @"selected": @"0"},
                       @{@"type_level": @"2", @"title": @"买房",       @"type":@"", @"selected": @"0"},
                       @{@"type_level": @"2", @"title": @"卖房",       @"type":@"", @"selected": @"0"},
                       @{@"type_level": @"2", @"title": @"乘客拼车",    @"type":@"", @"selected": @"0"},
                       @{@"type_level": @"2", @"title": @"车主拼车",    @"type":@"", @"selected": @"0"},
                       @{@"type_level": @"1", @"title": @"招聘",       @"type":@"", @"selected": @"0"},
                       @{@"type_level": @"1", @"title": @"生意转让",    @"type":@"", @"selected": @"0"},
                       @{@"type_level": @"1", @"title": @"寻人寻物",    @"type":@"", @"selected": @"0"},
                       @{@"type_level": @"1", @"title": @"宠物",       @"type":@"", @"selected": @"0"},
                       @{@"type_level": @"2", @"title": @"亲子活动",    @"type":@"", @"selected": @"0"},
                       @{@"type_level": @"2", @"title": @"游戏",       @"type":@"", @"selected": @"0"},
                       @{@"type_level": @"2", @"title": @"演唱会",      @"type":@"", @"selected": @"0"},
                       @{@"type_level": @"2", @"title": @"旅伴",       @"type":@"", @"selected": @"0"},
                       @{@"type_level": @"1", @"title": @"运动",       @"type":@"", @"selected": @"0"},
                       @{@"type_level": @"1", @"title": @"母婴",       @"type":@"", @"selected": @"0"},
                       @{@"type_level": @"1", @"title": @"求助",       @"type":@"", @"selected": @"0"},
                       @{@"type_level": @"1", @"title": @"这个就很长了",    @"type":@"", @"selected": @"0"},
                       @{@"type_level": @"1", @"title": @"这个更长一点点",    @"type":@"", @"selected": @"0"},
                       @{@"type_level": @"2", @"title": @"这个再长一点点点点点点",    @"type":@"", @"selected": @"0"},
                       @{@"type_level": @"1", @"title": @"这个再长一点点点点点点吧！长长长",    @"type":@"", @"selected": @"0"},


                       nil];
    self.itemWidthArray = [NSMutableArray array];

    /*
     计算每个item的宽度
     */
    for (NSInteger i = 0; i < self.itemsArray.count; i++) {
        UIFont *font = [[UIFont alloc] init];
        if ([self.itemsArray[i][@"type_level"] isEqualToString:@"1"]) {
            font = [UIFont fontWithName:@"PingFangSC-Medium" size:15.0];
        }
        else if ([self.itemsArray[i][@"type_level"] isEqualToString:@"2"]) {
            font = [UIFont fontWithName:@"PingFangSC-Regular" size:14.0];
        }
        CGSize size = [self sizeWithText:self.itemsArray[i][@"title"] font:font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        CGFloat width = size.width + 30.0;
        [self.itemWidthArray addObject:[NSNumber numberWithFloat:width]];
    }
    
    /*
     计算每行内有几个item，并且存进数组sectionArray和sectionObjArray里
     */
    CGFloat itemsWidth = 0.;
    self.sectionArray = [NSMutableArray array];
    self.sectionObjArray = [NSMutableArray array];
    NSMutableArray *itemsInSection= [NSMutableArray array];
    NSMutableArray *objInSection= [NSMutableArray array];
    for (NSInteger item = 0; item < self.itemsArray.count; item ++) {
        itemsWidth = itemsWidth + [self.itemWidthArray[item] floatValue] + self.interItemSpacing;
        if (itemsWidth <= 320. + self.interItemSpacing) {
            [itemsInSection addObject:self.itemWidthArray[item]];
            [objInSection addObject:self.itemsArray[item]];
        }
        else {
            [self.sectionArray addObject:itemsInSection];
            [self.sectionObjArray addObject:objInSection];
            item --;
            itemsInSection = [NSMutableArray array];
            objInSection = [NSMutableArray array];
            itemsWidth = 0.;
        }
    }
    NSInteger number = 0;
    for (NSInteger i = 0; i < self.sectionArray.count; i++) {
        number = ((NSMutableArray *)self.sectionArray[i]).count + number;
    }
    if (number < self.itemWidthArray.count) {
        itemsInSection = [NSMutableArray array];
        objInSection = [NSMutableArray array];
        for (NSInteger i = number; i < self.itemWidthArray.count; i ++) {
            [itemsInSection addObject:self.itemWidthArray[i]];
            [objInSection addObject:self.itemsArray[i]];
        }
        [self.sectionArray addObject:itemsInSection];
        [self.sectionObjArray addObject:objInSection];
    }
    
    /*
     自定义layout
     */
    LHLayout *layout = [[LHLayout alloc] init];
    layout.lineSpacing = self.lineSpacing;
    layout.interItemSpacing = self.interItemSpacing;
    layout.sectionArray = self.sectionArray;
    layout.maxWidthOfSection = self.maxWidthOfSection;
    
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, (self.view.frame.size.height - (self.sectionArray.count * (40 + self.lineSpacing) - self.lineSpacing)) / 2, self.view.frame.size.width, self.sectionArray.count * (40 + self.lineSpacing) - self.lineSpacing) collectionViewLayout:layout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:collectionView];
    
    /*
     注册cell
     */
    [collectionView registerNib:[UINib nibWithNibName:[LHCollectionViewCell cellIdentifier] bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:[LHCollectionViewCell cellIdentifier]];
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    NSDictionary *attrs = @{NSFontAttributeName: font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.sectionArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LHCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[LHCollectionViewCell cellIdentifier] forIndexPath:indexPath];
    
    NSMutableArray *sectionArray = (NSMutableArray *)self.sectionObjArray[indexPath.section];
    NSMutableDictionary *item = (NSMutableDictionary *)sectionArray[indexPath.item];
    NSString *title = [item objectForKey:@"title"];
    cell.titleLabel.text = title;

    NSString *typeLevel = [item objectForKey:@"type_level"];
    cell.typeLevel = [typeLevel integerValue];
    
    NSString *selected = [item objectForKey:@"selected"];
    cell.select = selected;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    LHCollectionViewCell * cell = (LHCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    NSMutableArray *sectionArray = (NSMutableArray *)self.sectionObjArray[indexPath.section];
    NSMutableDictionary *item = (NSMutableDictionary *)sectionArray[indexPath.item];
    NSMutableDictionary *newItem = [NSMutableDictionary dictionary];
    [newItem setObject:[item objectForKey:@"type_level"] forKey:@"type_level"];
    [newItem setObject:[item objectForKey:@"title"] forKey:@"title"];
    [newItem setObject:[item objectForKey:@"type"] forKey:@"type"];
    NSString *selected = [item objectForKey:@"selected"];
    if ([selected isEqualToString:@"1"]) {
        [newItem setObject:@"0" forKey:@"selected"];
        cell.select = @"0";
    }
    else if ([selected isEqualToString:@"0"]) {
        [newItem setObject:@"1" forKey:@"selected"];
        cell.select = @"1";
    }
    ((NSMutableArray *)self.sectionObjArray[indexPath.section])[indexPath.item] = newItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
