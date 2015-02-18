//  PROGRAMMERS: Deniss Jacenko and Michael O'Reggio
//  CLASS: COP4655 Tue/Thur 5pm - 6:15pm
//  INSTRUCTOR: Steve Luis
//  ASSIGNMENT: Shopping Experience Concept (Group 3)
//  DUE: Thursday 12/11/14
//
//  Created by Deniss Jacenko and Michael O'Reggio
//  Creative Commons Attribution International 4.0 Licence
//
//  PostViewController.h
//  HypeGirlsApp

#import <UIKit/UIKit.h>
#import "Theme.h"

@interface PostViewController : UIViewController

// Properties for the webView and the url that will be accessed
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (copy, nonatomic) NSString *url;

//-(void)goToPage:(NSURL *)url;

@end
