//
//  POSDetailViewController.m
//  POS
//
//  Created by Marco Denisi on 28/08/14.
//  Copyright (c) 2014 Marco Denisi. All rights reserved.
//

#import "POSDetailViewController.h"
#import "Product.h"
#import "ProductCell.h"
#import "AppDelegate.h"

@interface POSDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *customerName;
@property (weak, nonatomic) IBOutlet UILabel *arrivalTime;
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UIButton *completeButton;
@property (weak, nonatomic) AppDelegate *delegate;

@end

@implementation POSDetailViewController

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
    
    self.customerName.text = self.order.identifier;
    self.arrivalTime.text = [NSDateFormatter localizedStringFromDate:self.order.arrivalTime
                                                           dateStyle:NSDateFormatterShortStyle
                                                           timeStyle:NSDateFormatterShortStyle];
    self.status.text = self.order.status;
    
    if ([self.order.status isEqualToString:@"complete"]) {
        [self.completeButton setEnabled:NO];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)completeOrder:(id)sender {
    NSString *message = [[NSString alloc] init];
    NSString *alertType = [[NSString alloc] init];

    if ([self.delegate sendOrderCompleteToPeer:self.peer]) {
        message = @"Order Completed!";
        alertType = @"OK";
        [self.tableVC updateLabelOfOrder:self.order];
        self.status.text = @"complete";
        [self.completeButton setEnabled:NO];
    } else {
        message = @"Something went wrong.";
        alertType = @"Error";
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:alertType
                                                        message:message
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"Got It", nil];
    [alertView show];
    
    // QUI devo chiamare il delegato e far partire il ranging
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
    return [self.order.products count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductCell *cell = (ProductCell*)[tableView dequeueReusableCellWithIdentifier:@"Product" forIndexPath:indexPath];
    
    Product *p = [self.order.products objectAtIndex:indexPath.row];
    
    cell.number.text = [NSString stringWithFormat:@"%d", indexPath.row];
    cell.prodName.text = p.name;
    NSNumber *qta = (NSNumber*)[self.order.quantities objectAtIndex:indexPath.row];
    cell.quantity.text = [qta stringValue];
    
    return cell;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
