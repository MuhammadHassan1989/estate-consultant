//
//  StockListController.m
//  EstateConsultant
//
//  Created by farthinker on 5/17/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import "StockListController.h"
#import "StockListHeaderView.h"

@implementation StockListController

@synthesize batch = _batch;
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
    [_batch release];
    [_buildings release];
    [_positionArray release];
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
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"number" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    _buildings = [[self.batch.buildings sortedArrayUsingDescriptors:sortDescriptors] retain];
    
    _positionArray = [[NSMutableArray alloc] initWithCapacity:_buildings.count];
    for (Building *building in _buildings) {
        NSMutableArray *positions = [[NSMutableArray alloc] init];
        NSArray *units = [building.units sortedArrayUsingDescriptors:sortDescriptors];
        for (Unit *unit in units) {
            NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"positionID" ascending:YES];
            [positions addObjectsFromArray:[unit.positions sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]]];
            [sortDescriptor release];
        }
        [_positionArray addObject:positions];
        [positions release];
    }
    
    [sortDescriptor release];
}

- (void)viewDidUnload
{
    [self setTableView:nil];
    [self setBatch:nil];
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
    return _buildings.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSArray *positions = [_positionArray objectAtIndex:section];
    return positions.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    Building *building = [_buildings objectAtIndex:section];
    
    UIViewController *headerController = [[UIViewController alloc] initWithNibName:@"StockListHeaderView" bundle:nil];
    StockListHeaderView *headerView = (StockListHeaderView *)headerController.view;
    headerView.nameLabel.text = [NSString stringWithFormat:@"%@号楼", building.number];
    
    [[headerView retain] autorelease];
    [headerController release];
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PositionCell";
    
    UILabel *descLabel;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.backgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"listitem.png"]] autorelease];
        cell.selectedBackgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"listitem-selected.png"]] autorelease];
        cell.indentationLevel = 1;
        
        descLabel = [[[UILabel alloc] initWithFrame:CGRectMake(180, 2, 120, 40)] autorelease];
        descLabel.tag = 1;
        descLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
        descLabel.textAlignment = UITextAlignmentRight;
        descLabel.textColor = [UIColor colorWithHue:0 saturation:0 brightness:0.4 alpha:1.0];
        descLabel.highlightedTextColor = [UIColor whiteColor];
        descLabel.backgroundColor = [UIColor colorWithHue:0.097 saturation:0.05 brightness:0.96 alpha:1.0];
        descLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        [cell.contentView addSubview:descLabel];
    } else {
        descLabel = (UILabel *)[cell.contentView viewWithTag:1];
    }
    
    NSArray *positions = [_positionArray objectAtIndex:indexPath.section];
    Position *position = [positions objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@单元 - %@号", position.unit.number, position.name];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.status == 1"];
    NSSet *stockHouses = [position.houses filteredSetUsingPredicate:predicate];
    descLabel.text = [NSString stringWithFormat:@"%i套待售", stockHouses.count];
    
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
    UILabel *descLabel = (UILabel *)[cell.contentView viewWithTag:1];
    [cell.contentView bringSubviewToFront:descLabel];
    
    cell.textLabel.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:18];
    cell.textLabel.textColor = [UIColor blackColor];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *positions = [_positionArray objectAtIndex:indexPath.section];
    Position *position = [positions objectAtIndex:indexPath.row];
    
    NSDictionary *userInfo = [[NSDictionary alloc] initWithObjectsAndKeys:position, @"position", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SelectPosition"
                                                        object:self
                                                      userInfo:userInfo];
    [userInfo release];
}

@end
