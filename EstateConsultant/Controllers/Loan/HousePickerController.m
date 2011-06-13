//
//  HousePickerController.m
//  EstateConsultant
//
//  Created by farthinker on 6/12/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import "HousePickerController.h"


@implementation HousePickerController

@synthesize position = _position;
@synthesize tableView = _tableView;
@synthesize calculatorController = _calculatorController;
@synthesize parentPopover = _parentPopover;


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
    [_tableView release];
    [_houses release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)selectHouse:(House *)house animated:(Boolean)animated
{
    NSInteger row = [_houses indexOfObject:house];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    [self.tableView selectRowAtIndexPath:indexPath animated:animated scrollPosition:UITableViewScrollPositionTop];
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSSortDescriptor *sortFloor = [[NSSortDescriptor alloc] initWithKey:@"floor" ascending:NO];
    _houses = [[self.position.houses sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortFloor]] retain];
    [sortFloor release];
}

- (void)viewDidUnload
{
    [self setPosition:nil];
    [self setTableView:nil];
    [self setCalculatorController:nil];
    [self setParentPopover:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
    return _houses.count;
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
    
    House *house = [_houses objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@楼", house.floor];
    
    if (house.status.intValue == 1) {
        descLabel.text = @"待售";
    } else if (house.status.intValue == 2) {
        descLabel.text = @"被认购";
    } else if (house.status.intValue > 2) {
        descLabel.text = @"已售";
    }
    
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
    House *house = [_houses objectAtIndex:indexPath.row];
    
    self.calculatorController.house = house;
    [self.parentPopover dismissPopoverAnimated:YES];
}


@end
