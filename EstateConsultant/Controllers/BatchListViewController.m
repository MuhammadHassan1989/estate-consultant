//
//  BatchListViewController.m
//  EstateConsultant
//
//  Created by farthinker on 6/20/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import "BatchListViewController.h"


@implementation BatchListViewController

@synthesize tableView = _tableView;
@synthesize estate = _estate;
@synthesize parentPopover = _parentPopover;
@synthesize rootController = _rootController;

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
    [_tableView release];
    [_estate release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)selectBatch:(Batch *)batch
{
    NSInteger row = [_batches indexOfObject:batch];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionTop];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"batchID" ascending:YES];
    _batches = [self.estate.batches sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    [sortDescriptor release];
}

- (void)viewDidUnload
{
    [self setParentPopover:nil];
    [self setRootController:nil];
    [self setTableView:nil];
    [self setEstate:nil];
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
    return _batches.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PositionCell";
    
    UILabel *descLabel;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.backgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"listitem.png"]] autorelease];
        cell.selectedBackgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"listitem-tick.png"]] autorelease];
        cell.selectedBackgroundView.contentMode = UIViewContentModeLeft;
        cell.indentationLevel = 3;
        
        descLabel = [[[UILabel alloc] initWithFrame:CGRectMake(180, 2, 120, 40)] autorelease];
        descLabel.tag = 1;
        descLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
        descLabel.textAlignment = UITextAlignmentRight;
        descLabel.textColor = [UIColor colorWithHue:0 saturation:0 brightness:0.4 alpha:1.0];
        descLabel.highlightedTextColor = descLabel.textColor;
        descLabel.backgroundColor = [UIColor colorWithHue:0.097 saturation:0.05 brightness:0.96 alpha:1.0];
        descLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        [cell.contentView addSubview:descLabel];
    } else {
        descLabel = (UILabel *)[cell.contentView viewWithTag:1];
    }
    
    Batch *batch = [_batches objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", batch.name];
    
    NSInteger forSell = 0;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.status == 1"];
    for (Layout *layout in batch.layouts) {
        NSSet *stockHouses = [layout.houses filteredSetUsingPredicate:predicate];
        forSell += stockHouses.count;
    }
    
    if (forSell > 0) {
        descLabel.text = [NSString stringWithFormat:@"%i套待售", forSell];
    } else {
        descLabel.text = @"已售完";
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
    cell.textLabel.highlightedTextColor = cell.textLabel.textColor;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //TODO
    
    [self.parentPopover dismissPopoverAnimated:YES];
}


@end
