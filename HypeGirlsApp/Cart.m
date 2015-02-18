//  PROGRAMMERS: Deniss Jacenko and Michael O'Reggio
//  CLASS: COP4655 Tue/Thur 5pm - 6:15pm
//  INSTRUCTOR: Steve Luis
//  ASSIGNMENT: Shopping Experience Concept (Group 3)
//  DUE: Thursday 12/11/14
//
//  Created by Deniss Jacenko and Michael O'Reggio
//  Creative Commons Attribution International 4.0 Licence
//
//  Cart.m
//  HypeGirlsApp

#import "Cart.h"

@implementation Cart

// Current cart status and the total price of everything in the cart
static NSMutableString *sharedCart;
static int priceTotal;

// Return what is in the cart
+ (NSMutableString *)shared {
    return sharedCart;
}

// Add item to the cart
+ (void) addToCartItem: (NSString *) item pricedAt: (int) price withQuantity: (int) quantity
{
    // Not first item; show previous and new information
    if(sharedCart != nil && ![sharedCart isEqual: @""])
    {
        sharedCart = [NSMutableString stringWithFormat:@"%@\r%d\t\t$%d\t\t%@", sharedCart, quantity, price, item];
    }
    // First item; show new information
    else
    {
        sharedCart = [NSMutableString stringWithFormat:@"%d\t\t$%d\t\t%@", quantity, price, item];
    }
    
    // Adjust the total price
    priceTotal = priceTotal + (price * quantity);
}

// Reset the cart
+ (void) clearCart
{
    sharedCart = [NSMutableString stringWithString:@""];
    priceTotal = 0;
}

// Return the total price
+ (int) getPriceTotal
{
    return priceTotal;
}

@end
