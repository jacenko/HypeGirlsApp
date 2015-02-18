//  PROGRAMMERS: Deniss Jacenko and Michael O'Reggio
//  CLASS: COP4655 Tue/Thur 5pm - 6:15pm
//  INSTRUCTOR: Steve Luis
//  ASSIGNMENT: Shopping Experience Concept (Group 3)
//  DUE: Thursday 12/11/14
//
//  Created by Deniss Jacenko and Michael O'Reggio
//  Creative Commons Attribution International 4.0 Licence
//
//  ShopTableViewController.m
//  HypeGirlsApp

#import "ShopTableViewController.h"
#import "ProductViewController.h"
#import "Products.h"

@interface ShopTableViewController ()

@end

@implementation ShopTableViewController
{
    // Array of search results
    NSArray *searchResults;
}

@synthesize names, prices, descriptions, photos;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // Initialize objects for finding and viewing table information
    Products *shop = [[Products alloc] init];
    [shop loadStore];
    names = [[NSArray alloc] initWithArray:shop.names];
    prices = [[NSArray alloc] initWithArray:shop.prices];
    descriptions = [[NSArray alloc] initWithArray:shop.descriptions];
    photos = [[NSArray alloc] initWithArray:shop.photos];
    
    // Set status bar to a white color when the app opens
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    // Set navbar title to the Hype Store logo
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hypestorelogo.png"]];
    
    // Set navbar color to the theme
    self.navigationController.navigationBar.barTintColor = [Theme shared];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

// Filter table view with found results
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"name contains[c] %@", searchText];
    searchResults = [names filteredArrayUsingPredicate:resultPredicate];
}

// Display the new tableview with the sarch results
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}

// Return number of rows for either default or search tableviews
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [searchResults count];
        
    } else {
        return [names count];
    }
}

// Set cell information
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@", [searchResults objectAtIndex:indexPath.row]];
    } else {
        cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.names objectAtIndex:indexPath.row]];
    }

    if (tableView == self.searchDisplayController.searchResultsTableView) {
        //cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", [searchResults objectAtIndex:indexPath.row]]];
    } else {
        cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", [self.photos objectAtIndex:indexPath.row]]];
    }
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        //cell.detailTextLabel.text = [NSString stringWithFormat:@"$%@", [searchResults objectAtIndex:indexPath.row]];
    } else {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"$%@", [self.prices objectAtIndex:indexPath.row]];
    }
    return cell;
}



- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

// User pressed return
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

// User pressed outside of the keyboard
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self view] endEditing:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    ProductViewController *pvc = [segue destinationViewController];
    // Pass the selected object to the new view controller.
    // Send information about the product selected
    NSIndexPath *path = [self.tableView indexPathForSelectedRow];
    NSString *n = names[path.row];
    NSString *p = prices[path.row];
    NSString *d = descriptions[path.row];
    NSString *photo = photos[path.row];
    pvc.name = n;
    pvc.price = p;
    pvc.description = d;
    pvc.photo = photo;
}

@end
