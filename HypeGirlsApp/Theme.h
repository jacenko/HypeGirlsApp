//  PROGRAMMERS: Deniss Jacenko and Michael O'Reggio
//  CLASS: COP4655 Tue/Thur 5pm - 6:15pm
//  INSTRUCTOR: Steve Luis
//  ASSIGNMENT: Shopping Experience Concept (Group 3)
//  DUE: Thursday 12/11/14
//
//  Created by Deniss Jacenko and Michael O'Reggio
//  Creative Commons Attribution International 4.0 Licence
//
//  Theme.h
//  HypeGirlsApp

#import <Foundation/Foundation.h>


@interface Theme : NSObject

+ (UIColor *) shared;
+ (void) setDefault;
+ (void) setBlack;
+ (void) setRed;

@end
