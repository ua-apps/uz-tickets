//
//  UZTScanViewModel.h
//  UZTickets
//
//  Created by Алексей Демедецкий on 01.06.15.
//  Copyright (c) 2015 DAloG ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UZTScanViewModel : NSObject

- (void)didScanQRCode:(NSString*)codeContents;

@end
