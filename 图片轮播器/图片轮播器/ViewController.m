//
//  ViewController.m
//  图片轮播器
//
//  Created by 陈伟鑫 on 2017/5/11.
//  Copyright © 2017年 陈伟鑫. All rights reserved.
//

#import "ViewController.h"
#import "WXPictureLoopView.h"
#import "UIImage+WXImageCategory.h"
@interface ViewController ()
{
    WXPictureLoopView *_bannerview;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    
    NSArray *imageArray = @[@"banner1",@"banner2",@"banner3"];
    WXPictureLoopView *view = [[WXPictureLoopView alloc]initWithFrame:CGRectMake(0, 60, self.view.bounds.size.width, 200) imageArr:imageArray ClickBlock:^(NSUInteger index) {
        NSLog(@"%@",@(index));
    }];
    [self.view addSubview:view];
    _bannerview = view;
    
    
    
    UIButton *bt = [[UIButton alloc]initWithFrame:CGRectMake(100, 280, 100, 50)];
    [bt setTitle:@"获取网络" forState:UIControlStateNormal];
    [bt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [bt.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [bt addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bt];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)test {
    NSArray *urArray = @[@"http://pic.58pic.com/58pic/17/69/40/557a0d55806ee_1024.jpg",
                         @"http://pic2.ooopic.com/12/88/42/86b1OOOPICc3.jpg",
                         @"http://pic.58pic.com/58pic/17/09/05/11Q58PICB9t_1024.jpg",
                         @"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=3338108232,2277329305&fm=23&gp=0.jpg"
                         ];
    _bannerview.imageArray = urArray;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
