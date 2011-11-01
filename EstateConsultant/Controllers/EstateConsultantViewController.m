//
//  EstateConsultantViewController.m
//  EstateConsultant
//
//  Created by farthinker on 5/28/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "EstateConsultantViewController.h"
#import "StackScrollViewController.h"
#import "ClientViewController.h"
#import "LayoutViewController.h"
#import "StockViewController.h"
#import "LoanCalculatorController.h"
#import "ClientCreateController.h"
#import "ClientListController.h"
#import "ClientDetailController.h"
#import "BatchListViewController.h"


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
    [_batch release];
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
    [_maskView release];
    [_clientCreateController release];
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
    [self setBatch:nil];
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
        
        if (_clientViewController != nil && _clientViewController.viewControllers.count > 1) {
            ClientDetailController *clientDetailController = [_clientViewController.viewControllers objectAtIndex:1];
            _loanCalculatorController.client = clientDetailController.client;
        } else {
            _loanCalculatorController.client = nil;
        }

        newController = _loanCalculatorController;
    }
    
    if (_currentController == newController) {
        return;
    } else {  
        if (_currentController != nil) {
            CATransition *showTransition = [CATransition animation];
            showTransition.type = kCATransitionPush;
            showTransition.subtype = kCATransitionFromRight;
            showTransition.duration = 0.6;
            showTransition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];\
            
            CATransition *hideTransition = [CATransition animation];
            hideTransition.type = kCATransitionPush;
            hideTransition.subtype = kCATransitionFromLeft;
            hideTransition.duration = 0.6;
            hideTransition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                        
            [newController.view.layer addAnimation:showTransition forKey:nil];
            [_currentController.view.layer addAnimation:hideTransition forKey:nil];
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
    if (_maskView == nil) {
        _maskView = [[UIView alloc] initWithFrame:self.view.bounds];
        _maskView.backgroundColor = [UIColor clearColor];
        _maskView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelCreateClient)];
        [_maskView addGestureRecognizer:tapGesture];
        [tapGesture release];
        
        [self.view addSubview:_maskView];
    }
    
    if (_clientCreateController != nil) {
        [_clientCreateController.view removeFromSuperview];
        [_clientCreateController release];
        _clientCreateController = nil;
    }
    _clientCreateController = [[ClientCreateController alloc] initWithNibName:@"ClientCreateController" bundle:nil];
    _clientCreateController.rootController = self;
    _clientCreateController.view.frame = CGRectMake(0, 0, 512, 326);
    _clientCreateController.view.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
    _clientCreateController.view.alpha = 0;
    [self.view addSubview:_clientCreateController.view];
    
    [UIView animateWithDuration:0.4
                     animations:^{
                         CGRect frame = _clientCreateController.view.frame;
                         frame.origin.y = 40;
                         _clientCreateController.view.frame = frame;
                         _clientCreateController.view.alpha = 1.0;
                     }];
}

- (void)cancelCreateClient
{
    if (_clientCreateController == nil) {
        return;
    }
    
    [_clientCreateController.view resignFirstResponder];
    [UIView animateWithDuration:0.4
                     animations:^{
                         _clientCreateController.view.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
                         _clientCreateController.view.alpha = 0;
                     }
                     completion:^(BOOL finished){
                         [_clientCreateController.view removeFromSuperview];
                         [_clientCreateController release];
                         _clientCreateController = nil;
                         [_maskView removeFromSuperview];
                         [_maskView release];
                         _maskView = nil;
                     }];
}

- (IBAction)selectBatch:(UIButton *)sender {
    BatchListViewController *pickerController = [[BatchListViewController alloc] initWithNibName:@"BatchListViewController" bundle:nil];
    pickerController.estate = self.consultant.estate;
    pickerController.contentSizeForViewInPopover = CGSizeMake(320, self.consultant.estate.batches.count * 45);
    
    UIPopoverController *popoverController = [[UIPopoverController alloc] initWithContentViewController:pickerController];
    popoverController.delegate = self;
    pickerController.parentPopover = popoverController;
    pickerController.rootController = self;
    
    [popoverController presentPopoverFromRect:sender.frame
                                       inView:self.view
                     permittedArrowDirections:UIPopoverArrowDirectionDown
                                     animated:YES];
    
    [pickerController selectBatch:self.batch];
    [pickerController release];
}

- (IBAction)logout:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
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
    
    [self selectMenu:self.calculatorButton];
}

@end
