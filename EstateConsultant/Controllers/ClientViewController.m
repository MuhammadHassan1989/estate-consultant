//
//  ClientViewController.m
//  EstateConsultant
//
//  Created by farthinker on 4/29/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import "ClientViewController.h"
#import "ClientTypeController.h"
#import "ClientListViewController.h"

@implementation ClientViewController

@synthesize consultant = _consultant;

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
    [_listNavController release];
    [_detailController release];
    [_consultant release];
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
    
    ClientTypeController *clientTypeController = [[ClientTypeController alloc] initWithNibName:@"ClientTypeController" bundle:nil];
    clientTypeController.consultant = self.consultant;
    clientTypeController.navigationItem.title = @"分类";
    _listNavController = [[UINavigationController alloc] initWithRootViewController:clientTypeController];
    [clientTypeController release];
    
    ClientListViewController *clientListController = [[ClientListViewController alloc] initWithNibName:@"ClientListViewController" bundle:nil];
    clientListController.clientType = 0;
    clientListController.consultant = self.consultant;
    clientListController.navigationItem.title = @"我的客户";
    [_listNavController pushViewController:clientListController animated:NO];
    [clientListController release];
    
    [_listNavController.view setFrame:CGRectMake(0, 0, 320, 694)];
    [_listNavController viewWillAppear:NO];
    [self.view addSubview:_listNavController.view];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showClient:)
                                                 name:@"SelectClient"
                                               object:nil];
}

- (void)viewDidUnload
{
    [self setConsultant:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft) ||
    (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (void)showClient:(NSNotification *)notification
{
    if (_detailController == nil) {
        _detailController = [[ClientDetailController alloc] initWithNibName:@"ClientDetailController" bundle:nil];
        [_detailController.view setFrame:CGRectMake(322, 0, 702, 694)];
        [self.view addSubview:_detailController.view];
    }
    
    Client *client = [[notification userInfo] valueForKey:@"client"];
    _detailController.client = client;
}

@end
