//
//  ZZBStatusAlertHUD.m
//  ZZBStatusAlertHUD
//
//  Created by mac on 15/8/5.
//  Copyright (c) 2015年 zzb. All rights reserved.
//

#import "ZZBStatusAlertHUD.h"

@implementation ZZBStatusAlertHUD


/** 字体的大小 */
static CGFloat const TextFont = 16;
/** 消息的停留时间 */
static CGFloat const ZZBMessageDuration = 2.5;
/** 消息显示\隐藏的动画时间 */
static CGFloat const ZZBAnimationDuration = 0.25;

/** 全局的窗口 */
static UIWindow *window;
/** 定时器 */
static NSTimer *timer;

/**
 * 显示窗口
 */
+ (void)showWindow
{
    // 弹出框显示高度
    CGFloat windowH = 80;
    CGRect frame = CGRectMake(0, - windowH, [UIScreen mainScreen].bounds.size.width, windowH);
    
    // 显示窗口
    window.hidden = YES;
    window = [[UIWindow alloc] init];
    window.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
    window.windowLevel = UIWindowLevelAlert;
    window.frame = frame;
    window.hidden = NO;

    // 动画
    frame.origin.y = 0;
    [UIView animateWithDuration:ZZBAnimationDuration animations:^{
        window.frame = frame;
    }];
}

/**
 * 显示普通信息
 * @param msg       文字
 * @param image     图片
 */
+ (void)showMessage:(NSString *)msg image:(UIImage *)image
{
    // 停止定时器
    [timer invalidate];
    
    // 显示窗口
    [self showWindow];
    
    // 添加按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:msg forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:TextFont];
    [button setImage:image forState:UIControlStateNormal];
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    button.frame = window.bounds;
    [window addSubview:button];
    
    // 定时器
    timer = [NSTimer scheduledTimerWithTimeInterval:ZZBMessageDuration target:self selector:@selector(hide) userInfo:nil repeats:NO];
}

/**
 * 显示普通信息
 */
+ (void)showMessage:(NSString *)msg
{
    [self showMessage:msg image:[UIImage imageNamed:@"ZZBStatusHUD.bundle/message"]];
}

/**
 * 显示成功信息
 */
+ (void)showSuccess:(NSString *)msg
{
    [self showMessage:msg image:[UIImage imageNamed:@"ZZBStatusHUD.bundle/success"]];
}

/**
 * 显示失败信息
 */
+ (void)showError:(NSString *)msg
{
    [self showMessage:msg image:[UIImage imageNamed:@"ZZBStatusHUD.bundle/error"]];
}

/**
 * 显示正在处理的信息
 */
+ (void)showLoading:(NSString *)msg
{
    // 停止定时器
    [timer invalidate];
    timer = nil;
    
    // 显示窗口
    [self showWindow];
    
    // 添加文字
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont boldSystemFontOfSize:TextFont];;
    label.frame = window.bounds;
    label.textAlignment = NSTextAlignmentCenter;
    label.text = msg;
    label.textColor = [UIColor whiteColor];
    [window addSubview:label];
    
    // 添加加载中的图形
    UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [loadingView startAnimating];
    
    // 文字宽度
    CGFloat msgW = [msg sizeWithAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:TextFont]}].width;
    CGFloat centerX = (window.frame.size.width - msgW) * 0.5 - 20;
    CGFloat centerY = window.frame.size.height * 0.5;
    loadingView.center = CGPointMake(centerX, centerY);
    [window addSubview:loadingView];
}

/**
 * 隐藏
 */
+ (void)hide
{
    [UIView animateWithDuration:ZZBAnimationDuration animations:^{
        CGRect frame = window.frame;
        frame.origin.y =  - frame.size.height;
        window.frame = frame;
    } completion:^(BOOL finished) {
        window = nil;
        timer = nil;
    }];
}


@end
