//  PROGRAMMERS: Deniss Jacenko and Michael O'Reggio
//  CLASS: COP4655 Tue/Thur 5pm - 6:15pm
//  INSTRUCTOR: Steve Luis
//  ASSIGNMENT: Shopping Experience Concept (Group 3)
//  DUE: Thursday 12/11/14
//
//  Created by Deniss Jacenko and Michael O'Reggio
//  Creative Commons Attribution International 4.0 Licence
//
//  People.m
//  HypeGirlsApp

#import "People.h"

@implementation People

@synthesize people;

// Singleton array of Person objects
static NSMutableArray *sharedPeople;

// Init method creates 3 default Person objects
// and adds them to the sharedPeople array
- (instancetype)init
{
    self = [super init];
    if (self) {
        if([sharedPeople count] == 0)
        {
            // Create three new people and set their usernames/passwords
            Person *sara = [[Person alloc] init];
            Person *stephanie = [[Person alloc] init];
            Person *sasha = [[Person alloc] init];
            
            NSString *aName = @"sara";
            NSString *aPW = @"sara1";
            NSString *bName = @"stephanie";
            NSString *bPW = @"stephanie1";
            NSString *cName = @"sasha";
            NSString *cPW = @"sasha1";
            
            // Add extended information to the sara/sara1 Person
            [sara setUser:aName andPassword:aPW];
            [sara setName:@"Sara Jean"];
            [sara setAge:(NSInteger *) 25];
            [sara setEmail:@"sjean001@gmail.com"];
            [stephanie setUser:bName andPassword:bPW];
            [sasha setUser:cName andPassword:cPW];
            
            sharedPeople = [[NSMutableArray alloc] init];
            
            [sharedPeople addObject:sara];
            [sharedPeople addObject:stephanie];
            [sharedPeople addObject:sasha];
        }
    }
    return self;
}

// Return a Person object within the sharedPeople array
// that has the given username
+(Person *) lookup: (NSString *) user
{
    for ( Person *p in sharedPeople )
        if ( [p.username caseInsensitiveCompare: user]
            == NSOrderedSame )
            return p;
    return nil;
}

// Create a new user / Add the object to sharedPeople
+(void) addPerson: (Person *) p
{
    [sharedPeople addObject: p];
}

// For a given Person object, check to make sure the given password
// matches the existing usr password. Return YES if it does
-(BOOL) checkPassword:(NSString *)password forUser:(Person *)user
{
    if([password isEqualToString: user.password])
    {
        // Access granted
        return YES;
    }
    else
    {
        // Access denied
        return NO;
    }
}

// Save a user's new set of information to sharedPeople
+ (void) savePerson: (Person *) p
{
    // Instance array that will hold the updated Person object
    NSMutableArray * newArrayOfPeople = [[NSMutableArray alloc] init];
    for ( Person *person in sharedPeople )
    {
        // Save the updated Person object
        if (person.username == p.username)
        {
            [newArrayOfPeople addObject:p];
        }
        // Save the previously existing Person objects
        else
        {
            [newArrayOfPeople addObject:person];
        }
    }
    // Save the Person objects with an updated Person to sharedPeople
    sharedPeople = [NSMutableArray arrayWithArray:newArrayOfPeople];
}

@end
