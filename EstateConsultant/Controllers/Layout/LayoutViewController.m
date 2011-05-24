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
    
    LayoutListController *layoutListController = [[LayoutListController alloc] initWithNibName:@"LayoutListController" bundle:nil];
    layoutListController.navigationItem.title = @"所有户型";
    _navController = [[UINavigationController alloc] initWithRootViewController:layoutListController];
    [layoutListController release];
    
    [_navController.view setFrame:CGRectMake(0, 0, 320, 694)];
    [self.view addSubview:_navController.view];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showLayout:)
                                                 name:@"SelectLayout"
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

- (void)showLayout:(NSNotification *)notification
{
    if (_detailController == nil) {
        _detailController = [[LayoutDetailController alloc] initWithNibName:@"LayoutDetailController" bundle:nil];
        [_detailController.view setFrame:CGRectMake(322, 0, 702, 694)];
        [self.view addSubview:_detailController.view];
    }
    
    Layout *layout = (Layout *)[[notification userInfo] valueForKey:@"layout"];
    _detailController.layout = layout;
}

@end
