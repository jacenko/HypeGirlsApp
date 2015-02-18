//  PROGRAMMERS: Deniss Jacenko and Michael O'Reggio
//  CLASS: COP4655 Tue/Thur 5pm - 6:15pm
//  INSTRUCTOR: Steve Luis
//  ASSIGNMENT: Shopping Experience Concept (Group 3)
//  DUE: Thursday 12/11/14
//
//  Created by Deniss Jacenko and Michael O'Reggio
//  Creative Commons Attribution International 4.0 Licence
//
//  ProfileViewController.m
//  HypeGirlsApp

#import "ProfileViewController.h"
#import "OrdersViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController{
    
    // Currently logged in person as an instance
    Person *userLoggedIn;
    
    // Integer used for controlling view adjustment when pulling up the keyboard
    int x;
    
}

@synthesize profilePic, profileName, profileAge, profileEmail;

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
    
    // Set keyboard delegates
    profileName.delegate  = self;
    profileAge.delegate = self;
    profileEmail.delegate = self;
    
    // Adjust keyboard types for numbers and emails
    profileAge.keyboardType = UIKeyboardTypeNumberPad;
    profileEmail.keyboardType = UIKeyboardTypeEmailAddress;
    
    // Set the shown profile pic to either a placeholder or an existing user's profile pic
    if([[Person shared] profilePic] == nil){
        profilePic.image = [UIImage imageNamed: @"placeholder"];
    }
    else
    {
        profilePic.image = [[Person shared] profilePic];
    }
    
    // Add information to the TextFields from the userLoggedIn
    self.profileName.text = [userLoggedIn name];
    if([userLoggedIn age] != 0){
        self.profileAge.text = [NSString stringWithFormat: @"%zd", [userLoggedIn age]];
    }
    self.profileEmail.text = [userLoggedIn email];
    
    // Set a border for the profile picture
    [profilePic.layer setBorderColor: [[UIColor grayColor] CGColor]];
    [profilePic.layer setBorderWidth: 1.0];
    
    // Set View adjustment integer to 0
    // (initial value later used to find whether the view needs adjustment.)
    // (This resolves a previous issue with the entire view jumping
    // when a user selects a diferent TextField)
    x = 0;
    
    // Listen to the keyboard being hidden/shown
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardWillHideNotification object:nil];
    
    // Set logo in the title of the navbar
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hypeprofilelogo.png"]];
    
    // Show theme color in the navbar when view loads
    self.navigationController.navigationBar.barTintColor = [Theme shared];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self view] endEditing:YES];
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

// Scroll to y:0 when the keyboard hides
- (void) keyboardDidHide:(NSNotification *)notif {
    [self.view scrollToY:0];
}

// Set userLoggedIn to the person sent to the method
- (void) logInWithPerson: (Person *) p
{
    userLoggedIn = [[Person alloc] initWithPerson: p];
}

// Save new information for a user and notify them of a successful save
- (IBAction)saveProfile:(id)sender {
    [Person SaveProfileInformationWithName:profileName.text
                                       age:(NSInteger) profileAge.text.integerValue
                                  andEmail:profileEmail.text
                                     photo:profilePic.image];
    [People savePerson:[Person shared]];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Profile Saved"
                                                    message: nil
                                                   delegate: nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

// Show front camera
- (void)takePhoto:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        imagePicker.mediaTypes = @[(NSString *) kUTTypeImage];
        imagePicker.allowsEditing = NO;
        [self presentViewController:imagePicker
                           animated:YES completion:nil];
    }
}



#pragma mark -
#pragma mark UIImagePickerControllerDelegate

// Take and save the image to the user's profilePic
-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image = [self squareImageFromImage:info[UIImagePickerControllerOriginalImage] scaledToSize: 145];
        
        
        
        profilePic.image = image;
        userLoggedIn.profilePic = image;
        [Person saveSharedPerson:userLoggedIn];
    }
}

// User cancelled taking a photo
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

// Crop the taken image to a square
- (UIImage *)squareImageFromImage:(UIImage *)image scaledToSize:(CGFloat)newSize {
    CGAffineTransform scaleTransform;
    CGPoint origin;
    
    if (image.size.width > image.size.height) {
        CGFloat scaleRatio = newSize / image.size.height;
        scaleTransform = CGAffineTransformMakeScale(scaleRatio, scaleRatio);
        
        origin = CGPointMake(-(image.size.width - image.size.height) / 2.0f, 0);
    } else {
        CGFloat scaleRatio = newSize / image.size.width;
        scaleTransform = CGAffineTransformMakeScale(scaleRatio, scaleRatio);
        
        origin = CGPointMake(0, -(image.size.height - image.size.width) / 2.0f);
    }
    
    CGSize size = CGSizeMake(newSize, newSize);
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    } else {
        UIGraphicsBeginImageContext(size);
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextConcatCTM(context, scaleTransform);
    
    [image drawAtPoint:origin];
    
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

// Delete the photo from the view and the user's Person class
- (IBAction)deletePhoto:(id)sender {
    profilePic.image = [UIImage imageNamed: @"placeholder"];
    userLoggedIn.profilePic = nil;
    [Person saveSharedPerson:userLoggedIn];
}

// Set the view adjuster to its original value if user is leaving the view
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    x = 0;
}

@end
