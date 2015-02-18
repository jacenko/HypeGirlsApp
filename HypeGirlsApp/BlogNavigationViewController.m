//
//  BlogNavigationViewController.m
//  HypeGirlsApp
//
//  Created by Deniss Jacenko on 12/9/14.
//  Copyright (c) 2014 FIU. All rights reserved.
//

#import "BlogNavigationViewController.h"

@interface BlogNavigationViewController ()

@end

@implementation BlogNavigationViewController

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
    
    // Set navigation bar colors to white on purple
    self.navigationBar.tintColor = [UIColor colorWithRed:248/255.0f green:191/255.0f blue:234/255.0f alpha:1.0f];
    self.navigationBar.barTintColor = [UIColor colorWithRed:55/255.0f green:2/255.0f blue:82/255.0f alpha:1.0f];
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

@end
