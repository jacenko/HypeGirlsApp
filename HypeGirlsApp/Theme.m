//  PROGRAMMERS: Deniss Jacenko and Michael O'Reggio
//  CLASS: COP4655 Tue/Thur 5pm - 6:15pm
//  INSTRUCTOR: Steve Luis
//  ASSIGNMENT: Shopping Experience Concept (Group 3)
//  DUE: Thursday 12/11/14
//
//  Created by Deniss Jacenko and Michael O'Reggio
//  Creative Commons Attribution International 4.0 Licence
//
//  Theme.m
//  HypeGirlsApp

#import "Theme.h"

// Shared color between View Controller navigation bars (The theme color)
static UIColor * sharedColor;

@implementation Theme

// Returns the current theme color
+ (UIColor *) shared
{
    // If a theme color has not been set yet,
    // set it to the default one (RGB value for dark purple)
    // and return it
    if(sharedColor == nil)
    {
        sharedColor = [UIColor colorWithRed:55/255.0f green:2/255.0f blue:82/255.0f alpha:1.0f];
        return sharedColor;
    }
    // Otherwise, return the currently set color
    else
    {
        return sharedColor;
    }
}

// Set the theme color to the default
+ (void) setDefault
{
    sharedColor = [UIColor colorWithRed:55/255.0f green:2/255.0f blue:82/255.0f alpha:1.0f];
}

// Set the theme color to black
+ (void) setBlack
{
    sharedColor = [UIColor blackColor];
}

// Set the theme color to red
+ (void) setRed
{
    sharedColor = [UIColor redColor];
}

@end
