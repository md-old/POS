//
//  Order.h
//  POS
//
//  Created by Marco Denisi on 22/08/14.
//  Copyright (c) 2014 Marco Denisi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Order : NSObject <NSCoding>

@property (strong, nonatomic) NSDate *arrivalTime;
@property (strong, nonatomic) NSMutableArray *products;
@property (strong, nonatomic) NSMutableArray *quantities;
@property (strong, nonatomic) NSString *identifier;
@property (strong, nonatomic) NSString *status;

/**
 *  Given the identifier of a product, verify if is already present in the array. If yes, its position is returned, if not, -1 is the result.
 *
 *  @param prodId the product's identifier
 *
 *  @return the position of the product or -1
 */
- (int) verifyIfProductIsPresent: (NSNumber*) prodId;

/**
 *  Delete the product from the order
 *
 *  @param prodId the product's identifier
 */
- (void) deleteProductWithId: (NSNumber*) prodId andPosition: (int) position;

/**
 *  Update the quantity of the product in the given index.
 *
 *  @param index the index of the product in the array
 *  @param qta   the new quantity
 */
- (void) updateProductAtIndex: (int) index withQuantity: (int) qta;

/**
 *  Get the total price of the order
 *
 *  @return the price
 */
- (int) getTotalPrice;

@end

