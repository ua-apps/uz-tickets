//
//  UZTTicketsListViewModel.m
//  UZTickets
//
//  Created by Kostya Bychkov on 6/11/15.
//  Copyright (c) 2015 DAloG ltd. All rights reserved.
//

#import "UZTTicketsListViewModel.h"
#import "UZTTicketInfo.h"


@interface UZTTicketsListViewModel ()

@property NSArray* tickets;

@end

@implementation UZTTicketsListViewModel

- (nonnull instancetype)init
{
    self = [super init];
    
    _tickets = @[
                 [UZTTicketInfo newWithString:@"063 ОА ФІРМ НШ (2204001) ХАРЬКОВ-ПАСС (2200001) КИЕВ-ПАССАЖИРСКИЙ 22.11 22:20 23.11 07:07 01 КБ 027 Повний .......... АЛЕКСЕЙ ДЕМЕДЕЦКИЙ MПC 0.00 000B37D3-61738C35-0001 50182 CBCE3F97619DA86CF45297C1D8ABB3ED75D1A0CD"],
                 [UZTTicketInfo newWithString:@"063 ОА ФІРМ НШ (2204001) ХАРЬКОВ-ПАСС (2200001) КИЕВ-ПАССАЖИРСКИЙ 22.11 22:20 23.11 07:07 01 КБ 027 Повний .......... АЛЕКСЕЙ ДЕМЕДЕЦКИЙ MПC 0.00 000B37D3-61738C35-0001 50182 CBCE3F97619DA86CF45297C1D8ABB3ED75D1A0CD"]];
    
    return self;
}

@end
