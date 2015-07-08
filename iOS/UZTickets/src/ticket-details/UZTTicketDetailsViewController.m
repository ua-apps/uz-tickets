//
//  UZTTicketDetailViewController.m
//  UZTickets
//
//  Created by Kostya Bychkov on 7/2/15.
//  Copyright (c) 2015 DAloG ltd. All rights reserved.
//

#import "UZTTicketDetailsViewController.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
@import CoreImage;
@import QuartzCore;

#import "UZTTicketDetailsViewModel.h"

@interface UZTTicketDetailsViewController ()

@property IBOutlet UIImageView* qrCodeImageView;
@property CGFloat brightness;

@end

@implementation UZTTicketDetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CIContext* context = [CIContext contextWithOptions:nil];
    CIFilter* filter = [CIFilter filterWithName:@"CIQRCodeGenerator"
                            withInputParameters:@{@"inputMessage": self.viewModel.qrData,
                                                  @"inputCorrectionLevel": @"M"}];
    CGRect initialCodeRect = filter.outputImage.extent;
    CGFloat scaleFactor = [UIScreen mainScreen].scale;
    CGSize resultImageSize = CGSizeMake(300*scaleFactor, 300*scaleFactor);
    CGAffineTransform scaleImageTransform = CGAffineTransformMakeScale(resultImageSize.width/initialCodeRect.size.width,
                                                                       resultImageSize.height/initialCodeRect.size.height);
    CIImage* qrCodeImage = [filter.outputImage imageByApplyingTransform:scaleImageTransform];
    CGImageRef image = [context createCGImage:qrCodeImage
                                     fromRect:qrCodeImage.extent];
    self.qrCodeImageView.image = [UIImage imageWithCGImage:image
                                                     scale:2
                                               orientation:UIImageOrientationUp];
    CGImageRelease(image);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.brightness = [UIScreen mainScreen].brightness;
    
    [[UIScreen mainScreen] setBrightness:1.];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[UIScreen mainScreen] setBrightness:self.brightness];
    
    [super viewWillDisappear:animated];
}

@end
