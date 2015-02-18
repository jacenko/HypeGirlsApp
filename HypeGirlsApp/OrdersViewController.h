//  PROGRAMMERS: Deniss Jacenko and Michael O'Reggio
//  CLASS: COP4655 Tue/Thur 5pm - 6:15pm
//  INSTRUCTOR: Steve Luis
//  ASSIGNMENT: Shopping Experience Concept (Group 3)
//  DUE: Thursday 12/11/14
//
//  Created by Deniss Jacenko and Michael O'Reggio
//  Creative Commons Attribution International 4.0 Licence
//
//  OrdersViewController.h
//  HypeGirlsApp

#import <UIKit/UIKit.h>
#import "Person.h"
#import "Cart.h"

@interface OrdersViewController : UIViewController

// Textview for viewing recent orders
@property (weak, nonatomic) IBOutlet UITextView *ordersField;

- (IBAction)hideOrders:(id)sender;

- (void) showOrdersForUser: (Person *) p;

@end
