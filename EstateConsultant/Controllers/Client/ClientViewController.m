//
//  ClientViewController.m
//  EstateConsultant
//
//  Created by farthinker on 5/29/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import "ClientViewController.h"
#import "ClientListController.h"
#import "ClientDetailController.h"


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
    [[NSNotificationCenter defaultCenter] removeObserver:self];

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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ClientListController *clientListController = [[ClientListController alloc] initWithNibName:@"ClientListController" 
                                                                                        bundle:nil];
    clientListController.consultant = self.consultant;
    [self pushViewController:clientListController];
    [clientListController release];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(selectClient:)
                                                 name:@"SelectClient"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(startSearchClient:)
                                                 name:@"StartSearchClient"
                                               object:nil];
}


- (void)viewDidUnload
{
    [self setConsultant:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}


#pragma notification handler

- (void)selectClient:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    Client *client = [userInfo valueForKey:@"client"];
    
    ClientDetailController *clientDetailController;
    if (self.viewControllers.count < 2) {
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"sequence" ascending:YES];    
        NSArray *profiles = [self.consultant.estate.profiles sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
        [sortDescriptor release];
        
        clientDetailController = [[ClientDetailController alloc] initWithNibName:@"ClientDetailController" bundle:nil];
        clientDetailController.profiles = profiles;
        [self pushViewController:clientDetailController];
        [clientDetailController release];
    } else {
        clientDetailController = [self.viewControllers objectAtIndex:1];
    }
    
    clientDetailController.client = client;
    [clientDetailController endEditClient:nil];
    [self showViewAtIndex:1];
}

- (void)startSearchClient:(NSNotification *)notification
{
    [self showViewAtIndex:0];
}

@end
