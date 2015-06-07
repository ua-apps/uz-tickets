//
//  UZTScanSession.h
//  UZTickets
//
//  Created by Алексей Демедецкий on 01.06.15.
//  Copyright (c) 2015 DAloG ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CALayer;

typedef void(^UZTScanSessionCallback)(NSString* result);
@interface UZTScanSession : NSObject

@property (nonatomic, readonly) CALayer* layer;

- (void)startScanningWithCallback:(UZTScanSessionCallback)callback;
- (void)stopScanning;

@end
