//
//  Order.m
//  POS
//
//  Created by Marco Denisi on 22/08/14.
//  Copyright (c) 2014 Marco Denisi. All rights reserved.
//


#import "Order.h"
#import "Product.h"
#import <AdSupport/AdSupport.h>

@implementation Order

- (instancetype) init {
    self = [super init];
    
    if (self) {
        self.identifier = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
        self.products = [[NSMutableArray alloc] init];
        self.quantities = [[NSMutableArray alloc] init];
        self.status = @"open";
    }
    
    return self;
}

- (instancetype) initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.identifier = [aDecoder decodeObjectForKey:@"identifier"];
    self.products = [aDecoder decodeObjectForKey:@"products"];
    self.quantities = [aDecoder decodeObjectForKey:@"quantities"];
    self.arrivalTime = [aDecoder decodeObjectForKey:@"arrivalTime"];
    self.status = [aDecoder decodeObjectForKey:@"status"];
    
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.identifier forKey:@"identifier"];
    [aCoder encodeObject:self.products forKey:@"products"];
    [aCoder encodeObject:self.quantities forKey:@"quantities"];
    [aCoder encodeObject:self.arrivalTime forKey:@"arrivalTime"];
    [aCoder encodeObject:self.status forKey:@"status"];
}

#pragma mark - Helper methods
- (int) verifyIfProductIsPresent:(NSNumber *)prodId
{
    int i = 0;
    for (Product *product in self.products) {
        if ([product.identifier isEqualToNumber:prodId]) {
            return i;
        }
        i++;
    }
    
    return -1;
}

- (void) deleteProductWithId:(NSNumber *)prodId andPosition: (int) position
{
    [self.products removeObjectAtIndex:position];
    [self.quantities removeObjectAtIndex:position];
}

- (void) updateProductAtIndex:(int)index withQuantity:(int)qta
{
    [self.quantities removeObjectAtIndex:index];
    NSNumber *quantity = [[NSNumber alloc] initWithInt:qta];
    [self.quantities insertObject:quantity atIndex:index];
}

- (int) getTotalPrice
{
    int tot = 0;
    for (int i = 0; i < [self.products count]; i++) {
        int price = [((Product*)[self.products objectAtIndex:i]).price intValue];
        int qta = [(NSNumber*)[self.quantities objectAtIndex:i] intValue];
        tot += (price*qta);
    }
    return tot;
}

@end

