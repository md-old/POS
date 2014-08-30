//
//  GuestCell.h
//  POS
//
//  Created by Marco Denisi on 22/08/14.
//  Copyright (c) 2014 Marco Denisi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuestCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *guestName;
@property (weak, nonatomic) IBOutlet UILabel *guestArrivalTime;
@property (weak, nonatomic) IBOutlet UILabel *guestNumber;
@property (weak, nonatomic) IBOutlet UIImageView *paid;

@end
