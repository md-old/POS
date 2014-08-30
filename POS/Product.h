//
//  Product.h
//  POS
//
//  Created by Marco Denisi on 22/08/14.
//  Copyright (c) 2014 Marco Denisi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject <NSCoding>

@property (strong, nonatomic) NSNumber *identifier;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) NSNumber *price;

- (id)initWithJSONDictionary:(NSDictionary *)jsonDictionary;

@end
