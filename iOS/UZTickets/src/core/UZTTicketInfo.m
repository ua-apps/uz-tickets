//
//  UZTTicketInfo.m
//  UZTickets
//
//  Created by Алексей Демедецкий on 01.06.15.
//  Copyright (c) 2015 DAloG ltd. All rights reserved.
//

#import "UZTTicketInfo.h"

@implementation UZTTicketInfo

+ (instancetype)newWithString:(NSString *)infoString
{
    return [[self alloc] initWithString:infoString];
}

- (instancetype)initWithString:(NSString *)infoString
{
    self = [super init];
    if (self == nil) return nil;
    
    _infoString = infoString;
    
    NSCharacterSet* newlines = [NSCharacterSet newlineCharacterSet];
    
    NSScanner* scanner = [NSScanner scannerWithString:infoString];
    scanner.charactersToBeSkipped = newlines;
    
    NSString* trainName;
    [scanner scanUpToCharactersFromSet:newlines intoString:&trainName];
    
    NSString* departureStation;
    [scanner scanUpToCharactersFromSet:newlines intoString:&departureStation];
    
    NSString* arrivalStattion;
    [scanner scanUpToCharactersFromSet:newlines intoString:&arrivalStattion];
    
    NSString* departureDate;
    [scanner scanUpToCharactersFromSet:newlines intoString:&departureDate];
    
    NSString* arrivalDate;
    [scanner scanUpToCharactersFromSet:newlines intoString:&arrivalDate];
    
    NSInteger wagonNumber;
    [scanner scanInteger:&wagonNumber];
    
    NSString* wagonKind;
    scanner.scanLocation += 1;
    [scanner scanUpToCharactersFromSet:newlines intoString:&wagonKind];
    
    NSInteger seatNumber;
    [scanner scanInteger:&seatNumber];
    
    NSString* seatKind;
    scanner.scanLocation += 1;
    [scanner scanUpToCharactersFromSet:newlines intoString:&seatKind];
    
    [scanner scanUpToCharactersFromSet:newlines intoString:NULL];
    
    NSString* passenger;
    [scanner scanUpToCharactersFromSet:newlines intoString:&passenger];
   
    [scanner scanUpToCharactersFromSet:newlines intoString:NULL];
    [scanner scanUpToCharactersFromSet:newlines intoString:NULL];
    
    NSString* ticketCode;
    [scanner scanUpToCharactersFromSet:newlines intoString:&ticketCode];
    
    _trainName = trainName;
    _departureStation = departureStation;
    _arrivalStation = arrivalStattion;
    _departureTime = nil;
    _arrivalTime = nil;
    _wagonNumber = @(wagonNumber);
    _wagonType = wagonKind;
    _seatNumber = @(seatNumber);
    _seatType = seatKind;
    _passengerFullname = passenger;
    _ticketCode = ticketCode;
    
    return self;
}

@end
