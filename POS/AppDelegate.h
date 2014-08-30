//
//  AppDelegate.h
//  POS
//
//  Created by Marco Denisi on 21/08/14.
//  Copyright (c) 2014 Marco Denisi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MultipeerConnectivity/MultipeerConnectivity.h>
#import "POSTableViewController.h"

extern NSString *const kServiceType;
extern NSString *const DataReceivedNotification;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MCSession *session;
@property (strong, nonatomic) MCPeerID *peerId;
@property (weak, nonatomic) POSTableViewController *tableViewController;

/**
 *  Send a message to the peer that signals the completion of its order
 *
 *  @param peerId the peer to talk to
 *  @result YES if the message is sent, NO otherwise
 */
- (BOOL) sendOrderCompleteToPeer: (MCPeerID*) peerId;

@end
