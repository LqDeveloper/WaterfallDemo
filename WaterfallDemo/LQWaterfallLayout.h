//
//  LQWaterfallLayout.h
//  WaterfallDemo
//
//  Created by liquan on 2017/9/16.
//  Copyright © 2017年 liquan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LQWaterfallLayout : UICollectionViewFlowLayout
@property (weak, nonatomic) id<UICollectionViewDelegateFlowLayout> delegate;
@property (nonatomic, strong) NSMutableArray *itemAttributes;
@property (assign,nonatomic) CGFloat contentHeight;
@end
