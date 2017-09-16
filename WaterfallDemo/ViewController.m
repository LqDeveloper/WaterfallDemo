//
//  ViewController.m
//  WaterfallDemo
//
//  Created by liquan on 2017/9/16.
//  Copyright © 2017年 liquan. All rights reserved.
//

#import "ViewController.h"
#import "LQWaterfallLayout.h"
#import "Masonry.h"
@interface ViewController ()< UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *widthArr;
@property(nonatomic,assign)CGFloat collectionWidth;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getAllTitleHeight];
    [self.view addSubview:self.collectionView];
   
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(200, 100));
    }];
    
}
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        LQWaterfallLayout *layout = [[LQWaterfallLayout alloc]init];
        layout.delegate = self;
        //layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor redColor];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"collectionViewCell"];
    }
    return _collectionView;
}
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = @[@"麻棉连衣裙", @"面条", @"亲子装",
                       @"面包", @"洗洁精", @"咖啡速溶",
                       @"卫生巾", @"米", @"眉笔", @"蛋糕",
                       @"云南白药牙膏", @"方便面", @"空调"].mutableCopy;
    }
    return _dataArray;
}

-(NSMutableArray *)widthArr{
    if (!_widthArr) {
        _widthArr = [NSMutableArray array];
    }
    return _widthArr;
}
-(void)getAllTitleHeight{
    CGFloat marginWidth = 5;
     _collectionWidth = 200;
    for (NSString *title in self.dataArray) {
        CGSize size  =[self calculateContentSize:title];
        [self.widthArr addObject:@(ceil(size.width+marginWidth))];
    }
    _collectionWidth = _collectionWidth - marginWidth;
    //NSMutableArray *tempArr = self.dataArray;
    
    CGFloat allWidth = [self.widthArr[0] floatValue];
    for (int i=1; i<self.widthArr.count; i++) {
        CGFloat wd = [self.widthArr[i] floatValue];
        if (wd + allWidth <= _collectionWidth) {
            allWidth = allWidth + wd;
        }else{
            if (i < self.widthArr.count - 1) {
                for (NSInteger j = i+1; j < self.widthArr.count; j++) {
                    CGFloat wdj = [self.widthArr[j] floatValue];
                    if (wdj + allWidth <=  _collectionWidth) {
                        [self.dataArray exchangeObjectAtIndex:i withObjectAtIndex:j];
                        [self.widthArr exchangeObjectAtIndex:i withObjectAtIndex:j];
                        allWidth = allWidth + wdj;
                        break;
                    }else{
                        if (j == self.widthArr.count - 1) {
                            allWidth = [self.widthArr[i] floatValue];
                            break;
                        }
                    }
                    
                }

            }//if
            
        }
    }
   /*
    for (int j=i+1; j<self.widthArr.count; j++) {
    CGFloat wd1 = [self.widthArr[i] floatValue];
    CGFloat wd2 = [self.widthArr[j] floatValue];
    if (wd1+wd2 < _collectionWidth) {
    allWidth = wd1 + wd2;
    i++;
    break;
    }
    }*/
    
}




#pragma mark ---collection
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionViewCell" forIndexPath:indexPath];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    UILabel *label = [[UILabel alloc]init];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:16];
    label.text = self.dataArray[indexPath.row];
    label.layer.borderColor = [UIColor greenColor].CGColor;
    label.layer.borderWidth  =1;
    
    [cell.contentView addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(cell.contentView);
    }];
    
    
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGSize size = [self calculateContentSize:self.dataArray[indexPath.row]];

    
    return CGSizeMake(size.width, 20);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 5; //列间距
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 5;//行间距
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 5, 5);
}




- (CGSize)calculateContentSize:(NSString *)str {
    NSDictionary *dict = @{NSFontAttributeName: [UIFont systemFontOfSize:16]};
    CGSize textSize = [str boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 1000)
                                          options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    
    return CGSizeMake(ceil(textSize.width), ceil(textSize.height));
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
