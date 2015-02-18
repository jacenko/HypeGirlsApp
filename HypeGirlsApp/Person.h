//  PROGRAMMERS: Deniss Jacenko and Michael O'Reggio
//  CLASS: COP4655 Tue/Thur 5pm - 6:15pm
//  INSTRUCTOR: Steve Luis
//  ASSIGNMENT: Shopping Experience Concept (Group 3)
//  DUE: Thursday 12/11/14
//
//  Created by Deniss Jacenko and Michael O'Reggio
//  Creative Commons Attribution International 4.0 Licence
//
//  Person.h
//  HypeGirlsApp

#import <Foundation/Foundation.h>
#import "Cart.h"

@interface Person : NSObject

// Information that will be showed in
// the Login and Profile Views
@property (nonatomic) NSString *username;
@property (nonatomic) NSString *password;
@property (nonatomic) NSString *name;
@property (nonatomic) NSInteger *age;
@property (nonatomic) NSString *email;
@property (nonatomic) UIImage *profilePic;
@property (nonatomic) NSMutableArray *recentPurchases;

+ (Person *) shared;
+ (void) saveSharedPerson: (Person *) p;
+ (BOOL) isUserAGuest;
+ (void) setUserAsGuest: (BOOL) yesOrNo;
+ (void) SaveProfileInformationWithName: (NSString *) name
                                    age: (NSInteger) age
                               andEmail: (NSString *) email
                                  photo: (UIImage *) profilePhoto;

- (void)setUser: (NSString *)user andPassword: (NSString *)password;
- (instancetype)initWithPerson: (Person *) p;
- (void) saveOrderToHistory: (NSString *) order;

@end
