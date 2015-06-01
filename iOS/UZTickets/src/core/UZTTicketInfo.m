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
    scanner.charactersToBeSkipped = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    
    NSString*(^scanLine)() = ^() {
        NSString* result;
        [scanner scanUpToCharactersFromSet:newlines intoString:&result];
        
        return result;
    };
    
    NSNumber*(^scanNumber)() = ^() {
        NSInteger result;
        [scanner scanInteger:&result];
        
        return @(result);
    };
    
    _trainName = scanLine();
    
    _departureStation = scanLine();
    _arrivalStation = scanLine();
    
    scanLine(); // skip departure date
    scanLine(); // skip arrival date
    
    _wagonNumber = scanNumber();
    _wagonType = scanLine();
    
    _seatNumber = scanNumber();
    _seatType = scanLine();
    
    scanLine(); // skip "....."
    
    _passengerFullname = scanLine();
   
    scanLine(); // skip "МПС"
    scanLine(); // skip "0.00"
    
    _ticketCode = scanLine();
        
    return self;
}

@end
