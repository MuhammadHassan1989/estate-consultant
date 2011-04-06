//
//  LoginViewController.m
//  EstateConsultant
//
//  Created by farthinker on 4/1/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import "LoginViewController.h"
#import "ClientListViewController.h"
#import "EstateConsultantAppDelegate.h"
#import "DataProvider.h"


@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[DataProvider sharedProvider] setIsDemo:NO];
    }
    return self;
}

- (void)dealloc
{
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
    // Do any additional setup after loading the view from its nib.
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
	return YES;
}

- (IBAction)tryDemo:(id)sender forEvent:(UIEvent *)event
{
    [DataProvider sharedProvider].isDemo = YES;
    
    ClientListViewController *clientListController = [[ClientListViewController alloc] initWithNibName:@"ClientListViewController" bundle:nil];
    clientListController.consultant = [[DataProvider sharedProvider] getConsultantByID:1];
    [clientListController.view setFrame:[UIScreen mainScreen].applicationFrame];
    
    EstateConsultantAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.viewController = clientListController;
    [clientListController release];
}

@end
