//  PROGRAMMERS: Deniss Jacenko and Michael O'Reggio
//  CLASS: COP4655 Tue/Thur 5pm - 6:15pm
//  INSTRUCTOR: Steve Luis
//  ASSIGNMENT: Shopping Experience Concept (Group 3)
//  DUE: Thursday 12/11/14
//
//  Created by Deniss Jacenko and Michael O'Reggio
//  Creative Commons Attribution International 4.0 Licence
//
//  PostViewController.m
//  HypeGirlsApp

#import "PostViewController.h"

@interface PostViewController ()

@end

@implementation PostViewController

@synthesize webView, url;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Readability for optimizing the way a blog post is shown
    NSString *readability = @"http://www.readability.com/m?url=";
    
    // Modify URL entered to use Readability
    NSURL *myURL = [NSURL URLWithString: [[NSString stringWithFormat:@"%@%@", readability, self.url] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    
    // Request page
    NSURLRequest *request = [NSURLRequest requestWithURL:myURL];
    [self.webView loadRequest:request];
    
    // Set navbar title to Hype Girls logo
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hypebloglogo.png"]];
    
    // Set navbar color to theme
    self.navigationController.navigationBar.barTintColor = [Theme shared];
}

@end