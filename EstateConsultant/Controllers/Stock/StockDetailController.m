//
//  StockDetailController.m
//  EstateConsultant
//
//  Created by farthinker on 5/18/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import "StockDetailController.h"
#import "StockTableViewCell.h"


@implementation StockDetailController

@synthesize position = _position;
@synthesize navItem = _navItem;
@synthesize tableView = _tableView;

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
    [_position release];
    [_navItem release];
    [_houses release];
    [_tableView release];
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
    
    self.tableView.allowsSelection = NO;
}

- (void)viewDidUnload
{
    [self setPosition:nil];
    [self setNavItem:nil];
    [self setTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (void)setPosition:(Position *)position
{
    if (position == _position) {
        return;
    }
    
    self.navItem.title = position.name;
    
    [_houses release];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"floor" ascending:NO];
    _houses = [position.houses sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    [_houses retain];
    [sortDescriptor release];
    
    [self.tableView reloadData];
    
    [_position release];
    _position = [position retain];
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
    return _houses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"StockCell";
    
    StockTableViewCell *cell = (StockTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        UIViewController *cellController = [[UIViewController alloc] initWithNibName:@"StockTableViewCell" bundle:nil];
        cell = [[(StockTableViewCell *)cellController.view retain] autorelease];
        [cellController release];
    }
    
    cell.house = [_houses objectAtIndex:indexPath.row];
    
    return cell;
}

@end
