//  PROGRAMMERS: Deniss Jacenko and Michael O'Reggio
//  CLASS: COP4655 Tue/Thur 5pm - 6:15pm
//  INSTRUCTOR: Steve Luis
//  ASSIGNMENT: Shopping Experience Concept (Group 3)
//  DUE: Thursday 12/11/14
//
//  Created by Deniss Jacenko and Michael O'Reggio
//  Creative Commons Attribution International 4.0 Licence
//
//  CartViewController.m
//  HypeGirlsApp

#import "CartViewController.h"

@interface CartViewController ()

@end

@implementation CartViewController

@synthesize cartDescription;

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
    
    // Set cartDescription to the Cart Singleton information
    cartDescription.text = [Cart shared];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

// Hide modal view
- (IBAction)pressBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// User presses check out
- (IBAction)checkOut:(id)sender {
    // Do something if the cart is not empty
    if([Cart shared] != nil)
    {
        // Complete the transaction
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Thank you!"
                                                        message: @"Your transaction is complete"
                                                       delegate: nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        
        
        // Save order to the history if user is logged in and clear the cart
        [[Person shared] saveOrderToHistory:[Cart shared]];
        [People savePerson:[Person shared]];
        [Cart clearCart];
        cartDescription.text = [Cart shared];
        [alert show];
    }
}

// Clear the cart when the Clear Cart button is pressed
- (IBAction)clearCart:(id)sender {
    [Cart clearCart];
    cartDescription.text = [Cart shared];
}

@end
