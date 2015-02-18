//  PROGRAMMERS: Deniss Jacenko and Michael O'Reggio
//  CLASS: COP4655 Tue/Thur 5pm - 6:15pm
//  INSTRUCTOR: Steve Luis
//  ASSIGNMENT: Shopping Experience Concept (Group 3)
//  DUE: Thursday 12/11/14
//
//  Created by Deniss Jacenko and Michael O'Reggio
//  Creative Commons Attribution International 4.0 Licence
//
//  People.h
//  HypeGirlsApp

#import <Foundation/Foundation.h>
#import "Person.h"

@interface People : NSObject

// The array that will hold Person objects
@property (nonatomic, strong) NSMutableArray *people;

+ (Person *) lookup: (NSString *) userName;
+ (void) addPerson: (Person *) p;
+ (void) savePerson: (Person *) p;

-(BOOL)checkPassword: (NSString *)password forUser: (Person *)user;

@end
