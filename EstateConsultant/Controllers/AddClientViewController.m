//
//  AddClientViewController.m
//  EstateConsultant
//
//  Created by farthinker on 4/8/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import "AddClientViewController.h"
#import "ClientViewController.h"
#import "EstateConsultantAppDelegate.h"
#import "DataProvider.h"


@implementation AddClientViewController

@synthesize parentPopover = _parentPopover;
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
    
    [self.addClientButton setEnabled:NO];
}

- (void)viewDidUnload
{
    [self setConsultant:nil];
    [self setParentPopover:nil];
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
        } else {
            [textField resignFirstResponder];            
        }
    }
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (self.nameLabel.text.length > 0 && self.phoneLabel.text.length > 0) {
        self.addClientButton.enabled = YES;
    } else {
        self.addClientButton.enabled = NO;
    }
    
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
    [self.parentPopover dismissPopoverAnimated:NO];
    
    NSString *name = self.nameLabel.text;
    NSString *phone = self.phoneLabel.text;
    NSInteger sex = self.sexSelect.selectedSegmentIndex;
    Client *newClient = [[DataProvider sharedProvider] clientWithName:name andPhone:phone andSex:sex ofConsultant:self.consultant];
    
    ClientViewController *clientController = [[ClientViewController alloc] initWithNibName:@"ClientViewController" bundle:nil];
    [clientController setClient:newClient];
    [clientController.view setFrame:[UIScreen mainScreen].applicationFrame];
    
    EstateConsultantAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.viewController = clientController;
    [clientController release];
}

@end
