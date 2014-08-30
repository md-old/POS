//
//  POSDetailViewController.h
//  POS
//
//  Created by Marco Denisi on 28/08/14.
//  Copyright (c) 2014 Marco Denisi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Order.h"
#import <MultipeerConnectivity/MultipeerConnectivity.h>
#import "POSTableViewController.h"

@interface POSDetailViewController : UITableViewController

@property (strong, nonatomic) Order *order;
@property (strong, nonatomic) MCPeerID *peer;
@property (weak, nonatomic) POSTableViewController *tableVC;

@end
