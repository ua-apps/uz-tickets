//
//  UZTTicketInfo.h
//  UZTickets
//
//  Created by Алексей Демедецкий on 01.06.15.
//  Copyright (c) 2015 DAloG ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UZTTicketInfo : NSObject

+ (instancetype)newWithString:(NSString*)infoString;

@property (readonly) NSString* infoString;

@property (readonly) NSString* trainName;
@property (readonly) NSString* departureStation;
@property (readonly) NSString* arrivalStation;
@property (readonly) NSDate* departureTime;
@property (readonly) NSDate* arrivalTime;
@property (readonly) NSNumber* wagonNumber;
@property (readonly) NSString* wagonType;
@property (readonly) NSNumber* seatNumber;
@property (readonly) NSString* seatType;
@property (readonly) NSString* passengerFullname;
@property (readonly) NSString* ticketCode;

@end
