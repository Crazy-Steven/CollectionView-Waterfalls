//
//  ViewController.m
//  Waterfalls
//
//  Created by 郭艾超 on 16/9/25.
//  Copyright © 2016年 Steven. All rights reserved.
//

#import "ViewController.h"
#import "MyCollectionViewCell.h"
#import "CollectionLayout.h"

static NSString * const CVCell = @"WaterfallsCell";

@interface ViewController ()<UICollectionViewDataSource>
@property (strong, nonatomic) UICollectionView * myCollectionView;
@property (strong, nonatomic) CollectionLayout * myCVLayout;
@end

@implementation ViewController
#pragma mark - 懒加载
- (UICollectionView *)myCollectionView
{
    if (!_myCollectionView) {
        _myCollectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:self.myCVLayout];
        _myCollectionView.backgroundColor = [UIColor orangeColor];

        [_myCollectionView registerNib:[UINib nibWithNibName:@"MyCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:CVCell];
        
        _myCollectionView.dataSource = self;
    }
    return _myCollectionView;
}

- (CollectionLayout *)myCVLayout {
    if (!_myCVLayout) {
        _myCVLayout = [[CollectionLayout alloc]initOptionWithColumnNum:3 rowSpacing:10.0f columnSpacing:10.0f sectionInset:UIEdgeInsetsMake(20, 10, 10, 10)];
    }
    return _myCVLayout;
}

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.myCollectionView];

    self.myCVLayout.dataArr = [self addData];
}

- (NSArray *)addData {
    NSMutableArray * arr = [NSMutableArray array];
    
    for (int i = 0; i<=16 ; i++) {
        NSString * imageName = [NSString stringWithFormat:@"%d.jpg",i];
        [arr addObject:imageName];
    }
    return arr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UICollectionView dataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.myCVLayout.dataArr.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MyCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CVCell forIndexPath:indexPath];
    
    cell.image.image = [UIImage imageNamed:self.myCVLayout.dataArr[indexPath.row]];

    return cell;
}
@end
