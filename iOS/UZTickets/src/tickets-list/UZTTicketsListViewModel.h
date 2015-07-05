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

NS_ASSUME_NONNULL_BEGIN
@interface UZTTicketsListViewModel : NSObject

@property (readonly) NSArray* tickets;
@property (readonly, nullable) UZTTicketDetailsViewModel* selectedTicketViewModel;

- (void)addNewTicket;
- (void)didSelectTicket:(UZTTicketInfo*)ticket;

@end
NS_ASSUME_NONNULL_END
