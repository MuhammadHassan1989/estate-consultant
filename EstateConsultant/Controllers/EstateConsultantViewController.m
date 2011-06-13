//
//  EstateConsultantViewController.m
//  EstateConsultant
//
//  Created by farthinker on 5/28/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "EstateConsultantViewController.h"
#import "ClientListController.h"
#import "ClientDetailController.h"
#import "ClientCreateController.h"


@implementation EstateConsultantViewController

@synthesize consultant = _consultant;
@synthesize batch = _batch;
@synthesize clientButton = _clientButton;
@synthesize layoutButton = _layoutButton;
@synthesize stockButton = _stockButton;
@synthesize calculatorButton = _calculatorButton;
@synthesize consultantAvatar = _consultantAvatar;
@synthesize avatarShadow = _avatarShadow;
@synthesize batchButton = _batchButton;
@synthesize consultantNameLabel = _consultantNameLabel;

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
    [_clientButton release];
    [_layoutButton release];
    [_stockButton release];
    [_calculatorButton release];
    [_clientViewController release];
    [_layoutViewController release];
    [_stockViewController release];
    [_loanCalculatorController release];
    [_consultantAvatar release];
    [_avatarShadow release];
    [_batchButton release];
    [_consultantNameLabel release];
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
    self.consultantNameLabel.text = self.consultant.name;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"active.boolValue == YES"];
    self.batch = [[self.consultant.estate.batches filteredSetUsingPredicate:predicate] anyObject];
    
    [self selectMenu:self.clientButton];
    
    self.consultantAvatar.layer.masksToBounds = YES;
    self.consultantAvatar.layer.cornerRadius = 4.0f;
    
    self.avatarShadow.layer.cornerRadius = 4.0f;
    self.avatarShadow.layer.shadowOffset = CGSizeMake(0, 3.0f);
    self.avatarShadow.layer.shadowRadius = 6.0f;
    self.avatarShadow.layer.shadowOpacity = 0.55f;
    self.avatarShadow.layer.shadowColor = [[UIColor blackColor] CGColor];
    
    UIImage *lightButtonBackground = [[UIImage imageNamed:@"nav-light-button.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:0];
    UIImage *lightButtonHighlighted = [[UIImage imageNamed:@"nav-light-button-highlighted.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:0];
    [self.batchButton setBackgroundImage:lightButtonBackground forState:UIControlStateNormal];
    [self.batchButton setBackgroundImage:lightButtonHighlighted forState:UIControlStateHighlighted];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(calculateLoan:) 
                                                 name:@"CalculateLoan"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(clientCreated:) 
                                                 name:@"CreateClient" 
                                               object:nil];
}

- (void)viewDidUnload
{
    [self setConsultant:nil];
    [self setClientButton:nil];
    [self setLayoutButton:nil];
    [self setStockButton:nil];
    [self setCalculatorButton:nil];
    [self setConsultantAvatar:nil];
    [self setAvatarShadow:nil];
    [self setBatchButton:nil];
    [self setConsultantNameLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    [popoverController release];
}

- (void)clientCreated:(NSNotification *)notification
{
    [self selectMenu:self.clientButton];
}

- (IBAction)selectMenu:(UIButton *)sender {
    UIViewController *newController = nil;
    if (sender == self.clientButton) {
        if (_clientViewController == nil) {
            _clientViewController = [[ClientViewController alloc] init];
            _clientViewController.consultant = self.consultant;
            _clientViewController.view.frame = CGRectMake(70, 0,956, 748);
            _clientViewController.view.hidden = YES;
            [self.view addSubview:_clientViewController.view];
        }
        newController = _clientViewController;
    } else if (sender == self.layoutButton) {
        if (_layoutViewController == nil) {
            _layoutViewController = [[LayoutViewController alloc] init];
            _layoutViewController.batch = self.batch;
            _layoutViewController.view.frame = CGRectMake(70, 0,956, 748);
            _layoutViewController.view.hidden = YES;
            [self.view addSubview:_layoutViewController.view];
        }
        newController = _layoutViewController;
    } else if (sender == self.stockButton) {
        if (_stockViewController == nil) {
            _stockViewController = [[StockViewController alloc] init];
            _stockViewController.batch = self.batch;
            _stockViewController.view.frame = CGRectMake(70, 0,956, 748);
            _stockViewController.view.hidden = YES;
            [self.view addSubview:_stockViewController.view];
        }
        newController = _stockViewController;
    } else if (sender == self.calculatorButton) {
        if (_loanCalculatorController == nil) {
            _loanCalculatorController = [[LoanCalculatorController alloc] initWithNibName:@"LoanCalculatorController" bundle:nil];
            _loanCalculatorController.consultant = self.consultant;
            _loanCalculatorController.batch = self.batch;
            _loanCalculatorController.view.frame = CGRectMake(290, 0,668, 748);
            _loanCalculatorController.view.hidden = YES;
            _loanCalculatorController.client = nil;
            _loanCalculatorController.position = nil;
            _loanCalculatorController.house = nil;
            [self.view addSubview:_loanCalculatorController.view];
        }
        newController = _loanCalculatorController;
    }
    
    if (_currentController == newController) {
        return;
    } else {  
        if (_currentController != nil) {
            CATransition *transition = [CATransition animation];
            transition.type = kCATransitionPush;
            transition.duration = 0.5;
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            
            if (sender.tag > _currentButton.tag) {
                transition.subtype = kCATransitionFromTop;
            } else {
                transition.subtype = kCATransitionFromBottom;            
            }
            
            [newController.view.layer addAnimation:transition forKey:nil];
            [_currentController.view.layer addAnimation:transition forKey:nil];
        }
        
        newController.view.hidden = NO;
        _currentController.view.hidden = YES;
        _currentController = newController;
        
        sender.enabled = NO;
        _currentButton.enabled = YES;
//        [self.view bringSubviewToFront:sender];
//        [self.view bringSubviewToFront:_currentController.view];
        _currentButton = sender;
    }
}

- (IBAction)createClient:(UIButton *)sender {
    ClientCreateController *createController = [[ClientCreateController alloc] initWithNibName:@"ClientCreateController" bundle:nil];
    createController.contentSizeForViewInPopover = CGSizeMake(340, 243);
    
    UIPopoverController *popoverController = [[UIPopoverController alloc] initWithContentViewController:createController];
    popoverController.delegate = self;
    createController.parentPopover = popoverController;
    
    CGRect frame = sender.frame;
    frame.size.width = 48;
    [popoverController presentPopoverFromRect:frame
                                       inView:self.view
                     permittedArrowDirections:UIPopoverArrowDirectionLeft
                                     animated:YES];
    
    [createController release];
}

- (void)calculateLoan:(NSNotification *)notification
{
    if (_loanCalculatorController == nil) {
        _loanCalculatorController = [[LoanCalculatorController alloc] initWithNibName:@"LoanCalculatorController" bundle:nil];
        _loanCalculatorController.consultant = self.consultant;
        _loanCalculatorController.view.frame = CGRectMake(300, 0,540, 748);
        _loanCalculatorController.view.hidden = YES;
        [self.view addSubview:_loanCalculatorController.view];
    }
    
    House *house = [[notification userInfo] valueForKey:@"house"];
    if (house != nil) {
        _loanCalculatorController.house = house;
        _loanCalculatorController.position = house.position;
    } else {
        _loanCalculatorController.house = nil;
        _loanCalculatorController.position = nil;
    }
    
    if (_clientViewController != nil && _clientViewController.viewControllers.count > 1) {
        ClientDetailController *clientDetailController = [_clientViewController.viewControllers objectAtIndex:1];
        _loanCalculatorController.client = clientDetailController.client;
    } else {
        _loanCalculatorController.client = nil;
    }
    
    [self selectMenu:self.calculatorButton];
}

@end
