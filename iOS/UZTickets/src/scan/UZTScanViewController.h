//
//  UZTScanViewController.h
//  UZTickets
//
//  Created by nekoi on 6/1/15.
//  Copyright (c) 2015 DAloG ltd. All rights reserved.
//

@import UIKit;

@protocol UZTScanViewModelProtocol

- (void)didStartInitializingScanView;
- (void)didInitializeScanView;
- (void)didReadQRCode:(NSString*)code;

@end



@interface UZTScanViewController : UIViewController

@property id<UZTScanViewModelProtocol> viewModel;

+ (BOOL)canScan;

@end



@interface UZTScanViewModel : NSObject <UZTScanViewModelProtocol>

@end
