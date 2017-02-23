//
//  Flavor.h
//  CoffeTastersIOS
//
//  Created by Ettore Luglio on 11/27/16.
//  Copyright © 2016 Tamadrum. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Flavor : NSObject

@property (nonatomic) long id;
@property (weak) NSString* origem;
@property (weak) NSString* nome;
@property (weak) NSString* roaster;
@property (weak) NSString* producer;
@property (weak) NSDate* roastDate;
@property (weak) NSDate* sampled;
@property (weak) NSString* beverage;
@property double price;

@property (weak) NSString* notes;
@property double alaviacaoGeral;

@property (weak) NSString* brewMethod; // Espresso, Drip, Pour-Over, Press, Cupping, Siphon, Other
@property (weak) NSString* brewMethodOther;

@property double sweet;
@property double sour_tart;
@property double floral;
@property double spicy;
@property double salty;
@property double berry_fruit;
@property double citrus_fruit;
@property double stone_fruit;
@property double chocolate;
@property double caramel;
@property double smoky;
@property double bitter;
@property double savory;
@property double body;
@property double clean;
@property double linger_finish;

@end
