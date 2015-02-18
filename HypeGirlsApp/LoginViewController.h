//  PROGRAMMERS: Deniss Jacenko and Michael O'Reggio
//  CLASS: COP4655 Tue/Thur 5pm - 6:15pm
//  INSTRUCTOR: Steve Luis
//  ASSIGNMENT: Shopping Experience Concept (Group 3)
//  DUE: Thursday 12/11/14
//
//  Created by Deniss Jacenko and Michael O'Reggio
//  Creative Commons Attribution International 4.0 Licence
//
//  LoginViewController.h
//  HypeGirlsApp

#import <UIKit/UIKit.h>
#import "Theme.h"
#import "Person.h"
#import "People.h"
#import "UIView+FormScroll.h"

@interface LoginViewController : UIViewController <UITextFieldDelegate, UIAlertViewDelegate>

// Username/password TextFields
@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

- (IBAction)signUp:(id)sender;

@end