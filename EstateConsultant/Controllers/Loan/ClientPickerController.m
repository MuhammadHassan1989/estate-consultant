//
//  ClientPickerController.m
//  EstateConsultant
//
//  Created by farthinker on 5/20/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import "ClientPickerController.h"


@implementation ClientPickerController

@synthesize clients = _clients;
@synthesize parentPopover = _parentPopover;
@synthesize calculatorController = _calculatorController;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [_clients release];
    [_filteredClients release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.clients = [[DataProvider sharedProvider] getClients];
}

- (void)viewDidUnload
{
    [self setClients:nil];
    [self setParentPopover:nil];
    [self setCalculatorController:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSInteger number = 0;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        number = MIN(10, _filteredClients.count);
    } else {
        number = MIN(10, _clients.count);
    }
    return number;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ClientCell";
    
    UILabel *phoneLabel;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        
        phoneLabel = [[[UILabel alloc] initWithFrame:CGRectMake(190, 2, 120, 40)] autorelease];
        phoneLabel.tag = 1;
        phoneLabel.font = [UIFont systemFontOfSize:16.0];
        phoneLabel.textAlignment = UITextAlignmentRight;
        phoneLabel.textColor = [UIColor colorWithWhite:0.6 alpha:1.0];
        phoneLabel.highlightedTextColor = [UIColor colorWithWhite:1.0 alpha:1.0];
        phoneLabel.opaque = YES;
        [cell.contentView addSubview:phoneLabel];
    } else {
        phoneLabel = (UILabel *)[cell.contentView viewWithTag:1];
    }
    
    Client *client;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        client = [_filteredClients objectAtIndex:indexPath.row];
    } else {
        client = [_clients objectAtIndex:indexPath.row];
    }
    
    NSString *imagePath;
    if (client.starred.boolValue) {
        imagePath = [[NSBundle mainBundle] pathForResource:@"star-on.png" ofType:nil];
    } else {
        imagePath = [[NSBundle mainBundle] pathForResource:@"star.png" ofType:nil];
    }
    UIImage *starImage = [[UIImage alloc] initWithContentsOfFile:imagePath];
    [cell.imageView setImage:starImage];
    [starImage release];
    
    cell.textLabel.font = [UIFont systemFontOfSize:18];
    if (client.sex.intValue == 0) {
        cell.textLabel.text = [client.name stringByAppendingString:@"女士"];
    } else if (client.sex.intValue == 1) {
        cell.textLabel.text = [client.name stringByAppendingString:@"先生"];        
    }
    
    phoneLabel.text = client.phone;
    [cell.contentView bringSubviewToFront:phoneLabel];
    
    return cell;
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
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Client *client;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        client = [_filteredClients objectAtIndex:indexPath.row];
    } else {
        client = [_clients objectAtIndex:indexPath.row];
    }
    
    self.calculatorController.client = client;
    [self.parentPopover dismissPopoverAnimated:YES];
}


#pragma mark - Search display delegate

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.phone CONTAINS %@ || SELF.name CONTAINS %@", searchString, searchString];
    
    [_filteredClients release];
    _filteredClients = [[_clients filteredArrayUsingPredicate:predicate] retain];
    
    return YES;
}

@end
