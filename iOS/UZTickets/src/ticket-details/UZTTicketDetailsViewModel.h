//
//  UZTTicketDetailsViewModel.h
//  UZTickets
//
//  Created by Kostya Bychkov on 7/2/15.
//  Copyright (c) 2015 DAloG ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UZTTicketInfo;

NS_ASSUME_NONNULL_BEGIN
@interface UZTTicketDetailsViewModel : NSObject

@property (nonnull, readonly) NSData* qrData;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

+ (instancetype)newWithTicket:(UZTTicketInfo*)ticket;

@end
NS_ASSUME_NONNULL_END
