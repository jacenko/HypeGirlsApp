//  PROGRAMMERS: Deniss Jacenko and Michael O'Reggio
//  CLASS: COP4655 Tue/Thur 5pm - 6:15pm
//  INSTRUCTOR: Steve Luis
//  ASSIGNMENT: Shopping Experience Concept (Group 3)
//  DUE: Thursday 12/11/14
//
//  Created by Deniss Jacenko and Michael O'Reggio
//  Creative Commons Attribution International 4.0 Licence
//
//  BlogViewController.h
//  HypeGirlsApp

#import <UIKit/UIKit.h>
#import "Theme.h"

@interface BlogViewController : UITableViewController <NSXMLParserDelegate>

// Table view that holds blog post titles
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
