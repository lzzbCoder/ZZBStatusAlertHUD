//
//  ViewController.m
//  ZZBStatusAlertHUD
//
//  Created by mac on 15/8/5.
//  Copyright (c) 2015年 zzb. All rights reserved.
//

#import "ViewController.h"
#import "ZZBStatusAlertHUD.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}
/**
 *  成功
 */
- (IBAction)success {
    
    [ZZBStatusAlertHUD showSuccess:@"成功！"];
}

/**
 *  失败
 */
- (IBAction)error {
    
    [ZZBStatusAlertHUD showError:@"失败！"];
    
}

/**
 *  提示
 */
- (IBAction)alert {
    
    [ZZBStatusAlertHUD showMessage:@"提示一下下！"];
    
}

/**
 *  加载中
 */
- (IBAction)loading {
    
    [ZZBStatusAlertHUD showLoading:@"正在努力加载...."];
}

/**
 *  隐藏
 */
- (IBAction)hide {
    
    [ZZBStatusAlertHUD hide];
}

@end
