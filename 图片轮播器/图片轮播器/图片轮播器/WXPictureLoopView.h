//
//  WXPictureLoopView.h
//  图片轮播器
//
//  Created by 陈伟鑫 on 2017/5/11.
//  Copyright © 2017年 陈伟鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ClickBlock)(NSUInteger index);
@interface WXPictureLoopView : UIView


/**
 初始化方法

 @param frame frame
 @param imageArr 图片数组，支持url和imageName
 @param block 点击回调
 @return self
 */
- (instancetype)initWithFrame:(CGRect)frame
                     imageArr:(NSArray *)imageArr
                   ClickBlock:(ClickBlock)block;

/**
 重新banner图。可以是url数组， 也可以是imageName数组
 */
@property (nonatomic, strong) NSArray *imageArray;
/**
 UIPageControl 选中颜色
 */
@property (nonatomic, strong) UIColor *pageControlCurrentColor;

/**
 UIPageContro 默认颜色
 */
@property (nonatomic, strong) UIColor *pageControlDefaultColor;

/**
 设置定时器自动滚动间隔
 */
@property (nonatomic, assign) NSTimeInterval timerInterval;
@end
