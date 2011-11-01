//
//  LoginViewController.m
//  EstateConsultant
//
//  Created by farthinker on 6/30/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "LoginViewController.h"
#import "EstateConsultantViewController.h"


@implementation LoginViewController
@synthesize logoView = _logoView;
@synthesize loginBox = _loginBox;
@synthesize emailField = _emailField;
@synthesize passwordField = _passwordField;
@synthesize tryButton = _tryButton;

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
    [_logoView release];
    [_loginBox release];
    [_emailField release];
    [_passwordField release];
    [_tryButton release];
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
    
    CGRect logoFrame = self.logoView.frame;
    CGRect loginFrame = self.loginBox.frame;
    CGRect tryFrame = self.tryButton.frame;
    logoFrame.origin.x -= 220;
    loginFrame.origin.x -= 220;
    tryFrame.origin.x -= 220;
    
    [UIView animateWithDuration:1
                     animations:^{
                         self.logoView.frame = logoFrame;
                         self.loginBox.frame = loginFrame;
                         self.tryButton.frame = tryFrame;
                         
                         self.loginBox.alpha = 1.0;
                         self.tryButton.alpha = 1.0;
                     }];
}

- (void)viewDidUnload
{
    [self setLogoView:nil];
    [self setLoginBox:nil];
    [self setEmailField:nil];
    [self setPasswordField:nil];
    [self setTryButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (IBAction)tryDemo:(id)sender {
    EstateConsultantViewController *viewController = [[EstateConsultantViewController alloc] initWithNibName:@"EstateConsultantViewController" 
                                                                                                      bundle:nil];
    viewController.modalPresentationStyle = UIModalPresentationFullScreen;
    viewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentModalViewController:viewController animated:YES];
    [viewController release];
}
@end
