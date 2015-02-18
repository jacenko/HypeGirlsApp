//  PROGRAMMERS: Deniss Jacenko and Michael O'Reggio
//  CLASS: COP4655 Tue/Thur 5pm - 6:15pm
//  INSTRUCTOR: Steve Luis
//  ASSIGNMENT: Shopping Experience Concept (Group 3)
//  DUE: Thursday 12/11/14
//
//  Created by Deniss Jacenko and Michael O'Reggio
//  Creative Commons Attribution International 4.0 Licence
//
//  ShopTableViewController.h
//  HypeGirlsApp

#import <UIKit/UIKit.h>
#import "Theme.h"

@interface ShopTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

// Properties for what is shown in the table view cells
@property (nonatomic, strong) NSArray *names;
@property (nonatomic, strong) NSArray *prices;
@property (nonatomic, strong) NSArray *descriptions;
@property (nonatomic, strong) NSArray *photos;

@end
