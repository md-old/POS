//
//  GuestCell.m
//  POS
//
//  Created by Marco Denisi on 22/08/14.
//  Copyright (c) 2014 Marco Denisi. All rights reserved.
//

#import "GuestCell.h"

@implementation GuestCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
