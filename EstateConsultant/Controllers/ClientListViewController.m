//
//  ClientListViewController.m
//  EstateConsultant
//
//  Created by farthinker on 4/1/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import "ClientListViewController.h"
#import "LoginViewController.h"
#import "ClientViewController.h"
#import "AddClientViewController.h"
#import "ClientItemView.h"
#import "EstateConsultantAppDelegate.h"
#import "DataProvider.h"


@implementation ClientListViewController

@synthesize consultant = _consultant;
@synthesize nameLabel = _nameLabel;
@synthesize emptyInfo = _emptyInfo;
@synthesize clientList = _clientList;
@synthesize searchField = _searchField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _scrollTopInset = 220;

    }
    return self;
}

- (void)dealloc
{
    [_consultant release];
    [_nameLabel release];
    [_emptyInfo release];
    [_clientList release];
    [_searchField release];
    [_clientItems release];
    [_statPopover release];
    [_addClientPopover release];
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
    [self.nameLabel setText:self.consultant.name];
    [self.searchField setDelegate:self];
    
    NSString *searchImgPath = [[NSBundle mainBundle] pathForResource:@"icon-search.png" ofType:nil];
    UIImage *searchImg = [[UIImage alloc] initWithContentsOfFile:searchImgPath];
    UIImageView *searchImgView = [[UIImageView alloc] initWithImage:searchImg];
    [searchImgView setFrame:CGRectMake(0, 0, 40, 50)];
    [searchImgView setContentMode:UIViewContentModeRight];
    [self.searchField setLeftView:searchImgView];
    [self.searchField setLeftViewMode:UITextFieldViewModeAlways];
    [searchImg release];
    [searchImgView release];
    
    if ([self.consultant.clients count] > 0) {
        [self.emptyInfo setHidden:YES];
    } else {
        [self.emptyInfo setHidden:NO];
    }
    
    CGRect appFrame = [UIScreen mainScreen].applicationFrame;
    [self.clientList setFrame:appFrame];
    
    NSInteger index = 0;
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"history.@max.date" ascending:NO];
    NSArray *clients = [self.consultant.clients sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    [sortDescriptor release];

    _clientItems = [[NSMutableArray alloc] initWithCapacity:[clients count]];
    for (Client *client in clients) {
        UIViewController *itemController = [[UIViewController alloc] initWithNibName:@"ClientItemView" bundle:nil];
        [(ClientItemView *)itemController.view setClient:client];
        [itemController.view setFrame:CGRectMake(30, _scrollTopInset + index * 80, appFrame.size.width - 60, 60)];
        
        [self.clientList addSubview:itemController.view];
        [_clientItems addObject:itemController.view];
        [itemController release];
        index++;
    }
    
    [self.clientList setContentSize:CGSizeMake(appFrame.size.width, index * 80 + _scrollTopInset)];
}

- (void)viewDidUnload
{
    [self setConsultant:nil];
    [self setNameLabel:nil];
    [self setEmptyInfo:nil];
    [self setClientList:nil];
    [self setSearchField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}


- (IBAction)logout:(id)sender forEvent:(UIEvent *)event {
    LoginViewController *loginController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    [loginController.view setFrame:[UIScreen mainScreen].applicationFrame];
    
    EstateConsultantAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.viewController = loginController;
    [loginController release];
}

- (IBAction)showStat:(id)sender forEvent:(UIEvent *)event {
    if (_statPopover == nil) {
        UIViewController *contentController = [[UIViewController alloc] initWithNibName:@"ConsultantStatView" bundle:nil];
        contentController.contentSizeForViewInPopover = CGSizeMake(300, 224);
        _statPopover = [[UIPopoverController alloc] initWithContentViewController:contentController];
        [contentController release];
    }
    
    [_statPopover presentPopoverFromRect:((UIButton *)sender).frame
                                       inView:self.view
                     permittedArrowDirections:UIPopoverArrowDirectionAny
                                     animated:NO];
}

- (IBAction)showAddClientForm:(id)sender forEvent:(UIEvent *)event {
    if (_addClientPopover == nil) {
        AddClientViewController *contentController = [[AddClientViewController alloc] initWithNibName:@"AddClientViewController" bundle:nil];
        contentController.contentSizeForViewInPopover = CGSizeMake(340, 243);
        _addClientPopover = [[UIPopoverController alloc] initWithContentViewController:contentController];
        contentController.consultant = self.consultant;
        contentController.parentPopover = _addClientPopover;
        [contentController release];
    }
    
    [_addClientPopover presentPopoverFromRect:((UIButton *)sender).frame
                                  inView:self.view
                permittedArrowDirections:UIPopoverArrowDirectionAny
                                animated:NO];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    [self filterClients:@""];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSPredicate *numberPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES '^[0-9]*$'"];
    if (![numberPredicate evaluateWithObject:string]) {
        return NO;
    }
    
    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];    
    [self filterClients:text];
    return YES;
}

- (void)filterClients:(NSString *)text {
    NSMutableArray *showItems = [[NSMutableArray alloc] init];
    NSMutableArray *hideItems = [[NSMutableArray alloc] init];
    for (ClientItemView *itemView in _clientItems) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.client.phone CONTAINS %@", text];
        if ([predicate evaluateWithObject:itemView] || [text length] == 0) {
            [showItems addObject:itemView];
        } else {
            [hideItems addObject:itemView];
        }
    }
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         NSInteger index = 0;
                         for (ClientItemView *view in showItems) {
                             view.hidden = NO;
                             view.alpha = 1.0;
                             view.frame = CGRectMake(20, _scrollTopInset + index * 80, view.frame.size.width, view.frame.size.height);
                             index++;
                         }
                         
                         for (ClientItemView *view in hideItems) {
                             view.alpha = 0.0;
                         }
                     }
                     completion:^(BOOL finished){                         
                         for (ClientItemView *view in hideItems) {
                             view.hidden = YES;
                         }
                     }];
    
//    CGRect appFrame = [UIScreen mainScreen].applicationFrame;
//    [self.clientList setContentSize:CGSizeMake(appFrame.size.width, [showItems count] * 80 + _scrollTopInset)];
    
    [showItems release];
    [hideItems release];
}

@end
