//
//  UIImage+WXImageCategory.m
//  图片轮播器
//
//  Created by 陈伟鑫 on 2017/5/11.
//  Copyright © 2017年 陈伟鑫. All rights reserved.
//

#import "UIImage+WXImageCategory.h"

@implementation UIImage (WXImageCategory)
- (void)wx_scaleImageToSize:(CGSize)size
               CompletBlock:(void (^)(UIImage *newimage))block {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        CGFloat scale = [UIScreen mainScreen].scale;
        // 这里第二个参数是设置图片不透明，设置No表示图片透明，scale表示屏幕分辨率
        UIGraphicsBeginImageContextWithOptions(size, YES, scale);
        [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        if (newImage) {
            dispatch_async(dispatch_get_main_queue(), ^{
                block(newImage);
            });
        }
    });
    
}


- (void)wx_cropEqualScaleImageToSize:(CGSize)size
                        CompletBlock:(void(^)(UIImage *newImage))block {
  
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        CGFloat scale =  [UIScreen mainScreen].scale;
        UIGraphicsBeginImageContextWithOptions(size, NO, scale);
        
        CGSize aspectFitSize = CGSizeZero;
        if (self.size.width != 0 && self.size.height != 0) {
            CGFloat rateWidth = size.width / self.size.width;
            CGFloat rateHeight = size.height / self.size.height;
            
            CGFloat rate = MIN(rateHeight, rateWidth);
            aspectFitSize = CGSizeMake(self.size.width * rate, self.size.height * rate);
            [self drawInRect:CGRectMake(0, 0, aspectFitSize.width, aspectFitSize.height)];
            UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            if (newImage) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    block(newImage);
                });
            }
            
        }
    });

    
}
@end
