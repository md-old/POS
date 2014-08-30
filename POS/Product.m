//
//  Product.m
//  POS
//
//  Created by Marco Denisi on 22/08/14.
//  Copyright (c) 2014 Marco Denisi. All rights reserved.
//

#import "Product.h"

@implementation Product

- (instancetype) initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.identifier = [aDecoder decodeObjectForKey:@"identifier"];
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.description = [aDecoder decodeObjectForKey:@"description"];
    self.price = [aDecoder decodeObjectForKey:@"price"];
    
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.identifier forKey:@"identifier"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.description forKey:@"description"];
    [aCoder encodeObject:self.price forKey:@"price"];
}

- (id)initWithJSONDictionary:(NSDictionary *)jsonDictionary
{
    if(self = [self init]) {
        // Assign all properties with keyed values from the dictionary
        self.identifier = [jsonDictionary objectForKey:@"id"];
        self.name = [jsonDictionary objectForKey:@"name"];
        self.description = [jsonDictionary objectForKey:@"description"];
        self.price = [jsonDictionary objectForKey:@"price"];
    }
    
    return self;
}

@end

