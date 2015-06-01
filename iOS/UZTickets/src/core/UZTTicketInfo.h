//
//  UZTTicketInfo.h
//  UZTickets
//
//  Created by Алексей Демедецкий on 01.06.15.
//  Copyright (c) 2015 DAloG ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

/** Class for storing raw information of ticket
 
 This class responsible for parsing information from QR code payload.
 
 @c newWithString: should be used for creating.
 */
@interface UZTTicketInfo : NSObject

// Direct calls are blocked for uasbility reasons.
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)newWithString:(NSString*)infoString;

/** String that was used for generating info. 
 
 This string can be useful for reverse QR-code generation.
 */
@property (readonly) NSString* infoString;

/** Train number and short description.
 
 Example: "063 ОА ФІРМ НШ"

 @todo This string can be parsed up to train number, name and some meta info
 */
@property (readonly) NSString* trainName;

/** Departure station code and name
 
 Example: "(2204001) ХАРЬКОВ-ПАСС"
 
 @todo This string can be parsed up to station code and name. 
 Code can be used for GPS binding etc.
 */
@property (readonly) NSString* departureStation;

/** Arrival station code and name
 
 Format and purpose of this field is identical to @c departureStation
 */
@property (readonly) NSString* arrivalStation;

/** Date and time of departure
 
 This date should be recreated from next text format: "22.11 22:20".
 This format exclude year, and we need to calcuate year by ourselfes.
 Tickets are valid 45 days @i before departure date and 90 days @i after arrival date.
 
 @bug Not implemented
 */
@property (readonly) NSDate* departureTime;

/** Date and time of arrival
 
 Format is identical to @c departureTime
 
 @bug Not implemented
 */
@property (readonly) NSDate* arrivalTime;

/** Wagon number 
 */
@property (readonly) NSNumber* wagonNumber;

/** Short wagon description
 */
@property (readonly) NSString* wagonType;

/** Seat number
 
 This number can be used for detecting position inside wagon.
 */
@property (readonly) NSNumber* seatNumber;

/** Seat type
 
 This type is describes payment details, as far as I know.
 */
@property (readonly) NSString* seatType;

/** Passenger name
 */
@property (readonly) NSString* passengerFullname;

/** Ticket code
 
 This code is used for ticket validation
 */
@property (readonly) NSString* ticketCode;

@end
