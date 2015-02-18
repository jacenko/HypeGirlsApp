//  PROGRAMMERS: Deniss Jacenko and Michael O'Reggio
//  CLASS: COP4655 Tue/Thur 5pm - 6:15pm
//  INSTRUCTOR: Steve Luis
//  ASSIGNMENT: Shopping Experience Concept (Group 3)
//  DUE: Thursday 12/11/14
//
//  Created by Deniss Jacenko and Michael O'Reggio
//  Creative Commons Attribution International 4.0 Licence
//
//  ProfileViewController.h
//  HypeGirlsApp

#import <UIKit/UIKit.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "Theme.h"
#import "Person.h"
#import "People.h"
#import "UIView+FormScroll.h"

@interface ProfileViewController : UIViewController <UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

// Input properties for the Profile view
@property (weak, nonatomic) IBOutlet UITextField *profileName;
@property (weak, nonatomic) IBOutlet UITextField *profileAge;
@property (weak, nonatomic) IBOutlet UITextField *profileEmail;
@property (weak, nonatomic) IBOutlet UIImageView *profilePic;

- (IBAction)saveProfile:(id)sender;
- (IBAction)takePhoto:(id)sender;
- (IBAction)deletePhoto:(id)sender;

- (void) logInWithPerson: (Person *) p;

@end