//
//  UZTScanViewModel.h
//  UZTickets
//
//  Created by Алексей Демедецкий on 01.06.15.
//  Copyright (c) 2015 DAloG ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UZTTicketInfo;
@interface UZTScanViewModel : NSObject

@property (readonly) UZTTicketInfo* scannedTicket;

- (void)didScanQRCode:(NSString*)codeContents;

@end
