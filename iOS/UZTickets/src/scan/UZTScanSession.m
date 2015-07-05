//
//  UZTScanSession.m
//  UZTickets
//
//  Created by Алексей Демедецкий on 01.06.15.
//  Copyright (c) 2015 DAloG ltd. All rights reserved.
//

#import "UZTScanSession.h"
@import AVFoundation;

@interface UZTScanSession ()<AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong) UZTScanSessionCallback currentCallback;

@property AVCaptureDevice* device;
@property AVCaptureDeviceInput* deviceInput;
@property AVCaptureMetadataOutput* metadataOutput;
@property AVCaptureSession* session;

@property AVCaptureVideoPreviewLayer* previewLayer;

@end

@implementation UZTScanSession

- (instancetype)init
{
    self = [super init];
    if (self == nil) return nil;
    
    [self setupAV];
    [self configureAV];
    
    return self;
}

- (CALayer *)layer
{
    return self.previewLayer;
}

- (void)setupAV
{
    /* Setup device */ {
        self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        NSAssert(self.device != nil, @"No video device detected");
    }
    
    /* Setup device input */ {
        NSError* error = nil;
        self.deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:self.device
                                                                 error:&error];
        NSAssert(error == nil, @"Error during input inititialization");
        NSAssert(self.deviceInput != nil, @"Mising device inout");
    }

    self.metadataOutput = [AVCaptureMetadataOutput new];
    self.session = [AVCaptureSession new];
    self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
}

- (void)configureAV
{
    NSAssert([self.session canAddInput:self.deviceInput], @"Device input cannot be added");
    [self.session addInput:self.deviceInput];
    
    NSAssert([self.session canAddOutput:self.metadataOutput], @"Metadata output cannot be added");
    [self.session addOutput:self.metadataOutput];
    
    self.metadataOutput.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
    [self.metadataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    [self.previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
}

- (void)startScanningWithCallback:(UZTScanSessionCallback)callback
{
    NSAssert(!self.session.isRunning, @"Session already started");
    NSAssert(self.currentCallback == nil, @"Callback is not correctly erased");
    
    NSParameterAssert(callback != nil);
    
    [self.session startRunning];
    self.currentCallback = callback;
}

- (void)stopScanning
{
    NSAssert(self.session.isRunning, @"Session not started yet");
    self.currentCallback = nil;
}

- (void)
captureOutput:(AVCaptureOutput *)captureOutput
didOutputMetadataObjects:(NSArray *)metadataObjects
fromConnection:(AVCaptureConnection *)connection
{
    AVMetadataMachineReadableCodeObject* result = [metadataObjects lastObject];
    self.currentCallback(result.stringValue);
}

@end
