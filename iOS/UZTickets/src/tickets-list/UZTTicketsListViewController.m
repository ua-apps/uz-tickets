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
#import "UZTScanViewController.h"

@interface UZTTicketCell : UITableViewCell

@property UZTTicketCellViewModel* viewModel;

@property IBOutlet UILabel* passengerLabel;
@property IBOutlet UILabel* trainLabel;
@property IBOutlet UILabel* wagonLabel;
@property IBOutlet UILabel* routeLabel;

@end

@implementation UZTTicketCell

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    RAC(self, passengerLabel.text) = RACObserve(self, viewModel.passenger);
    RAC(self, trainLabel.text) = [RACObserve(self, viewModel.train) map:^NSString*(NSString* value) {
        return (value.length > 0) ? [@"train# " stringByAppendingString:value] : nil;
    }];
    RAC(self, wagonLabel.text) = [RACObserve(self, viewModel.wagon) map:^NSString*(NSString* value) {
        return (value.length > 0) ? [@"wagon# " stringByAppendingString:value] : nil;
    }];
    RAC(self, routeLabel.text) = RACObserve(self, viewModel.route);
    
    return self;
}

- (void)prepareForReuse
{
    self.viewModel = nil;
}

@end



@interface UZTTicketsListViewController ()

@property (nullable) NSIndexPath* selectedCellIndexPath;

@end

@implementation UZTTicketsListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self rac_liftSelector:@selector(navigateToTicketDetails)
     withSignalOfArguments:[[[RACObserve(self, viewModel.selectedTicketViewModel)
                             filter:^BOOL(id value) { return (value != nil); }]
                            mapReplace:[RACTuple new]] deliverOnMainThread]];
    
    [self rac_liftSelector:@selector(navigateToAddTicket)
     withSignalOfArguments:[[[RACObserve(self, viewModel.scanViewModel)
                             filter:^BOOL(id value) { return (value != nil); }]
                            mapReplace:[RACTuple new]] deliverOnMainThread]];
    
    [self.tableView rac_liftSelector:@selector(reloadData)
               withSignalOfArguments:[[RACObserve(self, viewModel.tickets).distinctUntilChanged
                                      mapReplace:[RACTuple new]] deliverOnMainThread]];
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

- (void)navigateToAddTicket
{
    [self performSegueWithIdentifier:@"scan" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ticket details"])
    {
        UZTTicketDetailsViewController* viewController = segue.destinationViewController;
        viewController.viewModel = self.viewModel.selectedTicketViewModel;
    }
    else if ([segue.identifier isEqualToString:@"scan"])
    {
        UZTScanViewController* viewController = segue.destinationViewController;
        viewController.viewModel = self.viewModel.scanViewModel;
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
    
    UZTTicketCell* (^ticketCell)(void) = ^{
        UZTTicketCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ticket cell" forIndexPath:indexPath];
        cell.viewModel = self.viewModel.tickets[indexPath.row-1];
        return cell;
    };
    
    if (indexPath.row == 0) {
        return addCell();
    } else {
        return ticketCell();
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.row > 0;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.viewModel didDeleteTicket:self.viewModel.tickets[indexPath.row-1]];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.row > 0 ? UITableViewCellEditingStyleDelete : UITableViewCellEditingStyleNone;
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
