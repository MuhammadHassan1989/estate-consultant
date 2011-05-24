//
//  ClientListViewController.m
//  EstateConsultant
//
//  Created by farthinker on 5/1/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import "ClientListController.h"
#import "ClientCreateController.h"


@implementation ClientListController

@synthesize clientType = _clientType;
@synthesize consultant = _consultant;
@synthesize clients = _clients;

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
    for (Client *client in self.clients) {
        [self removeObserverForClient:client];
    }
    [_clients release];
    [_filteredClients release];
    [_consultant release];
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

    self.clearsSelectionOnViewWillAppear = NO;
    
    NSArray *clients = [[DataProvider sharedProvider] getClientsByType:self.clientType 
                                                          ofConsultant:self.consultant];
    NSMutableArray *mutableClients = [[NSMutableArray alloc] initWithArray:clients];
    self.clients = mutableClients;
    [mutableClients release];
    
    for (Client *client in self.clients) {
        [self addObserverForClient:client];
    }
    
    if (self.clientType == 0) {
        UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd 
                                                                                   target:self 
                                                                                   action:@selector(showCreatePopover:)];
        self.navigationItem.rightBarButtonItem = addButton;
        [addButton release];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(clientCreated:) 
                                                 name:@"CreateClient" 
                                               object:nil];
    
    self.searchDisplayController.searchBar.placeholder = @"输入姓名或手机号码搜索";
}

- (void)viewDidUnload
{
    [self setConsultant:nil];
    [self setClients:nil];
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

- (void)showCreatePopover:(id)sender
{
    ClientCreateController *createController = [[ClientCreateController alloc] initWithNibName:@"ClientCreateController" 
                                                                                                bundle:nil];
    createController.contentSizeForViewInPopover = CGSizeMake(340, 243);
    createController.consultant = self.consultant;
        
    UIPopoverController *popoverController = [[UIPopoverController alloc] initWithContentViewController:createController];
    popoverController.delegate = self;
    createController.parentPopover = popoverController;
    [createController release];
    
    [popoverController presentPopoverFromBarButtonItem:sender
                              permittedArrowDirections:UIPopoverArrowDirectionAny
                                              animated:YES];
    
    popoverController.passthroughViews = nil;
}

- (void)clientCreated:(NSNotification *)notification
{
    Client *newClient = [[notification userInfo] valueForKey:@"client"];
    [self addObserverForClient:newClient];
    [self.clients insertObject:newClient atIndex:0];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    NSArray *indexPaths = [[NSArray alloc] initWithObjects:indexPath, nil];
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
    [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
    [self.tableView.delegate tableView:self.tableView didSelectRowAtIndexPath:indexPath];
    [indexPaths release];
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    [popoverController release];
}

- (void)addObserverForClient:(Client *)client
{
    [client addObserver:self forKeyPath:@"starred" options:NSKeyValueObservingOptionNew context:nil];
    [client addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    [client addObserver:self forKeyPath:@"phone" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)removeObserverForClient:(Client *)client
{
    [client removeObserver:self forKeyPath:@"starred"];
    [client removeObserver:self forKeyPath:@"name"];
    [client removeObserver:self forKeyPath:@"phone"];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger number = 0;
    if (tableView == self.tableView) {
        number = _clients.count;
    } else if (tableView == self.searchDisplayController.searchResultsTableView) {
        number = _filteredClients.count;
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
    if (tableView == self.tableView) {
        client = [_clients objectAtIndex:indexPath.row];
    } else if (tableView == self.searchDisplayController.searchResultsTableView) {
        client = [_filteredClients objectAtIndex:indexPath.row];
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
    Client *client = nil;
    if (tableView == self.tableView) {
        client = [_clients objectAtIndex:indexPath.row];
    } else if (tableView == self.searchDisplayController.searchResultsTableView) {
        client = [_filteredClients objectAtIndex:indexPath.row];
        [self.searchDisplayController.searchBar resignFirstResponder];
    }
    
    NSDictionary *userInfo = [[NSDictionary alloc] initWithObjectsAndKeys:client, @"client", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SelectClient"
                                                        object:self
                                                      userInfo:userInfo];
    [userInfo release];
}


#pragma mark - Search display delegate

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.phone CONTAINS %@ || SELF.name CONTAINS %@", searchString, searchString];
    
    [_filteredClients release];
    _filteredClients = [[_clients filteredArrayUsingPredicate:predicate] retain];
    
    return YES;
}


#pragma mark - Key-Value Observing

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[_clients indexOfObject:object] inSection:0];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    if ([keyPath isEqualToString:@"starred"]) {
        NSString *imagePath;
        if ([[object valueForKeyPath:keyPath] boolValue]) {
            imagePath = [[NSBundle mainBundle] pathForResource:@"star-on.png" ofType:nil];
        } else {
            imagePath = [[NSBundle mainBundle] pathForResource:@"star.png" ofType:nil];
        }
        UIImage *starImage = [[UIImage alloc] initWithContentsOfFile:imagePath];
        [cell.imageView setImage:starImage];
        [starImage release];
    } else if ([keyPath isEqualToString:@"name"]) {
        cell.textLabel.text = [object valueForKeyPath:keyPath];
    } else if ([keyPath isEqualToString:@"phone"]) {
        UILabel *phoneLabel = (UILabel *)[cell.contentView viewWithTag:1];
        phoneLabel.text = [object valueForKeyPath:keyPath];
    }

}

@end
