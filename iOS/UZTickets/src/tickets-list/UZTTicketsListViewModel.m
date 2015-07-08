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
    
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = paths.firstObject;
    NSString* filePath = [documentsDirectory stringByAppendingString:@"tickets.json"];
    NSData* ticketsData = [NSData dataWithContentsOfFile:filePath];
    
    if (ticketsData != nil) {
        NSError* serializationError;
        NSArray* json = [NSJSONSerialization JSONObjectWithData:ticketsData
                                                        options:0
                                                          error:&serializationError];
        NSAssert(serializationError == nil, @"Serialization error: %@", serializationError);
        
        self.tickets = [json.rac_sequence map:^id(NSString* value) {
            return [UZTTicketCellViewModel newWithTicket:[UZTTicketInfo newWithString:value]];
        }].array;
    }
    
    @weakify(self);
    [[RACObserve(self, scanViewModel.scannedTicket).distinctUntilChanged filter:^BOOL(id value) {
        return (value != nil);
    }] subscribeNext:^(UZTTicketInfo* ticket) {
        @strongify(self);
        
        for (UZTTicketCellViewModel* ticketModel in self.tickets) {
            if ([ticketModel.ticket.infoString isEqualToString:ticket.infoString]) {
                return;
            }
        }
        
        self.tickets = [self.tickets arrayByAddingObject:[UZTTicketCellViewModel newWithTicket:ticket]];
        
        NSArray* json = [self.tickets.rac_sequence map:^id(UZTTicketCellViewModel* value) {
            return value.ticket.infoString;
        }].array;
        
        NSError* serializationError;
        NSData* latestTicketsData = [NSJSONSerialization dataWithJSONObject:json
                                                                    options:0
                                                                      error:&serializationError];
        NSAssert(serializationError == nil, @"Serialization error: %@", serializationError);
        
        [latestTicketsData writeToFile:filePath atomically:YES];
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