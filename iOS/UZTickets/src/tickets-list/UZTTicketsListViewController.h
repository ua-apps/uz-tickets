//
//  UZTTicketsListViewController.h
//  UZTickets
//
//  Created by Kostya Bychkov on 6/11/15.
//  Copyright (c) 2015 DAloG ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UZTTicketsListViewModel;
@interface UZTTicketsListViewController : UITableViewController

@property IBOutlet UZTTicketsListViewModel* viewModel;

@end
