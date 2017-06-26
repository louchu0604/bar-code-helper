//
//  ViewController.m
//  BarCodeHelper
//
//  Created by louchu on 2017/6/26.
//  Copyright © 2017年 Cy Lou. All rights reserved.
//

#import "ViewController.h"
#import "CYScanHelper.h"
#import <AudioToolbox/AudioToolbox.h>

@interface ViewController ()
{
    UIAlertView *_resultAlert;

}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CGSize windowSize = [UIScreen mainScreen].bounds.size;
    CGSize scanSize = CGSizeMake(windowSize.width*4/5,windowSize.width*4/5);
    CGRect scanRect = CGRectMake((windowSize.width-scanSize.width)/2,200,scanSize.width , scanSize.height);
    UIView *scanRectView = [UIView new];
    scanRectView.layer.borderColor = [UIColor redColor].CGColor;
    scanRectView.layer.borderWidth = 1;
    UILabel *tip1 = [UILabel new];
    [self.view addSubview:tip1];
    tip1.text = @"加粗：将条码放入框内";
    tip1.font =[UIFont boldSystemFontOfSize:17];
    tip1.frame = CGRectMake((windowSize.width-scanSize.width)/2, 150, scanSize.width, 50);
    tip1.textAlignment = NSTextAlignmentCenter;
    tip1.textColor = [UIColor whiteColor];
    
    UIButton *ss = [UIButton new];
//    [self.view addSubview:ss];
    self.view.userInteractionEnabled = YES;
    ss.frame = CGRectMake(windowSize.width/2-100, windowSize.height-100, 200, 100);
    [ss setTitle:@"重新扫描" forState:0];
    ss.backgroundColor = [UIColor clearColor];
    [ss setTitleColor:[UIColor whiteColor] forState:0];
    ss.enabled = YES;
    

//    开始调用
    [[CYScanHelper manager] showLayer:self.view];
    [[CYScanHelper manager] setScanningRect:scanRect scanView:scanRectView];
    [[CYScanHelper manager] setScanBlock:^(NSString *scanResult){
        NSLog(@"%@", scanResult);
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string =scanResult;
        NSString *str = [NSString stringWithFormat:@"你的条形码是\r%@\r已复制到剪切板",scanResult];
        _resultAlert = [[UIAlertView alloc]initWithTitle:@"请确认" message:str delegate:self cancelButtonTitle:@"不扫了" otherButtonTitles:@"继续扫", nil];
        [_resultAlert show];
        
        AudioServicesPlaySystemSound(1000);
    }];
    
}
- (void)clickScan
{
    NSLog(@"click");
    [[CYScanHelper manager]startScanning];

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (_resultAlert==alertView) {
        if (buttonIndex==1) {
             [[CYScanHelper manager]startScanning];
            NSLog(@"go on");
        }else if (buttonIndex==0)
        {
            NSLog(@"cancel");
        }
    }
}
- (void)viewDidAppear:(BOOL)animated
{
    [[CYScanHelper manager]startScanning];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
