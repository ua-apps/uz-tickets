//
//  UZTTicketsListViewModel.m
//  UZTickets
//
//  Created by Kostya Bychkov on 6/11/15.
//  Copyright (c) 2015 DAloG ltd. All rights reserved.
//

#import "UZTTicketsListViewModel.h"
#import "UZTTicketInfo.h"
#import "UZTTicketDetailsViewModel.h"
#import "UZTScanViewModel.h"

#import <ReactiveCocoa/ReactiveCocoa.h>

@interface UZTTicketCellViewModel ()

@property (nonnull) UZTTicketInfo* ticket;

@property NSString* passenger;
@property NSString* train;
@property NSString* wagon;
@property NSString* route;

@end



@interface UZTTicketsListViewModel ()

@property NSArray* tickets;
@property UZTTicketDetailsViewModel* selectedTicketViewModel;
@property UZTScanViewModel* scanViewModel;

@end

@implementation UZTTicketsListViewModel

- (nonnull instancetype)init
{
    self = [super init];
    
    self.tickets = @[];
    
    @weakify(self);
    [[RACObserve(self, scanViewModel.scannedTicket).distinctUntilChanged filter:^BOOL(id value) {
        return (value != nil);
    }] subscribeNext:^(UZTTicketInfo* ticket) {
        @strongify(self);
        self.tickets = [self.tickets arrayByAddingObject:[UZTTicketCellViewModel newWithTicket:ticket]];
    }];
    
    return self;
}

- (void)addNewTicket
{
    self.scanViewModel = [UZTScanViewModel new];
}

- (void)didSelectTicket:(nonnull UZTTicketCellViewModel*)ticket
{
    self.selectedTicketViewModel = [UZTTicketDetailsViewModel newWithTicket:ticket.ticket];
}

@end



@implementation UZTTicketCellViewModel

+ (nonnull instancetype)newWithTicket:(nonnull UZTTicketInfo*)ticket
{
    return [[self alloc] initWithTicket:ticket];
}

- (nonnull instancetype)initWithTicket:(nonnull UZTTicketInfo*)ticket
{
    self = [super init];
    
    self.ticket = ticket;
    self.passenger = ticket.passengerFullname;
    self.train = ticket.trainName;
    self.wagon = ticket.wagonNumber.stringValue;
    self.route = ticket.departureStation;
    
    return self;
}

@end