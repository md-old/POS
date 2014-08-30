//
//  POSTableViewController.h
//  POS
//
//  Created by Marco Denisi on 21/08/14.
//  Copyright (c) 2014 Marco Denisi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Order.h"
#import <MultipeerConnectivity/MultipeerConnectivity.h>

@interface POSTableViewController : UITableViewController

/**
 *  Add an order to the list
 *
 *  @param order the new order
 *  @param peer the peer from which the order comes from
 */
- (void) addOrderToTable: (Order*) order fromPeer: (MCPeerID*) peer;

/**
 *  Update the label "Paid" of the specific order
 *
 *  @param order the order
 */
- (void) updateLabelOfOrder: (Order*) order;

@end
