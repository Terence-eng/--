//
//  UIImage+WXImageCategory.h
//  图片轮播器
//
//  Created by 陈伟鑫 on 2017/5/11.
//  Copyright © 2017年 陈伟鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (WXImageCategory)

/**
 生成指定大小的图
 非等比缩放，生成的图片可能会被拉伸

 @param size 指定图片的size
 @param block 将新的图片通过block回调
 */
- (void)wx_scaleImageToSize:(CGSize)size
               CompletBlock:(void (^)(UIImage *newimage))block;


/**
 等比例缩放图片

 @param size 指定图片的size
 @param block 将新的图片通过block回调
 */
- (void)wx_cropEqualScaleImageToSize:(CGSize)size
                        CompletBlock:(void(^)(UIImage *newImage))block;
@end
