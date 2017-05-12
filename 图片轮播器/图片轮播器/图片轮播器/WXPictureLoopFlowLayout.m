//
//  WXPictureLoopFlowLayout.m
//  图片轮播器
//
//  Created by 陈伟鑫 on 2017/5/11.
//  Copyright © 2017年 陈伟鑫. All rights reserved.
//

#import "WXPictureLoopFlowLayout.h"

@implementation WXPictureLoopFlowLayout

// 在collectionView 的第一次布局的时候被调用，此时 collectionView 的frame 已经设置好了
- (void)prepareLayout {
    // 一定要调用[super prepareLayout]
    [super prepareLayout];
    
    self.itemSize = self.collectionView.bounds.size;
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal; //水平滚动
    self.collectionView.bounces = NO; // 取消弹簧效果
    self.collectionView.pagingEnabled = YES; // 分页
    self.collectionView.backgroundColor = [UIColor whiteColor];
    // 隐藏滚动条
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
}
@end
