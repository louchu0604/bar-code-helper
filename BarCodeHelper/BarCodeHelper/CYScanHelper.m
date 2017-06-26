//
//  CYScanHelper.m
//  BarCodeHelper
//
//  Created by louchu on 2017/6/26.
//  Copyright © 2017年 Cy Lou. All rights reserved.
//

#import "CYScanHelper.h"
#import <AVFoundation/AVFoundation.h>
@interface CYScanHelper()<AVCaptureMetadataOutputObjectsDelegate>
{
    AVCaptureSession *_session;
    AVCaptureVideoPreviewLayer *_layer;
    AVCaptureMetadataOutput *_output;
    AVCaptureDeviceInput *_input;
    UIView *_superView;
    UIAlertView *_resultAlert;
}
@end
@implementation CYScanHelper
+ (instancetype)manager
{
    static CYScanHelper *singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[CYScanHelper alloc] init];
    });
    return singleton;
}
- (id)init
{
    self = [super init];
    if (self) {
        _session = [[AVCaptureSession alloc]init];
        [_session setSessionPreset:AVCaptureSessionPresetHigh];
        
        if (!TARGET_IPHONE_SIMULATOR) {
            AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
            
            _input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
            [_session addInput:_input];
            
            _output = [[AVCaptureMetadataOutput alloc]init];
            
            dispatch_queue_t dispatchQueue;
            dispatchQueue = dispatch_queue_create("myQueue", NULL);
            
            [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
//            [_output setMetadataObjectsDelegate:self queue:dispatchQueue];

            [_session addOutput:_output];
            
            _output.metadataObjectTypes = @[
//                                            AVMetadataObjectTypeQRCode,
                                            AVMetadataObjectTypeCode39Code,
                                            AVMetadataObjectTypeCode128Code,
                                            AVMetadataObjectTypeCode39Mod43Code,
                                            AVMetadataObjectTypeEAN13Code,
                                            AVMetadataObjectTypeEAN8Code,
                                            AVMetadataObjectTypeCode93Code,
                                            AVMetadataObjectTypeUPCECode
                                            ];
            
            _layer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
            _layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
            
        }
        
        
        
    }
    
    
    
    return self;
}
- (void)startScanning
{
    if (!TARGET_IPHONE_SIMULATOR) {
        [_session startRunning];
    }
}
- (void)stopScanning
{
    if (!TARGET_IPHONE_SIMULATOR) {
        [_session stopRunning];
    }
}
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if (metadataObjects.count>0) {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        if (self.scanBlock) {
            self.scanBlock(metadataObject.stringValue);
        }
        [self stopScanning];
//        NSLog(@"--------%@",metadataObject.stringValue);
     

    }else
    {
        NSLog(@"no result");
    }
}
- (void)setScanningRect:(CGRect)scanRect scanView:(UIView *)scanView
{
    CGFloat x,y,width,height;
    x = scanRect.origin.y/_layer.frame.size.height;
    y = scanRect.origin.x/_layer.frame.size.width;
    width = scanRect.size.height/_layer.frame.size.height;
    height = scanRect.size.width/_layer.frame.size.width;
    
    _output.rectOfInterest = CGRectMake(x, x, width, height);
    
    self.scanView = scanView;
    if (self.scanView) {
        self.scanView.frame = scanRect;
        if (_superView) {
            [_superView addSubview:self.scanView];
        }
    }

}
- (void)showLayer:(UIView *)viewContainer
{
    _superView = viewContainer;
    _layer.frame = _superView.layer.frame;
    [_superView.layer insertSublayer:_layer atIndex:0];
}
@end
