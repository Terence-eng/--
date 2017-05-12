//
//  WXPictureLoopCellView.m
//  图片轮播器
//
//  Created by 陈伟鑫 on 2017/5/11.
//  Copyright © 2017年 陈伟鑫. All rights reserved.
//

#import "WXPictureLoopCellView.h"
#import "UIImage+WXImageCategory.h"
#import "UIImageView+WebCache.h"

@interface WXPictureLoopCellView ()
{
    UIImageView *_imageView;
}

@end
@implementation WXPictureLoopCellView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _imageView = [[UIImageView alloc]initWithFrame:self.contentView.bounds];
        [self.contentView addSubview:_imageView];
    }
    return self;
}
- (void)setImageView:(NSString *)imageName{
    if ([imageName hasPrefix:@"http"]) {
        [_imageView sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:[UIImage imageNamed:@""] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            [image wx_scaleImageToSize:self.contentView.bounds.size CompletBlock:^(UIImage *newimage) {
                _imageView.image = newimage;
            }];
        }];
    }
    else {
        UIImage *image = [UIImage imageNamed:imageName];
        _imageView.image = image;
        [image wx_scaleImageToSize:self.contentView.bounds.size CompletBlock:^(UIImage *newimage) {
            _imageView.image = newimage;
        }];
    }
}
@end
