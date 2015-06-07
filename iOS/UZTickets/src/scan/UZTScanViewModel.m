//
//  UZTScanViewModel.m
//  UZTickets
//
//  Created by Алексей Демедецкий on 01.06.15.
//  Copyright (c) 2015 DAloG ltd. All rights reserved.
//

#import "UZTScanViewModel.h"
#import "UZTTicketInfo.h"

@implementation UZTScanViewModel

- (void)didScanQRCode:(NSString *)codeContents
{
    UZTTicketInfo* newTicketInfo = [UZTTicketInfo newWithString:codeContents];
    NSLog(@"Ticket scanned: %@", newTicketInfo.infoString);
}

@end
