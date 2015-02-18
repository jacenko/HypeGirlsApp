//  PROGRAMMERS: Deniss Jacenko and Michael O'Reggio
//  CLASS: COP4655 Tue/Thur 5pm - 6:15pm
//  INSTRUCTOR: Steve Luis
//  ASSIGNMENT: Shopping Experience Concept (Group 3)
//  DUE: Thursday 12/11/14
//
//  Created by Deniss Jacenko and Michael O'Reggio
//  Creative Commons Attribution International 4.0 Licence
//
//  OrdersViewController.m
//  HypeGirlsApp

#import "OrdersViewController.h"

@interface OrdersViewController ()

@end

@implementation OrdersViewController

@synthesize ordersField;

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
    // Show orders for the currently logged in person
    [self showOrdersForUser:[Person shared]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Prints order history for a user in the orders TextField
-(void) showOrdersForUser: (Person *) p
{
    // Only prints the history if the user has had previous orders
    if (p.recentPurchases != nil)
    {
        NSString *lastString = nil;
        // Go through purchase history for a user
        for(NSString *purchase in p.recentPurchases){
            // If this is the first order, print it normally
            if(lastString == nil)
            {
                ordersField.text = [NSString stringWithFormat:@"%@", purchase];
                lastString = ordersField.text;
            }
            // If it is a subsequent order, print it along with the last ones
            else
            {
                ordersField.text = [NSString stringWithFormat:@"%@\r\r%@", lastString, purchase];
                lastString = ordersField.text;
            }
            
        }
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

- (IBAction)hideOrders:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
