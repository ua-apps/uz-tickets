//
//  UZTScanViewController.m
//  UZTickets
//
//  Created by nekoi on 6/1/15.
//  Copyright (c) 2015 DAloG ltd. All rights reserved.
//

#import "UZTScanViewController.h"
#import "UZTScanView.h"

@interface UZTScanViewController ()<AVCaptureMetadataOutputObjectsDelegate>

@property UZTScanView* view;
@property (strong) AVCaptureMetadataOutput* output;
@property (strong) AVCaptureSession* session;
@property (strong) dispatch_queue_t dispatchQueue;

@end

@implementation UZTScanViewController
@dynamic view;

+ (BOOL)canScan
{
    NSArray* devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    if (devices.count == 0) return NO;
    
    AVCaptureDevice* device;
    
    for (AVCaptureDevice* cameraDevice in devices)
    {
        if (cameraDevice.position == AVCaptureDevicePositionBack)
        {
            device = cameraDevice;
            break;
        }
    }
    
    if (device == nil) return NO;
    
    NSError* inputError;
    AVCaptureDeviceInput* input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&inputError];
    NSAssert(inputError == nil, @"An error occurred while try get AVCaptureDeviceInput: %@", inputError);
    if (inputError != nil) return NO;
    
    AVCaptureSession* session = [AVCaptureSession new];
    if (![session canAddInput:input]) return NO;
    
    return YES;
}

- (void)setupLayerSessionWithAvailableObjects:(NSArray*)availableObjectTypes
{
    [self.viewModel didStartInitializingScanView];
    
    self.dispatchQueue = dispatch_queue_create("UZTScanQueue", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(self.dispatchQueue, ^{
        NSArray* devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
        NSAssert(devices.count > 0, @"There are no device that can capture video input installed on this device");
        
        AVCaptureSession* session = [AVCaptureSession new];
        self.session = session;
        
        AVCaptureMetadataOutput* output = [AVCaptureMetadataOutput new];
        [output setMetadataObjectsDelegate:self queue:self.dispatchQueue];
        output.metadataObjectTypes = nil;
        self.output = output;
        
        AVCaptureDevice* device;
        
        for (AVCaptureDevice* cameraDevice in devices)
        {
            if (cameraDevice.position == AVCaptureDevicePositionBack)
            {
                device = cameraDevice;
                if ([device hasTorch] && [device isTorchModeSupported:AVCaptureTorchModeAuto])
                {
                    NSError *error = nil;
                    if ([device lockForConfiguration:&error])
                    {
                        device.torchMode = AVCaptureTorchModeAuto;
                        [device unlockForConfiguration];
                    }
                    NSAssert(error == nil, @"lock for configuration failed with error: %@", error);
                }
                break;
            }
        }
        NSAssert(device != nil, @"There is no back camera available on this device");
        
        NSError* inputError;
        AVCaptureDeviceInput* input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&inputError];
        NSAssert(inputError == nil, @"An error occurred while try get AVCaptureDeviceInput: %@", inputError);
        
        [self.session beginConfiguration];
        NSAssert([session canAddInput:input], @"Can't add camera device input to session");
        [session addInput:input];
        
        NSAssert([session canAddOutput:output], @"Can't add barcode recognition media output");
        [session addOutput:output];
        
        NSSet* availableOutputObjectTypes = [NSSet setWithArray:output.availableMetadataObjectTypes];
        NSSet* filterObjectTypes = [NSSet setWithArray:availableObjectTypes];
        NSAssert([filterObjectTypes isSubsetOfSet:availableOutputObjectTypes], @"There are object types that can't be handled");
        
        output.metadataObjectTypes = availableObjectTypes;
        [self.session commitConfiguration];
        
        [self.viewModel didInitializeScanView];
    });
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.viewModel = [UZTScanViewModel new];
    
    [self setupLayerSessionWithAvailableObjects:@[AVMetadataObjectTypeQRCode]];
    
    dispatch_async(self.dispatchQueue, ^{
        NSParameterAssert(self.session != nil);
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.view.session = self.session;
        });
    });
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self startScanning];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self stopScanning];
    
    [super viewWillDisappear:animated];
}

- (void)startScanning
{
    dispatch_async(self.dispatchQueue, ^{
        [self.session startRunning];
    });
}

- (void)stopScanning
{
    dispatch_async(self.dispatchQueue, ^{
        [self.session stopRunning];
    });
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    AVMetadataMachineReadableCodeObject* codeObject = metadataObjects.lastObject;
    [self.viewModel didReadQRCode:codeObject.stringValue];
}

@end



@implementation UZTScanViewModel

- (void)didStartInitializingScanView {}
- (void)didInitializeScanView {}
- (void)didReadQRCode:(NSString*)code
{
    
}

@end
