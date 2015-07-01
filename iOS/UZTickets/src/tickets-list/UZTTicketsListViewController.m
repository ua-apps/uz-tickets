//
//  UZTTicketsListViewController.m
//  UZTickets
//
//  Created by Kostya Bychkov on 6/11/15.
//  Copyright (c) 2015 DAloG ltd. All rights reserved.
//

#import "UZTTicketsListViewController.h"
#import "UZTTicketsListViewModel.h"

@interface UZTTicketsListViewController ()

@property (nullable) NSIndexPath* selectedCellIndexPath;

@end

@implementation UZTTicketsListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.selectedCellIndexPath != nil)
    {
        [self.tableView deselectRowAtIndexPath:self.selectedCellIndexPath
                                      animated:YES];
        self.selectedCellIndexPath = nil;
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.tickets.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* (^addCell)(void) = ^{
        return [tableView dequeueReusableCellWithIdentifier:@"add cell" forIndexPath:indexPath];
    };
    
    UITableViewCell* (^ticketCell)(void) = ^{
        return [tableView dequeueReusableCellWithIdentifier:@"ticket cell" forIndexPath:indexPath];
    };
    
    if (indexPath.row == 0) {
        return addCell();
    } else {
        return ticketCell();
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedCellIndexPath = indexPath;
    if (indexPath.row == 0)
    {
        [self.viewModel addNewTicket];
    }
    else
    {
        [self.viewModel didSelectTicket:self.viewModel.tickets[indexPath.row-1]];
    }
}

@end
