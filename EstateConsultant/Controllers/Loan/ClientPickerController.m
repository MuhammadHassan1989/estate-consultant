//
//  ClientPickerController.m
//  EstateConsultant
//
//  Created by farthinker on 5/20/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import "ClientPickerController.h"


@implementation ClientPickerController

@synthesize consultant = _consultant;
@synthesize parentPopover = _parentPopover;
@synthesize calculatorController = _calculatorController;
@synthesize dataSource = _dataSource;
@synthesize tableView = _tableView;
@synthesize searchField = _searchField;
@synthesize searchFieldBackground = _searchFieldBackground;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [_clients release];
    [_dataSource release];
    [_consultant release];
    [_tableView release];
    [_searchField release];
    [_searchFieldBackground release];
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

    NSArray *clients = [[DataProvider sharedProvider] getClientsOfEstate:self.consultant.estate];
    _clients = [[NSMutableArray alloc] initWithArray:clients];
    self.dataSource = _clients;
}

- (void)viewDidUnload
{
    [self setConsultant:nil];
    [self setDataSource:nil];
    [self setTableView:nil];
    [self setSearchField:nil];
    [self setParentPopover:nil];
    [self setCalculatorController:nil];
    [self setSearchFieldBackground:nil];
    [super viewDidUnload];
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

- (void)filterClients:(NSString *)searchString
{
    NSArray *results = _clients;
    
    if (searchString != nil && [searchString length] > 0) {
        NSPredicate *clientPredicate = [NSPredicate predicateWithFormat:@"SELF.phone CONTAINS %@ || SELF.name CONTAINS %@", searchString, searchString];
        results = [results filteredArrayUsingPredicate:clientPredicate];
    }
    
    self.dataSource = results;
    [self.tableView reloadData];
}

- (void)selectClient:(Client *)client animated:(Boolean)animated
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[_clients indexOfObject:client] inSection:0];
    [self.tableView selectRowAtIndexPath:indexPath animated:animated scrollPosition:UITableViewScrollPositionTop];
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
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ClientCell";
    
    UILabel *phoneLabel;
    UILabel *sexLabel;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.backgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"listitem.png"]] autorelease];
        cell.selectedBackgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"listitem-selected.png"]] autorelease];
        cell.indentationLevel = 1;
        
        phoneLabel = [[[UILabel alloc] initWithFrame:CGRectMake(180, 2, 120, 40)] autorelease];
        phoneLabel.tag = 1;
        phoneLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
        phoneLabel.textAlignment = UITextAlignmentRight;
        phoneLabel.textColor = [UIColor colorWithHue:0 saturation:0 brightness:0.4 alpha:1.0];
        phoneLabel.highlightedTextColor = [UIColor whiteColor];
        phoneLabel.backgroundColor = [UIColor colorWithHue:0.097 saturation:0.05 brightness:0.96 alpha:1.0];
        phoneLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        [cell.contentView addSubview:phoneLabel];
        
        sexLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 3, 60, 40)] autorelease];
        sexLabel.tag = 2;
        sexLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:18];
        sexLabel.textColor = [UIColor colorWithHue:0 saturation:0 brightness:0.2 alpha:1.0];
        sexLabel.highlightedTextColor = [UIColor whiteColor];
        sexLabel.backgroundColor = [UIColor colorWithHue:0.097 saturation:0.05 brightness:0.96 alpha:1.0];
        
        [cell.contentView addSubview:sexLabel];
    } else {
        phoneLabel = (UILabel *)[cell.contentView viewWithTag:1];
        sexLabel = (UILabel *)[cell.contentView viewWithTag:2];
    }
    
    Client *client = [self.dataSource objectAtIndex:indexPath.row];;
    
    cell.textLabel.text = client.name;
    
    if (client.sex.intValue == 0) {
        sexLabel.text = @"女士";
    } else if (client.sex.intValue == 1) {
        sexLabel.text = @"先生";
    }
    
    phoneLabel.text = client.phone;
    
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

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.textLabel.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:18];
    cell.textLabel.textColor = [UIColor blackColor];
    
    UILabel *sexLabel = (UILabel *)[cell.contentView viewWithTag:2];
    CGRect sexFrame = sexLabel.frame;
    sexFrame.origin.x = 20 + [cell.textLabel.text sizeWithFont:cell.textLabel.font].width + 5;
    sexLabel.frame = sexFrame;
    [cell.contentView bringSubviewToFront:sexLabel];
    
    UILabel *phoneLabel = (UILabel *)[cell.contentView viewWithTag:1];
    [cell.contentView bringSubviewToFront:phoneLabel];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.searchField resignFirstResponder];
    
    Client *client = [self.dataSource objectAtIndex:indexPath.row];
    self.calculatorController.client = client;
    [self.parentPopover dismissPopoverAnimated:YES];
}


#pragma mark - Text field delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"StartSearchClient" object:self];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *searchString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    [self filterClients:searchString];
    
    return YES;
}

@end
