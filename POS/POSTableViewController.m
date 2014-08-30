//
//  POSTableViewController.m
//  POS
//
//  Created by Marco Denisi on 21/08/14.
//  Copyright (c) 2014 Marco Denisi. All rights reserved.
//

#import "POSTableViewController.h"
#import "GuestCell.h"
#import "Order.h"
#import "AppDelegate.h"
#import "POSDetailViewController.h"

@interface POSTableViewController ()

@property (strong, nonatomic) NSMutableArray *orders;
@property (strong, nonatomic) NSMutableArray *peers;
@property (weak, nonatomic) AppDelegate *delegate;

@end

@implementation POSTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    self.delegate.tableViewController = self;
    self.orders = [[NSMutableArray alloc] init];
    self.peers = [[NSMutableArray alloc] init];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.orders count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GuestCell *guestCell = (GuestCell*)[tableView dequeueReusableCellWithIdentifier:@"Guest" forIndexPath:indexPath];
    
    Order *order = [self.orders objectAtIndex:indexPath.row];
    NSString *image;
    
    guestCell.guestName.text = order.identifier;
    guestCell.guestArrivalTime.text = [NSDateFormatter localizedStringFromDate:order.arrivalTime
                                                                     dateStyle:NSDateFormatterShortStyle
                                                                     timeStyle:NSDateFormatterShortStyle];
    
    if ([order.status isEqualToString:@"open"]) {
        image = @"cross5";
    } else if ([order.status isEqualToString:@"complete"]) {
        image = @"time1";
    } else {
        image = @"approve";
    }
    
    guestCell.paid.image = [UIImage imageNamed:image];
    
    return guestCell;
 
}

- (void) addOrderToTable:(Order *)order fromPeer:(MCPeerID *)peer
{
    int index = [self verifyIfOrderIsPresent:order.identifier];
    if (index > -1) {
        [self.orders removeObjectAtIndex: index];
        [self.orders insertObject:order atIndex: index];
    } else {
        [self.orders addObject:order];
        [self.peers addObject:peer];
    }
    
    [self.tableView reloadData];
}

#pragma mark - Helper Methods

/**
 *  Verify if an order with the same UUID is present
 *
 *  @param orderId the order's identifier
 *
 *  @return the position of the order
 */
- (int) verifyIfOrderIsPresent: (NSString*) orderId
{
    int i = 0;
    for (Order *order in self.orders) {
        if ([order.identifier isEqualToString:orderId]) {
            return i;
        }
        i++;
    }
    return -1;
}

- (void) updateLabelOfOrder:(Order *)order
{
    int position = [self verifyIfOrderIsPresent:order.identifier];
    ((Order*)[self.orders objectAtIndex:position]).status = @"complete";
    [self.tableView reloadData];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ShowDetails"]) {
        POSDetailViewController *detail = [segue destinationViewController];
        
        NSIndexPath *myIndexPath = [self.tableView
                                    indexPathForSelectedRow];
        
        long row = [myIndexPath row];
        
        Order *order = [self.orders objectAtIndex:row];
        MCPeerID *peer = [self.peers objectAtIndex:row];
        
        detail.order = order;
        detail.peer = peer;
        detail.tableVC = self;
    }
}


@end
