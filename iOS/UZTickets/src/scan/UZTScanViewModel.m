//
//  UZTScanViewModel.m
//  UZTickets
//
//  Created by Алексей Демедецкий on 01.06.15.
//  Copyright (c) 2015 DAloG ltd. All rights reserved.
//

#import "UZTScanViewModel.h"
#import "UZTTicketInfo.h"

@interface UZTScanViewModel ()

@property UZTTicketInfo* scannedTicket;

@end

@implementation UZTScanViewModel

- (void)didScanQRCode:(NSString *)codeContents
{
    self.scannedTicket = [UZTTicketInfo newWithString:codeContents];
}

@end
