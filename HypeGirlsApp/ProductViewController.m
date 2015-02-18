//  PROGRAMMERS: Deniss Jacenko and Michael O'Reggio
//  CLASS: COP4655 Tue/Thur 5pm - 6:15pm
//  INSTRUCTOR: Steve Luis
//  ASSIGNMENT: Shopping Experience Concept (Group 3)
//  DUE: Thursday 12/11/14
//
//  Created by Deniss Jacenko and Michael O'Reggio
//  Creative Commons Attribution International 4.0 Licence
//
//  ProductViewController.m
//  HypeGirlsApp

#import "ProductViewController.h"
#import "Products.h"

@interface ProductViewController ()

@end

@implementation ProductViewController
{
    // Was user already logged in?
    BOOL logInAgain;
    // Initialize the People object to create a Singleton with default users
    People *allUsers;
}

@synthesize name, price, description, photo, productName, productPrice, productDescription, productPhoto,  quantityField, userLoggedIn, addToCartButton, loggedInAs;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    logInAgain = NO;
    userLoggedIn = [Person shared];
    
    // Show product information based on what was passed from the previous view controller
    productName.text = name;
    productPrice.text = price;
    productDescription.text = description;
    
    // Set description font
    [productDescription setFont:[UIFont systemFontOfSize:20]];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // Set the selected product image
    productPhoto.image = [UIImage imageNamed: [NSString stringWithFormat:@"%@", photo]];
    
    // Quantity text field will be of number type
    quantityField.keyboardType = UIKeyboardTypeNumberPad;

    // Set border for product image
    [productPhoto.layer setBorderColor: [[UIColor grayColor] CGColor]];
    [productPhoto.layer setBorderWidth: 1.0];
    
    // Set border for product description
    [productDescription.layer setBorderColor: [[UIColor colorWithRed:0.95
                                                               green:0.95
                                                                blue:0.95
                                                               alpha:1.0] CGColor]];
    [productDescription.layer setBorderWidth: 1.0];
    
    // Round edges for addToCartButton
    addToCartButton.layer.cornerRadius = 5;
    
    allUsers = [[People alloc]init];
    
    // Show who is logged in at the bottom of the view
    if ([[Person shared] name] != nil && ![[[Person shared] name] isEqualToString:@""]) {
        loggedInAs.text = [NSString stringWithFormat:@"Logged in as: %@", [[Person shared] name]];
    }
    
    // Show Hype Girls logo in the navbar title
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hypestorelogo.png"]];
    
    // Set navbar color to the theme
    self.navigationController.navigationBar.barTintColor = [Theme shared];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

// It is important for you to hide kwyboard

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self view] endEditing:YES];
}

- (IBAction)addToCart:(id)sender
{
    // User is logged in and not a guest
    // Add item to cart
    if (userLoggedIn != nil && [Person isUserAGuest] == NO)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Thank you!"
                                                        message: [NSString stringWithFormat:@"%@ was added to the cart", self.name]
                                                       delegate: nil
                                              cancelButtonTitle: @"OK"
                                              otherButtonTitles: nil];
        
        [Person setUserAsGuest:NO];
        [Cart addToCartItem:name
                   pricedAt:price.integerValue
               withQuantity:quantityField.text.integerValue];
        
        [alert show];
    }
    // User not logged in and is a guest
    // Add item to cart
    else if (userLoggedIn == nil && [Person isUserAGuest] == YES)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Thank you!"
                                                        message: [NSString stringWithFormat:@"%@ was added to the cart", self.name]
                                                       delegate: nil
                                              cancelButtonTitle: @"OK"
                                              otherButtonTitles: nil];
        [Cart addToCartItem:name
                   pricedAt:price.integerValue
               withQuantity:quantityField.text.integerValue];
        
        [alert show];

    }
    // User is not logged in and is not a guest
    // Ask to log in or be a guest
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Thank you!"
                                                        message: [NSString stringWithFormat:@"Would you like to log in to save this %@ to your purchase history or proceed as a Guest", self.name]
                                                       delegate: self
                                              cancelButtonTitle: @"Cancel"
                                              otherButtonTitles: @"Log In", @"Guest", nil];
        [alert show];
    }
}

// Press + button to increase quantity
- (IBAction)increaseQuantity:(id)sender {
    int newQTY = quantityField.text.intValue + 1;
    quantityField.text = [NSString stringWithFormat:@"%d", newQTY];
}

