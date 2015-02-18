//  PROGRAMMERS: Deniss Jacenko and Michael O'Reggio
//  CLASS: COP4655 Tue/Thur 5pm - 6:15pm
//  INSTRUCTOR: Steve Luis
//  ASSIGNMENT: Shopping Experience Concept (Group 3)
//  DUE: Thursday 12/11/14
//
//  Created by Deniss Jacenko and Michael O'Reggio
//  Creative Commons Attribution International 4.0 Licence
//
//  Products.h
//  HypeGirlsApp

#import <Foundation/Foundation.h>

@interface Products : NSObject

// Properties for product information
@property (nonatomic, strong) NSArray *names;
@property (nonatomic, strong) NSArray *prices;
@property (nonatomic, strong) NSArray *descriptions;
@property (nonatomic, strong) NSArray *photos;

-(void) loadStore;

@end
