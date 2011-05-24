//
//  RootViewController.m
//  EstateConsultant
//
//  Created by farthinker on 4/28/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import "RootViewController.h"
#import "LoanCalculatorController.h"

@implementation RootViewController

@synthesize navTab = _navTab;
@synthesize consultant = _consultant;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)dealloc
{
    [_navTab release];
    [_clientViewController release];
    [_layoutViewController release];
    [_stockViewController release];
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
    
    [[DataProvider sharedProvider] setIsDemo:YES];
    self.consultant = [[DataProvider sharedProvider] getConsultantByID:1];
    self.navTab.selectedSegmentIndex = 0;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(calculateLoan:)
                                                 name:@"CalculateLoan"
                                               object:nil];
    
}

- (void)viewDidUnload
{
    [self setNavTab:nil];
    [self setConsultant:nil];
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

- (IBAction)selectTab:(UISegmentedControl *)sender forEvent:(UIEvent *)event {
    if (sender.selectedSegmentIndex < 0) {
		return;
	}
    
    UIViewController *viewController;
    if (sender.selectedSegmentIndex == 0) { // client tab selected
        if (_clientViewController == nil) {
            _clientViewController = [[ClientViewController alloc] initWithNibName:@"ClientViewController" bundle:nil];
            _clientViewController.consultant = self.consultant;
            [_clientViewController.view setFrame:CGRectMake(0, 0, 1024, 694)];
        }
        viewController = _clientViewController;
    } else if (sender.selectedSegmentIndex == 1) {
        if (_layoutViewController == nil) {
            _layoutViewController = [[LayoutViewController alloc] initWithNibName:@"LayoutViewController" bundle:nil];
            [_layoutViewController.view setFrame:CGRectMake(0, 0, 1024, 694)];
        }
        viewController = _layoutViewController;
    } else if (sender.selectedSegmentIndex == 2) {
        if (_stockViewController == nil) {
            _stockViewController = [[StockViewController alloc] initWithNibName:@"StockViewController" bundle:nil];
            [_stockViewController.view setFrame:CGRectMake(0, 0, 1024, 694)];
        }
        viewController = _stockViewController;
    }
    
    if (viewController.view == _selectedView) {
        return;
    }
    
    if (_selectedView != nil) {
        [_selectedView removeFromSuperview];
        _selectedView = nil;
    }
    
    [self.view addSubview:viewController.view];
    _selectedView = viewController.view;
}

- (void)calculateLoan:(NSNotification *)notification
{
    House *house = [[notification userInfo] valueForKey:@"house"];
    
    LoanCalculatorController *calculatorController = [[LoanCalculatorController alloc] initWithNibName:@"LoanCalculatorController"
                                                                                                bundle:nil];
    calculatorController.modalPresentationStyle = UIModalPresentationPageSheet;
    [self presentModalViewController:calculatorController animated:YES];
    
    calculatorController.position = house.position;
    calculatorController.house = house;
    
    if (_clientViewController.detailController != nil) {
        calculatorController.client = _clientViewController.detailController.client;
    } else {
        calculatorController.client = nil;        
    }

    [calculatorController release];
}


@end
