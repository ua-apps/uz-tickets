//
//  UZTScanView.m
//  UZTickets
//
//  Created by nekoi on 6/1/15.
//  Copyright (c) 2015 DAloG ltd. All rights reserved.
//

#import "UZTScanView.h"

@interface UZTScanView ()

@property AVCaptureVideoPreviewLayer* layer;

@end

@implementation UZTScanView
@dynamic layer;

+ (Class)layerClass
{
    return [AVCaptureVideoPreviewLayer class];
}

- (instancetype)init
{
    self = [super init];
    if (self == nil) return nil;
    
    self.layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    return self;
}

- (void)setSession:(AVCaptureSession *)session
{
    if (session == self.layer.session) return;
    
    self.layer.session = session;
}

- (AVCaptureSession *)session
{
    return self.layer.session;
}

@end
