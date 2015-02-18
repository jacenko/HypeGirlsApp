//  PROGRAMMERS: Deniss Jacenko and Michael O'Reggio
//  CLASS: COP4655 Tue/Thur 5pm - 6:15pm
//  INSTRUCTOR: Steve Luis
//  ASSIGNMENT: Shopping Experience Concept (Group 3)
//  DUE: Thursday 12/11/14
//
//  Created by Deniss Jacenko and Michael O'Reggio
//  Creative Commons Attribution International 4.0 Licence
//
//  Products.m
//  HypeGirlsApp

#import "Products.h"

@implementation Products

@synthesize names, prices, descriptions, photos;

// Load the store with preset products (name, description, price, and photos)
-(void) loadStore
{
    self.names = [[NSArray alloc] initWithObjects:
                  @"Example Dress", @"White Dress", @"Example Tee", @"Black Tee", @"Example Bracelet", nil];
    
    self.prices = [[NSArray alloc] initWithObjects:
                   @"35", @"35",@"15", @"15", @"22", nil];
    
    self.descriptions = [[NSArray alloc] initWithObjects:
                         @"(This is an example dress description) Fitted dress with an amazingly interesting design and durable, high-quality materials.",
                         @"(This is an example dress description) Fitted dress with an amazingly interesting design and durable, high-quality materials.",
                         @"Bitchiecake tank is a loose fitted tank perfect for a summer. Get our classic and original bitchiecake design in neon yellow with solid black print. This in not longer in print in and is now considered a collector tank.",
                         @"FlirtyCake Crop Top is here just in time for festival season. Cotton Spandex. Neon Pink.",
                         @"HG Cherry Bomb Bracelet Stack. Glass beads and man-made materials. Gold plated charms. Stretch to fit. Comes with a lifetime repair warranty, jewelry bag and care instructions.", nil];
    
    self.photos = [[NSArray alloc] initWithObjects:
                   @"Dress", @"whitedress", @"Tee", @"blacktee", @"Bracelet", nil];
}

@end
