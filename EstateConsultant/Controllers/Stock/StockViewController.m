//
//  StockViewController.m
//  EstateConsultant
//
//  Created by farthinker on 4/29/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import "StockViewController.h"
#import "StockListController.h"


@implementation StockViewController

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
    [_navController release];
    [_detailController release];
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
    stockListController.navigationItem.title = @"所有位置";
    _navController = [[UINavigationController alloc] initWithRootViewController:stockListController];
    [stockListController release];
    
    [_navController.view setFrame:CGRectMake(0, 0, 320, 694)];
    [self.view addSubview:_navController.view];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showStockTable:)
                                                 name:@"SelectPosition"
                                               object:nil];
}

- (void)viewDidUnload
{
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
    if (_detailController == nil) {
        _detailController = [[StockDetailController alloc] initWithNibName:@"StockDetailController" bundle:nil];
        [_detailController.view setFrame:CGRectMake(322, 0, 702, 694)];
        [self.view addSubview:_detailController.view];
    }
    
    Position *position = (Position *)[[notification userInfo] valueForKey:@"position"];
    _detailController.position = position;
}

@end
