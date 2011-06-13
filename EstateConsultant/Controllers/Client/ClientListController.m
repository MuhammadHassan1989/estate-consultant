//
//  ClientListViewController.m
//  EstateConsultant
//
//  Created by farthinker on 5/1/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import "ClientListController.h"


@implementation ClientListController

@synthesize consultant = _consultant;
@synthesize dataSource = _dataSource;
@synthesize tableView = _tableView;
@synthesize searchField = _searchField;

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
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    for (Client *client in _clients) {
        [self removeObserverForClient:client];
    }
    [_clients release];
    [_dataSource release];
    [_consultant release];
    [_tableView release];
    [_searchField release];
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
    for (Client *client in _clients) {
        [self addObserverForClient:client];
    }
    self.dataSource = _clients;
    
                
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(clientCreated:) 
                                                 name:@"CreateClient" 
                                               object:nil];
}

- (void)viewDidUnload
{
    [self setConsultant:nil];
    [self setDataSource:nil];
    [self setTableView:nil];
    [self setSearchField:nil];
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

- (void)clientCreated:(NSNotification *)notification
{
    Client *newClient = [[notification userInfo] valueForKey:@"client"];
    [self addObserverForClient:newClient];
    [_clients insertObject:newClient atIndex:0];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    NSArray *indexPaths = [[NSArray alloc] initWithObjects:indexPath, nil];
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
    [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
    [self.tableView.delegate tableView:self.tableView didSelectRowAtIndexPath:indexPath];
    [indexPaths release];
}

- (void)addObserverForClient:(Client *)client
{
    [client addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    [client addObserver:self forKeyPath:@"sex" options:NSKeyValueObservingOptionNew context:nil];
    [client addObserver:self forKeyPath:@"phone" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)removeObserverForClient:(Client *)client
{
    [client removeObserver:self forKeyPath:@"name"];
    [client removeObserver:self forKeyPath:@"sex"];
    [client removeObserver:self forKeyPath:@"phone"];
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

- (IBAction)changeSearchScope:(SingleSelectControl *)sender {
    [self filterClients:self.searchField.text];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
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
        cell.indentationLevel = 1;
        cell.backgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"listitem.png"]] autorelease];
        cell.selectedBackgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"listitem-selected.png"]] autorelease];
        
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
    sexFrame.origin.x = CGRectGetMinX(cell.textLabel.frame) + [cell.textLabel.text sizeWithFont:cell.textLabel.font].width + 5;
    sexLabel.frame = sexFrame;
    [cell.contentView bringSubviewToFront:sexLabel];

    UILabel *phoneLabel = (UILabel *)[cell.contentView viewWithTag:1];
    [cell.contentView bringSubviewToFront:phoneLabel];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Client *client = [self.dataSource objectAtIndex:indexPath.row];
    [self.searchField resignFirstResponder];
    
    NSDictionary *userInfo = [[NSDictionary alloc] initWithObjectsAndKeys:client, @"client", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SelectClient"
                                                        object:self
                                                      userInfo:userInfo];
    [userInfo release];
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


#pragma mark - Key-Value Observing

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[_clients indexOfObject:object] inSection:0];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    if ([keyPath isEqualToString:@"name"]) {
        cell.textLabel.text = [object valueForKeyPath:keyPath];
        
        UILabel *sexLabel = (UILabel *)[cell.contentView viewWithTag:2];
        CGRect sexFrame = sexLabel.frame;
        sexFrame.origin.x = CGRectGetMinX(cell.textLabel.frame) + [cell.textLabel.text sizeWithFont:cell.textLabel.font].width + 5;
        sexLabel.frame = sexFrame;
    } else if ([keyPath isEqualToString:@"sex"]) {
        NSString *sexText = @"女士";
        if ([[object valueForKeyPath:keyPath] intValue] > 0) {
            sexText = @"先生";
        }
        UILabel *sexLabel = (UILabel *)[cell.contentView viewWithTag:2];
        sexLabel.text = sexText;
    }else if ([keyPath isEqualToString:@"phone"]) {
        UILabel *phoneLabel = (UILabel *)[cell.contentView viewWithTag:1];
        phoneLabel.text = [object valueForKeyPath:keyPath];
    }

}

@end
