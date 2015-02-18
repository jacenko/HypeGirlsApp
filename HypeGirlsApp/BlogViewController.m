//  PROGRAMMERS: Deniss Jacenko and Michael O'Reggio
//  CLASS: COP4655 Tue/Thur 5pm - 6:15pm
//  INSTRUCTOR: Steve Luis
//  ASSIGNMENT: Shopping Experience Concept (Group 3)
//  DUE: Thursday 12/11/14
//
//  Created by Deniss Jacenko and Michael O'Reggio
//  Creative Commons Attribution International 4.0 Licence
//
//  BlogViewController.m
//  HypeGirlsApp

#import "BlogViewController.h"
#import "PostViewController.h"

@interface BlogViewController ()
{
    // Instance variables for parsing Website xml
    NSXMLParser *parser;
    NSMutableArray *feeds;
    NSMutableArray *feedTitles;
    NSMutableDictionary *item;
    NSMutableString *title;
    NSMutableString *link;
    NSMutableString *description;
    NSString *element;
}

@end

@implementation BlogViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Initialize parser for retrieving blog post titles
    feeds = [[NSMutableArray alloc] init];
    NSURL *url = [NSURL URLWithString:@"http://blog.hypegirls.com/feed/"];
    parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    
    [parser setDelegate:self];
    [parser setShouldResolveExternalEntities:NO];
    [parser parse];
    
    // Set navbar title to the Hype Girls logo
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hypebloglogo.png"]];
    
    // Set navbar color to the theme
    self.navigationController.navigationBar.barTintColor = [Theme shared];
}

// Removes html tags from the description in the subtitle using regular expressions
-(NSString *) stringByStrippingHTML:(NSString *)s
{
    NSRange r;
    while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        s = [s stringByReplacingCharactersInRange:r withString:@""];
    return s;
}

#pragma mark Table View Data Source

// One section in tableviw
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// Number of blog posts shown
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return feeds.count;
}

// Set Table cell text to blog post title and description introduction
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = [[feeds objectAtIndex:indexPath.row] objectForKey: @"title"];
    cell.detailTextLabel.text = [[feeds objectAtIndex:indexPath.row] objectForKey: @"description"];
    return cell;
}

#pragma mark Parser Methods

// Initialize parser
- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict
{
    element = elementName;
    
    if ([element isEqualToString:@"item"])
    {
        item = [[NSMutableDictionary alloc] init];
        title = [[NSMutableString alloc] init];
        link = [[NSMutableString alloc] init];
        description = [[NSMutableString alloc] init];
    }
    
}

// Find the title, URL, and description in the website's XML
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if ([element isEqualToString:@"title"])
    {
        [title appendString:string];
    } else if ([element isEqualToString:@"link"])
    {
        [link appendString:string];
    }else if ([element isEqualToString:@"description"])
    {
        [description appendString:[self stringByStrippingHTML:string]];
    }
}

// Set found information
- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"item"])
    {
        [item setObject:title forKey:@"title"];
        [item setObject:link forKey:@"link"];
        [item setObject:description forKey:@"description"];
        
        [feeds addObject:[item copy]];
        [feedTitles addObject:title];
    }
}

// Load new information into the table view
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    [self.tableView reloadData];
}

// Load the appropriate URL into the selected blog post view
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    PostViewController *pvc = [segue destinationViewController];
    
    NSIndexPath *path = [self.tableView indexPathForSelectedRow];
    
    NSString *url = [[feeds objectAtIndex:path.row] objectForKey: @"link"];
    
    NSLog(@"%@", url);
    pvc.url = url;
}

@end
