//
//  ProductCell.h
//  POS
//
//  Created by Marco Denisi on 28/08/14.
//  Copyright (c) 2014 Marco Denisi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *number;
@property (weak, nonatomic) IBOutlet UILabel *prodName;
@property (weak, nonatomic) IBOutlet UILabel *quantity;

@end
