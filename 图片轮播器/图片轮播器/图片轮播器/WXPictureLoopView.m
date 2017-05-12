//
//  WXPictureLoopView.m
//  图片轮播器
//
//  Created by 陈伟鑫 on 2017/5/11.
//  Copyright © 2017年 陈伟鑫. All rights reserved.
//

#import "WXPictureLoopView.h"
#import "WXPictureLoopFlowLayout.h"
#import "WXPictureLoopCellView.h"
#import "UIImage+WXImageCategory.h"

NSString * const kCellIdentifity = @"WXPictureLoopCellIdentifity";


@interface WXPictureLoopView()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSArray *_imgArray;
    NSTimeInterval _timeInterval;
    ClickBlock _clickBlock;
}
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation WXPictureLoopView

- (instancetype)initWithFrame:(CGRect)frame
                     imageArr:(NSArray *)imageArr
                   ClickBlock:(ClickBlock)block {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _timeInterval = 3.0;
        _imgArray = imageArr;
        _clickBlock = block;
        [self initCollectionView];
        [self initTimer];
        [self initPageControl];
    }
    return self;
}
- (void)initCollectionView {
    _collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:[[WXPictureLoopFlowLayout alloc]init]];
    [_collectionView registerClass:[WXPictureLoopCellView class] forCellWithReuseIdentifier:kCellIdentifity];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self addSubview:_collectionView];
    // [0,1,2][3,4,5]
    if (_imgArray.count > 1) {
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_imgArray.count inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    }
    
}

- (void)initTimer {
    if (_imgArray.count > 1) {
        [_timer invalidate];
        _timer = [NSTimer scheduledTimerWithTimeInterval:_timeInterval target:self selector:@selector(automaticScroll) userInfo:nil repeats:YES];
        NSRunLoop *runloop = [NSRunLoop currentRunLoop];
        [runloop addTimer:_timer forMode:NSRunLoopCommonModes];
    }
}

- (void)initPageControl {
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, self.bounds.size.height - 20 - 10, self.bounds.size.width, 20)];
    _pageControl.hidesForSinglePage = YES;
    _pageControl.numberOfPages = _imgArray.count;
    _pageControl.currentPage = 0;
    _pageControl.pageIndicatorTintColor = [UIColor grayColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    [self addSubview:_pageControl];
}
- (void)automaticScroll {
    
    // 获取当前停止的页面
    NSUInteger offset = _collectionView.contentOffset.x / _collectionView.bounds.size.width;
    
    // 如果是最后一页
    if (offset == ([_collectionView numberOfItemsInSection:0] - 1)) {
        // 最后一页， 跳转到第一组的最后一页
        offset = _imgArray.count - 1;
        _collectionView.contentOffset = CGPointMake(offset * _collectionView.bounds.size.width, 0);
    }
    // 滑动到下一页
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:(++offset) inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    
    _pageControl.currentPage = offset % _imgArray.count;
    
}

#pragma mark -- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (_imgArray.count > 1) {
        return _imgArray.count * 10;
    }
    else {
        return 1;
    }
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WXPictureLoopCellView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifity forIndexPath:indexPath];
    [cell setImageView:_imgArray[indexPath.row % _imgArray.count]];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    _clickBlock(indexPath.row % _imgArray.count);
}
#pragma mark -- UIScrollViewDelegate
// 开始拖动
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    // 停止定时器
    [_timer invalidate];
}
// 停止拖动开启定时器
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self initTimer];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 获取当前停止的页面
    NSUInteger offset = scrollView.contentOffset.x / scrollView.bounds.size.width;
    _pageControl.currentPage = offset % _imgArray.count;
}
// 停止滚动时候调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 获取当前停止的页面
    NSUInteger offset = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    // 如果是第一页或者最后一页
    if (offset == 0 || offset == ([_collectionView numberOfItemsInSection:0] - 1)) {
        NSLog(@"第%@页",@(offset));
        
        // 如果是第0页，跳转到第二组第0页
        if (offset == 0) {
            offset = _imgArray.count;
        }
        else {
            // 最后一页， 跳转到第一组的最后一页
            offset = _imgArray.count - 1;
        }
        scrollView.contentOffset = CGPointMake(offset * scrollView.bounds.size.width, 0);
    }
    _pageControl.currentPage = offset % _imgArray.count;
}


#pragma mark -- setter
- (void)setPageControlCurrentColor:(UIColor *)pageControlCurrentColor {
    _pageControl.currentPageIndicatorTintColor = pageControlCurrentColor;
}
- (void)setPageControlDefaultColor:(UIColor *)pageControlDefaultColor {
    _pageControl.pageIndicatorTintColor = pageControlDefaultColor;
}
- (void)setTimerInterval:(NSTimeInterval)timerInterval {
    _timeInterval = timerInterval;
    [self initTimer];
}
- (void)setImageArray:(NSArray *)imageArray {
    _imgArray = imageArray;
    _pageControl.numberOfPages = imageArray.count;
    if (imageArray.count > 1) {
        [self initTimer];
    }
    else {
        [_timer invalidate];
    }
    [_collectionView reloadData];
}
@end
