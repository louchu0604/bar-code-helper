//
//  ViewController.m
//  BarCodeHelper
//
//  Created by louchu on 2017/6/26.
//  Copyright © 2017年 Cy Lou. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)clickCopy
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
//    pasteboard.string =[_data valueForKey:@"url"];
//    
//    [SVProgressHUD showSuccessWithStatus:@"拷贝成功"];
}

@end
