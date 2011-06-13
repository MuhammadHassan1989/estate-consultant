//
//  LayoutListController.m
//  EstateConsultant
//
//  Created by farthinker on 5/17/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import "LayoutListController.h"
#import "DataProvider.h"

@implementation LayoutListController

@synthesize tableView = _tableView;
@synthesize batch = _batch;

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
    [_layouts release];
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
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"layoutID" ascending:YES];
    _layouts = [[self.batch.layouts sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]] retain];
    [sortDescriptor release];
}

- (void)viewDidUnload
{
    [self setBatch:nil];
    [self setTableView:nil];
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
    return _layouts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"LayoutCell";
    
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
    
    Layout *layout = [_layouts objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@（%@）", layout.name, layout.desc];
    descLabel.text = [NSString stringWithFormat:@"%i㎡", (NSInteger)roundf(layout.poolArea.floatValue + layout.floorArea.floatValue)];
        
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
    Layout *layout = [_layouts objectAtIndex:indexPath.row];
    
    NSDictionary *userInfo = [[NSDictionary alloc] initWithObjectsAndKeys:layout, @"layout", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SelectLayout"
                                                        object:self
                                                      userInfo:userInfo];
    [userInfo release];
}

@end
