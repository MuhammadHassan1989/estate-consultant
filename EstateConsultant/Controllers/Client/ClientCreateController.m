//
//  ClientCreateViewController.m
//  EstateConsultant
//
//  Created by farthinker on 4/8/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import "ClientCreateController.h"
#import "DataProvider.h"
#import "NumberInputView.h"
#import "SingleSelectControl.h"
#import "EstateConsultantViewController.h"


@implementation ClientCreateController

@synthesize rootController = _rootController;
@synthesize consultant = _consultant;
@synthesize nameLabel = _nameLabel;
@synthesize phoneLabel = _phoneLabel;
@synthesize sexSelect = _sexSelect;
@synthesize addClientButton = _addClientButton;

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
    [_consultant release];
    [_nameLabel release];
    [_phoneLabel release];
    [_sexSelect release];
    [_addClientButton release];
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
    
    [self.phoneLabel setDelegate:self];
    [self.nameLabel setDelegate:self];    
        
    self.sexSelect.defaultBackground = nil;
    self.sexSelect.selectedBackground = [UIImage imageNamed:@"addclient-genderselected.png"];
    self.sexSelect.titleFont = [UIFont fontWithName:@"STHeitiSC-Medium" size:26];
    self.sexSelect.titleColor = [UIColor colorWithHue:0.088 saturation:0.31 brightness:0.46 alpha:1.0];
    self.sexSelect.items = [NSArray arrayWithObjects:@"女士", @"先生", nil];
    self.sexSelect.selectedIndex = 0;
    
    UIViewController *numberInputController = [[UIViewController alloc] initWithNibName:@"NumberInputView" bundle:nil];
    NumberInputView *numberInputView = (NumberInputView *)numberInputController.view;
    numberInputView.textfield = self.phoneLabel;
    self.phoneLabel.inputView = numberInputView;
    [numberInputController release];
    
    [self.nameLabel becomeFirstResponder];
}

- (void)viewDidUnload
{
    [self setConsultant:nil];
    [self setRootController:nil];
    [self setNameLabel:nil];
    [self setPhoneLabel:nil];
    [self setSexSelect:nil];
    [self setAddClientButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.nameLabel becomeFirstResponder];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.nameLabel) {
        [self.phoneLabel becomeFirstResponder];
    } else if (textField == self.phoneLabel) {
        if (self.nameLabel.text.length > 0 && self.phoneLabel.text.length > 0) {
            [self addClient:self];
        }
    }
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.phoneLabel) {
        NSPredicate *numberPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES '^[0-9]*$'"];
        if (![numberPredicate evaluateWithObject:string]) {
            return NO;
        } else {
            return YES;
        }
    } else {
        return YES;
    }
}

- (IBAction)addClient:(id)sender {    
    NSString *name = self.nameLabel.text;
    NSString *phone = self.phoneLabel.text;
    NSInteger sex = self.sexSelect.selectedIndex;
    
    if ([name length] < 1 && [phone length] < 1) {
        return;
    }
    
    Client *newClient = [[DataProvider sharedProvider] clientWithName:name 
                                                             andPhone:phone 
                                                               andSex:sex 
                                                         ofConsultant:self.consultant];
    [[DataProvider sharedProvider] historyOfClient:newClient withAction:0 andHouse:nil];

    NSDictionary *userInfo = [[NSDictionary alloc] initWithObjectsAndKeys:newClient, @"client", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CreateClient" 
                                                        object:self
                                                      userInfo:userInfo];
    [userInfo release];
    
    [self.rootController cancelCreateClient];
}

@end
