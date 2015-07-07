//
//  UZTTicketsListViewModel.h
//  UZTickets
//
//  Created by Kostya Bychkov on 6/11/15.
//  Copyright (c) 2015 DAloG ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UZTTicketInfo;
@class UZTTicketDetailsViewModel;
@class UZTScanViewModel;

NS_ASSUME_NONNULL_BEGIN
@interface UZTTicketCellViewModel : NSObject

@property (readonly) NSString* passenger;
@property (readonly) NSString* train;
@property (readonly) NSString* wagon;
@property (readonly) NSString* route;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)newWithTicket:(UZTTicketInfo*)ticket;

@end



@interface UZTTicketsListViewModel : NSObject

/// [UZTTicketCellViewModel]
@property (readonly) NSArray* tickets;
@property (readonly, nullable) UZTTicketDetailsViewModel* selectedTicketViewModel;
@property (readonly, nullable) UZTScanViewModel* scanViewModel;

- (void)addNewTicket;
- (void)didSelectTicket:(UZTTicketCellViewModel*)ticket;

@end
NS_ASSUME_NONNULL_END
