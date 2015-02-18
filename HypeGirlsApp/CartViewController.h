//  PROGRAMMERS: Deniss Jacenko and Michael O'Reggio
//  CLASS: COP4655 Tue/Thur 5pm - 6:15pm
//  INSTRUCTOR: Steve Luis
//  ASSIGNMENT: Shopping Experience Concept (Group 3)
//  DUE: Thursday 12/11/14
//
//  Created by Deniss Jacenko and Michael O'Reggio
//  Creative Commons Attribution International 4.0 Licence
//
//  CartViewController.h
//  HypeGirlsApp

#import <UIKit/UIKit.h>
#import "People.h"
#import "Person.h"
#import "Cart.h"

@interface CartViewController : UIViewController

// TextView that show's items in the cart
@property (weak, nonatomic) IBOutlet UITextView *cartDescription;

- (IBAction)pressBack:(id)sender;
- (IBAction)checkOut:(id)sender;
- (IBAction)clearCart:(id)sender;

@end
