//
//  LayoutViewController.m
//  EstateConsultant
//
//  Created by farthinker on 4/29/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import "LayoutViewController.h"
#import "LayoutListController.h"
#import "DataProvider.h"


@implementation LayoutViewController

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
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    [_batch release];
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
    
    LayoutListController *layoutListController = [[LayoutListController alloc] initWithNibName:@"LayoutListController" bundle:nil];
    layoutListController.batch = self.batch;
    [self pushViewController:layoutListController];
    [layoutListController release];
        
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showLayout:)
                                                 name:@"SelectLayout"
                                               object:nil];
}

- (void)viewDidUnload
{
    [self setBatch:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft) ||
    (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (void)showLayout:(NSNotification *)notification
{
    Layout *layout = (Layout *)[[notification userInfo] valueForKey:@"layout"];   
    
    LayoutDetailController *detailController;
    if (self.viewControllers.count < 2) {
        detailController = [[LayoutDetailController alloc] initWithNibName:@"LayoutDetailController" bundle:nil];
        [self pushViewController:detailController];
    } else {
        detailController = [self.viewControllers objectAtIndex:1];
    }
        
    detailController.layout = layout;
    [self showViewAtIndex:1];
}

@end
