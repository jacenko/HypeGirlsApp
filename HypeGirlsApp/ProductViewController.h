//  PROGRAMMERS: Deniss Jacenko and Michael O'Reggio
//  CLASS: COP4655 Tue/Thur 5pm - 6:15pm
//  INSTRUCTOR: Steve Luis
//  ASSIGNMENT: Shopping Experience Concept (Group 3)
//  DUE: Thursday 12/11/14
//
//  Created by Deniss Jacenko and Michael O'Reggio
//  Creative Commons Attribution International 4.0 Licence
//
//  ProductViewController.h
//  HypeGirlsApp

#import <UIKit/UIKit.h>
#import "Theme.h"
#import "Person.h"
#import "People.h"
#import "Cart.h"

@interface ProductViewController : UIViewController <UITextFieldDelegate, UIAlertViewDelegate>

// Product photo property
@property (weak, nonatomic) IBOutlet UIImageView *productPic;

// NSStrings with the page information for use with segues
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *price;
@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) NSString *photo;

// View items that show information about a product
@property (weak, nonatomic) IBOutlet UIImageView *productPhoto;
@property (strong, nonatomic) IBOutlet UILabel *productName;
@property (strong, nonatomic) IBOutlet UILabel *productPrice;
@property (strong, nonatomic) IBOutlet UILabel *loggedInAs;
@property (strong, nonatomic) IBOutlet UIButton *addToCartButton;
@property (strong, nonatomic) IBOutlet UITextView *productDescription;
@property (weak, nonatomic) IBOutlet UITextField *quantityField;

// Currenty logged in Person
@property (nonatomic) Person *userLoggedIn;

- (IBAction)addToCart:(id)sender;
- (IBAction)increaseQuantity:(id)sender;
- (IBAction)decreaseQuantity:(id)sender;


@end