// Press - button to decrease quantity only if it is greater than 1
- (IBAction)decreaseQuantity:(id)sender {
    if (quantityField.text.intValue > 1)
    {
        int newQTY = quantityField.text.intValue - 1;
        quantityField.text = [NSString stringWithFormat:@"%d", newQTY];
    }
}

// Method for building and showing the Log In alert view
-(void)showLoginAlert{
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:nil message:nil delegate:self cancelButtonTitle:@" Cancel " otherButtonTitles:@" Log In ", nil];
    [av setAlertViewStyle:UIAlertViewStyleLoginAndPasswordInput];
    
    // Alert style customization
    [[av textFieldAtIndex:1] setSecureTextEntry:YES];
    [[av textFieldAtIndex:0] setPlaceholder:@"username"];
    [[av textFieldAtIndex:1] setPlaceholder:@"password"];
    [av textFieldAtIndex:0].autocorrectionType = UITextAutocorrectionTypeNo;
    [av textFieldAtIndex:1].autocorrectionType = UITextAutocorrectionTypeNo;
    [av show];
}

// Check which button the user tapped in an alert view
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // Button tapped title
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    UIAlertView *alert;
    
    // User tapped Log In
    if([title isEqualToString:@"Log In"])
    {
        logInAgain = NO;
        [self showLoginAlert];
    }
    
    // User is attempting to log in with given credentials
    if([title isEqualToString:@" Log In "])
    {
        
        Person *foundUser = [People lookup: [alertView textFieldAtIndex:0].text];
        
        // User found
        if(foundUser != nil)
        {
            logInAgain = NO;
            BOOL accessGranted = [allUsers checkPassword:[alertView textFieldAtIndex:1].text forUser:foundUser];
            // Password matches
            // Log user in
            if (accessGranted) {
                logInAgain = NO;
                [Person saveSharedPerson:foundUser];
                userLoggedIn = foundUser;
                
                // Check if user has a Name and adjust the alert view message accordingly
                if([foundUser name] != nil){
                    alert = [[UIAlertView alloc] initWithTitle: [NSString stringWithFormat:@"Logged in as \r%@!", [foundUser name]]
                                                                message: [NSString stringWithFormat:@"%@ has been added to your cart.", self.name]
                                                               delegate: self
                                                      cancelButtonTitle: @" OK "
                                                      otherButtonTitles: nil];
                    
                }
                else
                {
                    alert = [[UIAlertView alloc] initWithTitle: @"Logged in!"
                                                       message: [NSString stringWithFormat:@"%@ has been added to your cart.", self.name]
                                                      delegate: self
                                             cancelButtonTitle: @" OK "
                                             otherButtonTitles: nil];
                }
                [Person setUserAsGuest:NO];
                
                [Cart addToCartItem:name
                           pricedAt:price.integerValue
                       withQuantity:quantityField.text.integerValue];
                loggedInAs.text = [NSString stringWithFormat:@"Logged in as: %@", [[Person shared] name]];
                [alert show];
            }
            // User entered the wrong password
            // Let user know
            else
            {
                logInAgain = YES;
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"The password is incorrect"
                                                                message: @"Please check to make sure the password was typed correctly"
                                                               delegate: nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
            }
        }
        // Username doesn't exist
        // Let user know
        else
        {
            logInAgain = YES;
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"User not found"
                                                            message: @"Please check to make sure the username is correct"
                                                           delegate: nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
    }
    
    // User tapped Cancel
    if(buttonIndex == [alertView cancelButtonIndex] && logInAgain == YES)
    {
        [self showLoginAlert];
    }
    
    // User tapped Guest
    if([title isEqualToString:@"Guest"])
    {
        alert = [[UIAlertView alloc] initWithTitle: nil
                                           message: [NSString stringWithFormat:@"%@ has been added to your cart.", self.name]
                                          delegate: self
                                 cancelButtonTitle: @" OK "
                                 otherButtonTitles: nil];
        
        [Person setUserAsGuest:YES];
        loggedInAs.text = @"Logged in as: Guest";
        [Cart addToCartItem:name
                   pricedAt:price.integerValue
               withQuantity:quantityField.text.integerValue];
        [alert show];
    }
    
    // User cancelled the username/password input
    if([title isEqualToString:@" Cancel "])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Thank you!"
                                                        message: [NSString stringWithFormat:@"Would you like to log in to save this %@ to your purchase history or proceed as a Guest", self.name]
                                                       delegate: self
                                              cancelButtonTitle: @"Cancel"
                                              otherButtonTitles: @"Log In", @"Guest", nil];
        [alert show];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
@end
