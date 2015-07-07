//
//  UZTScanViewController.m
//  UZTickets
//
//  Created by nekoi on 6/1/15.
//  Copyright (c) 2015 DAloG ltd. All rights reserved.
//

#import "UZTScanViewController.h"

#import "UZTScanViewModel.h"
#import "UZTScanSession.h"

#import <ReactiveCocoa/ReactiveCocoa.h>

@interface UZTScanViewController ()

@property UZTScanSession* scanningSession;

@end

@implementation UZTScanViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.scanningSession = [UZTScanSession new];
    [self.view.layer insertSublayer:self.scanningSession.layer atIndex:0];
    
    [self rac_liftSelector:@selector(dismiss) withSignalOfArguments:[[RACObserve(self, viewModel.scannedTicket) filter:^BOOL(id value) {
        return (value != nil);
    }] mapReplace:[RACTuple new]]];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    __weak typeof(self) _self = self;
    [self.scanningSession startScanningWithCallback:^(NSString *result) {
        [_self.viewModel didScanQRCode:result];
    }];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.scanningSession stopScanning];
    [super viewWillDisappear:animated];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.scanningSession.layer.frame = self.view.bounds;
}

- (void)dismiss
{
    [self performSegueWithIdentifier:@"unwind scan" sender:self];
}

@end

