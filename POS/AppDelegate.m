//
//  AppDelegate.m
//  POS
//
//  Created by Marco Denisi on 21/08/14.
//  Copyright (c) 2014 Marco Denisi. All rights reserved.
//

#import "AppDelegate.h"
#import "Order.h"

NSString *const kServiceType = @"pb-posemitter";
NSString *const DataReceivedNotification = @"polibeacon.POS:DataReceivedNotification";

@interface AppDelegate () <MCSessionDelegate>

@property (strong, nonatomic) MCAdvertiserAssistant *advertiserAssistant;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    // Settings for advertise my service
    NSString *peerName = @"POS";
    self.peerId = [[MCPeerID alloc] initWithDisplayName:peerName];
    
    self.session = [[MCSession alloc] initWithPeer:self.peerId
                                  securityIdentity:nil
                              encryptionPreference:MCEncryptionOptional];
    self.session.delegate = self;
    
    self.advertiserAssistant = [[MCAdvertiserAssistant alloc] initWithServiceType:kServiceType
                                                                    discoveryInfo:nil
                                                                          session:self.session];
    
    [self.advertiserAssistant start];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Helper Methods

- (BOOL) sendOrderCompleteToPeer: (MCPeerID*) peerId
{
    // Here I sent the notification to the specific peer
    NSString *message = @"OK";
    
    NSMutableArray *peersM = [[NSMutableArray alloc] initWithObjects:peerId, nil];
    
    NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    if ([self.session sendData:data
                       toPeers: peersM
                      withMode:MCSessionSendDataReliable
                         error:&error]) {
        return YES;
    }
    return NO;
}

#pragma mark - MCSessionDelegate methods

- (void) session:(MCSession *)session didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID
{
    // Here I handle data sent to me, so I handle and save orders
    id order = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    if ([order isKindOfClass:[Order class]]){
        [self.tableViewController addOrderToTable:order fromPeer:peerID];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:DataReceivedNotification object:nil];
}

- (void) session:(MCSession *)session didReceiveStream:(NSInputStream *)stream withName:(NSString *)streamName fromPeer:(MCPeerID *)peerID
{}

- (void) session:(MCSession *)session didFinishReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID atURL:(NSURL *)localURL withError:(NSError *)error
{}

- (void) session:(MCSession *)session didStartReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID withProgress:(NSProgress *)progress
{}

- (void) session:(MCSession *)session peer:(MCPeerID *)peerID didChangeState:(MCSessionState)state
{}

@end
