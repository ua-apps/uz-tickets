//
//  UZTTicketDetailsViewModel.m
//  UZTickets
//
//  Created by Kostya Bychkov on 7/2/15.
//  Copyright (c) 2015 DAloG ltd. All rights reserved.
//

#import "UZTTicketDetailsViewModel.h"

@interface UZTTicketDetailsViewModel ()

@property UZTTicketInfo* ticket;

@end

@implementation UZTTicketDetailsViewModel

+ (nonnull instancetype)newWithTicket:(nonnull UZTTicketInfo*)ticket
{
    return [[self alloc] initWithTicket:ticket];
}

- (nonnull instancetype)initWithTicket:(nonnull UZTTicketInfo*)ticket
{
    self = [super init];
    
    self.ticket = ticket;
    
    return self;
}

@end
