//  PROGRAMMERS: Deniss Jacenko and Michael O'Reggio
//  CLASS: COP4655 Tue/Thur 5pm - 6:15pm
//  INSTRUCTOR: Steve Luis
//  ASSIGNMENT: Shopping Experience Concept (Group 3)
//  DUE: Thursday 12/11/14
//
//  Created by Deniss Jacenko and Michael O'Reggio
//  Creative Commons Attribution International 4.0 Licence
//
//  Person.m
//  HypeGirlsApp

#import "Person.h"

@implementation Person

// Set currently logged in person to guest if isGuest is true
static BOOL isGuest;
// Currently logged in person is saved in sharedPerson
static Person *sharedPerson;

@synthesize username, name, password, age, email, profilePic, recentPurchases;

// Set the username and password for a Person class
-(void)setUser: (NSString *)user andPassword: (NSString *)pw
{
    self.username = user;
    self.password = pw;
}

// Check if current user is a guest
+ (BOOL) isUserAGuest
{
    return isGuest;
}

// Set user as either a guest or not
+ (void) setUserAsGuest: (BOOL) yesOrNo
{
    isGuest = yesOrNo;
}

// Return currently logged in Person object
+ (Person *)shared {
    return sharedPerson;
}

// Set currently logged in person
+ (void)saveSharedPerson: (Person *) p {
    sharedPerson = p;
}

// Save updated information for the currentl logged in user
+ (void) SaveProfileInformationWithName: (NSString *) sName
                                    age: (NSInteger) sAge
                               andEmail: (NSString *) sEmail
                                  photo: (UIImage *) profilePhoto
{
    sharedPerson.name = sName;
    sharedPerson.age = &(sAge);
    sharedPerson.email = sEmail;
    sharedPerson.profilePic = profilePhoto;
}

// Create a person with an existing person's information
- (instancetype)initWithPerson: (Person *) p
{
    self = [super init];
    if (self) {
        self.username = p.username;
        self.password = p.password;
        self.name = p.name;
        self.age = p.age;
        self.email = p.email;
        self.profilePic = p.profilePic;
        self.recentPurchases = p.recentPurchases;
    }
    return self;
}

// Save order when currently logged in person checks out
- (void) saveOrderToHistory: (NSString *) order
{
    // Creates a string with today's date and time
    NSDate *myDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    NSString *myDateString = [dateFormatter stringFromDate:myDate];
    
    // User's first transaction
    if(sharedPerson.recentPurchases == nil)
    {
        sharedPerson.recentPurchases = [[NSMutableArray alloc] init];
        [sharedPerson.recentPurchases
         addObject:[NSString
                    stringWithFormat:@"Purchase Date:\r%@\r\r%@\r\rTOTAL: $%d\r________", myDateString, order, [Cart getPriceTotal]]];
    }
    // User's subsequent transaction (includes space after the previous one)
    else
    {
        [sharedPerson.recentPurchases
         addObject:[NSString
                    stringWithFormat:@"\r\r\rPurchase Date:\r%@\r\r%@\r\rTOTAL: $%d\r________", myDateString, order, [Cart getPriceTotal]]];
    }
}

@end