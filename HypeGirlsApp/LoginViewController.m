//  PROGRAMMERS: Deniss Jacenko and Michael O'Reggio
//  CLASS: COP4655 Tue/Thur 5pm - 6:15pm
//  INSTRUCTOR: Steve Luis
//  ASSIGNMENT: Shopping Experience Concept (Group 3)
//  DUE: Thursday 12/11/14
//
//  Created by Deniss Jacenko and Michael O'Reggio
//  Creative Commons Attribution International 4.0 Licence
//
//  LoginViewController.m
//  HypeGirlsApp

#import "LoginViewController.h"
#import "ProfileViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController{
    // Person objects that can be used to log in
    NSMutableArray *people;
    
    // Person found from the username
    Person *foundUser;
    
    // People class to retrieve default accounts
    // (sara/sara1, stephanie/stephanie1, sasha/sasha1)
    People *allUsers;
    
    // View adjustment integer
    int x;
}

@synthesize userNameField, passwordField;

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
    
    // Set TextField delegates
    userNameField.delegate = self;
    passwordField.delegate = self;
    
    // Init/alloc a People object to create the default users
    allUsers = [[People alloc] init];
    
    // Show currently logged in user's information
    userNameField.text = [[Person shared] username];
    
    // Set view adjuster to default value
    x = 0;
    
    // Listen to the keyboard being hidden/shown
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardWillHideNotification object:nil];
    
    // Show the view in its default position
    [self.view scrollToY:0];
    
    // Set navbar title to the Hype Girls logo
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hypeprofilelogo.png"]];
    
    // Set navbar color to the selected theme
    self.navigationController.navigationBar.barTintColor = [Theme shared];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// It is important for you to hide kwyboard

// Hide keyboard when pressing return
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

// Hide keyboard when pressing anywhere outside the keyboard
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self view] endEditing:YES];
}

// Press the sign up button
- (IBAction)signUp:(id)sender
{
    // Show an alert view for creating a new account
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"New Account"
                                                 message:@"Please enter your new username and password"
                                                delegate:self
                                       cancelButtonTitle:@"Cancel"
                                       otherButtonTitles:@"Sign Up", nil];
    [av setAlertViewStyle:UIAlertViewStyleLoginAndPasswordInput];
    
    // Alert style customization
    [[av textFieldAtIndex:1] setSecureTextEntry:YES];
    [[av textFieldAtIndex:0] setPlaceholder:@"username"];
    [[av textFieldAtIndex:1] setPlaceholder:@"password"];
    [av textFieldAtIndex:0].autocorrectionType = UITextAutocorrectionTypeNo;
    [av textFieldAtIndex:1].autocorrectionType = UITextAutocorrectionTypeNo;
    [av show];
}

// Respond to different alert view button taps
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // Title of pressed button
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    // Sign up button was pressed
    if([title isEqualToString:@"Sign Up"])
    {
        NSString *usernameEntered = [alertView textFieldAtIndex: 0].text;
        NSString *passwordEntered = [alertView textFieldAtIndex: 1].text;
        
        foundUser = [People lookup: usernameEntered];
        
        // User entered something for both fields
        if(usernameEntered != nil && passwordEntered != nil)
        {
            // Username doesn't already exist
            if(foundUser == nil)
            {
                Person *newUser = [[Person alloc] init];
                [newUser setUsername:usernameEntered];
                [newUser setPassword:passwordEntered];
                [People addPerson:newUser];
                
                // Account created! Notify the user
                UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Account Created!"
                                                             message:@"Feel free to log in and update your profile."
                                                            delegate:self
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil];
                
                [av show];
            }
            // Username already exists. Ask user to change it
            else
            {
                UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"New Account"
                                                             message:@"That username already exists. Please choose a different username."
                                                            delegate:self
                                                   cancelButtonTitle:@"Cancel"
                                                   otherButtonTitles:@"Sign Up", nil];
                [av setAlertViewStyle:UIAlertViewStyleLoginAndPasswordInput];
                
                // Alert style customization
                [[av textFieldAtIndex:1] setSecureTextEntry:YES];
                [[av textFieldAtIndex:0] setPlaceholder:@"username"];
                [[av textFieldAtIndex:1] setPlaceholder:@"password"];
                [av textFieldAtIndex:0].autocorrectionType = UITextAutocorrectionTypeNo;
                [av textFieldAtIndex:1].autocorrectionType = UITextAutocorrectionTypeNo;
                [av show];
            }
        }
        // User left either or both of the fields blank. Notify them of this
        else
        {
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"New Account"
                                                         message:@"Please fill in both the username and a password"
                                                        delegate:self
                                               cancelButtonTitle:@"Cancel"
                                               otherButtonTitles:@"Sign Up", nil];
            [av setAlertViewStyle:UIAlertViewStyleLoginAndPasswordInput];
            
            // Alert style customization
            [[av textFieldAtIndex:1] setSecureTextEntry:YES];
            [[av textFieldAtIndex:0] setPlaceholder:@"username"];
            [[av textFieldAtIndex:1] setPlaceholder:@"password"];
            [av textFieldAtIndex:0].autocorrectionType = UITextAutocorrectionTypeNo;
            [av textFieldAtIndex:1].autocorrectionType = UITextAutocorrectionTypeNo;
            [av show];
        }
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    // Editing will begin
    x += 1;
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    // Editing will end
    x -= 1;
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    // Scroll to the selected TextField when it is selected
    if(x > 0)
    {
        [self.view scrollToView:textField];
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    // Only scroll to y:0 if the keyboard is deselected
    if(x < 0)
    {
        [self.view scrollToY:0];
    }
}

// Scroll to y:0 if the keyboard is deselected
- (void) keyboardDidHide:(NSNotification *)notif {
    [self.view scrollToY:0];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Set view adjustment integer to default value
    x = 0;
    [Cart clearCart];
    // Get the new view controller using [segue destinationViewController].
    ProfileViewController *pvc = [segue destinationViewController];
    // Pass the selected object to the new view controller.
    [pvc logInWithPerson:foundUser];
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    // Try to find the Person for the username entered
    foundUser = [People lookup: userNameField.text];
    
    // User found
    if(foundUser != nil)
    {
        // Check password for user
        BOOL accessGranted = [allUsers checkPassword:passwordField.text forUser:foundUser];
        
        // Password correct
        if (accessGranted) {
            [Person saveSharedPerson:foundUser];
            return YES;
        }
        // Password incorrect. let user know
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"The password is incorrect"
                                                            message: @"Please check to make sure the password was typed correctly"
                                                           delegate: nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            return NO;
        }
    }
    // Username was not found. Let the user know
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"User not found"
                                                        message: @"Please check to make sure the username is correct"
                                                       delegate: nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return NO;
    }
}

@end
