//
//  UZTTicketInfoTests.m
//  UZTickets
//
//  Created by Алексей Демедецкий on 01.06.15.
//  Copyright (c) 2015 DAloG ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "UZTTicketInfo.h"

@interface UZTTicketInfoTests : XCTestCase

@end

NSString* example =
@"063 ОА ФІРМ НШ\n"
@"(2204001) ХАРЬКОВ-ПАСС\n"
@"(2200001) КИЕВ-ПАССАЖИРСКИЙ\n"
@"22.11 22:20\n"
@"23.11 07:07\n"
@"01 КБ\n"
@"027 Повний\n"
@"..........\n"
@"АЛЕКСЕЙ ДЕМЕДЕЦКИЙ\n"
@"MПC\n"
@"\n"
@"0.00\n"
@"\n"
@"\n"
@"000B37D3-61738C35-0001\n"
@"\n"
@"50182\n"
@"CBCE3F97619DA86CF45297C1D8ABB3ED75D1A0CD\n";

@implementation UZTTicketInfoTests

- (void)testInfoFields {
    UZTTicketInfo* info = [UZTTicketInfo newWithString:example];
    
    XCTAssertNotNil(info, @"Check constructor work");
    
    XCTAssertEqualObjects(info.infoString, example);
    
    XCTAssertEqualObjects(info.trainName, @"063 ОА ФІРМ НШ");
    XCTAssertEqualObjects(info.departureStation, @"(2204001) ХАРЬКОВ-ПАСС");
    XCTAssertEqualObjects(info.arrivalStation, @"(2200001) КИЕВ-ПАССАЖИРСКИЙ");
    XCTAssertEqualObjects(info.wagonNumber, @1);
    XCTAssertEqualObjects(info.wagonType, @"КБ");
    XCTAssertEqualObjects(info.seatNumber, @27);
    XCTAssertEqualObjects(info.seatType, @"Повний");
    XCTAssertEqualObjects(info.passengerFullname, @"АЛЕКСЕЙ ДЕМЕДЕЦКИЙ");
    XCTAssertEqualObjects(info.ticketCode, @"000B37D3-61738C35-0001");
}

- (void)testCreationPerformance {
    [self measureBlock:^{
        [UZTTicketInfo newWithString:example];
    }];
}

@end
