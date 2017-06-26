//
//  CYScanHelper.h
//  BarCodeHelper
//
//  Created by louchu on 2017/6/26.
//  Copyright © 2017年 Cy Lou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void (^CYScanSuccessBlock)(NSString *scanResult);

@interface CYScanHelper : NSObject
+ (instancetype)manager;
@property (nonatomic, strong) UIView *scanView;
@property (nonatomic, copy) CYScanSuccessBlock scanBlock;
- (void)startScanning;
- (void)stopScanning;
- (void)showLayer:(UIView *)viewContainer;
- (void)setScanningRect:(CGRect)scanRect scanView:(UIView *)scanView;

@end
