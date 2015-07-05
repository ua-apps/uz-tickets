//
//  UZTTicketsListViewController.m
//  UZTickets
//
//  Created by Kostya Bychkov on 6/11/15.
//  Copyright (c) 2015 DAloG ltd. All rights reserved.
//

#import "UZTTicketsListViewController.h"

#import <ReactiveCocoa/ReactiveCocoa.h>

#import "UZTTicketsListViewModel.h"
#import "UZTTicketDetailsViewController.h"

@interface UZTTicketsListViewController ()

@property (nullable) NSIndexPath* selectedCellIndexPath;

@end

@implementation UZTTicketsListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self rac_liftSelector:@selector(navigateToTicketDetails)
     withSignalOfArguments:[[RACObserve(self, viewModel.selectedTicketViewModel)
                             filter:^BOOL(id value) { return (value != nil); }]
                            mapReplace:[RACTuple new]]];
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

- (void)navigateToTicketDetails
{
    [self performSegueWithIdentifier:@"ticket details" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ticket details"])
    {
        UZTTicketDetailsViewController* viewController = segue.destinationViewController;
        viewController.viewModel = self.viewModel.selectedTicketViewModel;
    }
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    return NO;
}

- (IBAction)unwind:(UIStoryboardSegue*)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
