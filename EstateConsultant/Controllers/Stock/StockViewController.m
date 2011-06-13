//
//  StockViewController.m
//  EstateConsultant
//
//  Created by farthinker on 4/29/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import "StockViewController.h"
#import "StockListController.h"
#import "StockDetailController.h"

@implementation StockViewController

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

    StockListController *stockListController = [[StockListController alloc] initWithNibName:@"StockListController" bundle:nil];
    stockListController.batch = self.batch;
    [self pushViewController:stockListController];
    [stockListController release];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showStockTable:)
                                                 name:@"SelectPosition"
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

- (void)showStockTable:(NSNotification *)notification
{
    Position *position = (Position *)[[notification userInfo] valueForKey:@"position"];   
    
    StockDetailController *detailController;
    if (self.viewControllers.count < 2) {
        detailController = [[StockDetailController alloc] initWithNibName:@"StockDetailController" bundle:nil];
        [self pushViewController:detailController];
    } else {
        detailController = [self.viewControllers objectAtIndex:1];
    }
    
    detailController.position = position;
    [self showViewAtIndex:1];
}

@end
