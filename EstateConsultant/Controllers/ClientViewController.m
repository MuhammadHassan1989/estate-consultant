//
//  ClientViewController.m
//  EstateConsultant
//
//  Created by farthinker on 4/6/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import "ClientViewController.h"
#import "ClientListViewController.h"
#import "LayoutListViewController.h"
#import "LayoutViewController.h"
#import "ClientHistoryView.h"
#import "LayoutItemView.h"
#import "EstateConsultantAppDelegate.h"


@implementation ClientViewController

@synthesize client = _client;
@synthesize nameField = _nameField;
@synthesize sexSelect = _sexSelect;
@synthesize phoneField = _phoneField;
@synthesize estateTypeSelect = _estateTypeSelect;
@synthesize scrollView = _scrollView;
@synthesize emptyInfo = _emptyInfo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _scrollTopInset = 360;
    }
    return self;
}

- (void)dealloc
{
    [_client release];
    [_nameField release];
    [_sexSelect release];
    [_phoneField release];
    [_estateTypeSelect release];
    [_scrollView release];
    [_emptyInfo release];
    [_layoutListPopover release];
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
    
    [self.nameField setText:self.client.name];
    [self.nameField setDelegate:self];
    [self.phoneField setText:self.client.phone];
    [self.phoneField setDelegate:self];
    [self.sexSelect setSelectedSegmentIndex:[self.client.sex intValue]];
    [self.estateTypeSelect setSelectedSegmentIndex:[self.client.estateType intValue]];
    
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO];
    NSArray *histories = [self.client.history sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    if (histories.count > 0) {
        self.emptyInfo.hidden = YES;
    } else {
        self.emptyInfo.hidden = NO;
    }
    
    CGRect appFrame = [[UIScreen mainScreen] applicationFrame];
    NSInteger originY = _scrollTopInset + 30;
    for (History *history in histories) {
        UIViewController *targetController = [[UIViewController alloc] initWithNibName:@"ClientHistoryView" bundle:nil];
        [targetController.view setFrame:CGRectMake(40, originY, appFrame.size.width - 80, 410)];
        [(ClientHistoryView *)targetController.view setHistory:history];
        originY += targetController.view.frame.size.height + 30;
        
        [self.scrollView addSubview:targetController.view];
        [targetController release];
    }
    
    [self.scrollView setContentSize:CGSizeMake(appFrame.size.width, originY)];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(layoutSelected:) 
                                                 name:@"LayoutSelected" 
                                               object:nil];
}

- (void)viewDidUnload
{
    [self setClient:nil];
    [self setNameField:nil];
    [self setSexSelect:nil];
    [self setPhoneField:nil];
    [self setEstateTypeSelect:nil];
    [self setScrollView:nil];
    [self setEmptyInfo:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (IBAction)returnClientList:(id)sender forEvent:(UIEvent *)event {
    EstateConsultantAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    Consultant *consultant = [[DataProvider sharedProvider] getConsultantByID:appDelegate.consultantID];
    
    ClientListViewController *clientListController = [[ClientListViewController alloc] initWithNibName:@"ClientListViewController" bundle:nil];
    [clientListController setConsultant:consultant];
    [clientListController.view setFrame:[UIScreen mainScreen].applicationFrame];

    appDelegate.viewController = clientListController;
    [clientListController release];
}

- (IBAction)showLayoutList:(id)sender forEvent:(UIEvent *)event {
    if (self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft
        || self.interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        [self loadLayoutView:nil];
    } else {
        if (_layoutListPopover == nil) {
            NSArray *layouts = [[DataProvider sharedProvider] getLayouts];
            NSInteger popHeight = layouts.count * 82;
            if (popHeight > 520) {
                popHeight = 520;
            }
            
            LayoutListViewController *contentController = [[LayoutListViewController alloc] initWithNibName:@"LayoutListViewController" bundle:nil];
            contentController.contentSizeForViewInPopover = CGSizeMake(320, popHeight);
            contentController.layouts = layouts;
            
            _layoutListPopover = [[UIPopoverController alloc] initWithContentViewController:contentController];
            [contentController release];
        }
        
        [_layoutListPopover presentPopoverFromRect:((UIButton *)sender).frame
                                            inView:self.view
                          permittedArrowDirections:UIPopoverArrowDirectionAny
                                          animated:NO];
    }
}

- (IBAction)changeSex:(id)sender forEvent:(UIEvent *)event {
    self.client.sex = [NSNumber numberWithInt:self.sexSelect.selectedSegmentIndex];
}

- (IBAction)changeEstateType:(id)sender forEvent:(UIEvent *)event {
    self.client.estateType = [NSNumber numberWithInt:self.estateTypeSelect.selectedSegmentIndex];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.text == nil || textField.text.length == 0) {
        return YES;
    }
    
    if (textField == self.nameField) {
        self.client.name = textField.text;
    } else if ( textField == self.phoneField) {
        self.client.phone = textField.text;
    }
    
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.phoneField) {
        NSPredicate *numberPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES '^[0-9]*$'"];
        if (![numberPredicate evaluateWithObject:string]) {
            return NO;
        }        
    }
    return YES;
}

- (void)layoutSelected:(NSNotification *)notification
{
    [_layoutListPopover dismissPopoverAnimated:NO];
    [self loadLayoutView:((LayoutItemView *)notification.object).layout];
}

- (void)loadLayoutView:(Layout *)layout
{
    NSArray *layouts = [[DataProvider sharedProvider] getLayouts];
    if (layout == nil && layouts.count > 0) {
        layout = [layouts objectAtIndex:0];
    }
    
    LayoutListViewController *listController = [[LayoutListViewController alloc] initWithNibName:@"LayoutListViewController" bundle:nil];
    [listController.view setFrame:CGRectMake(0, 0, 320, layouts.count * 82)];
    listController.layouts = layouts;
    listController.selectedLayout = layout;
    
    LayoutViewController *layoutController = [[LayoutViewController alloc] initWithNibName:@"LayoutViewController" bundle:nil];
    [layoutController.view setFrame:CGRectMake(0, 0, 703, 768)];
    [layoutController setLayout:layout];
    [layoutController setClient:self.client];
    
    UISplitViewController *splitController = [[UISplitViewController alloc] init];
    splitController.viewControllers = [NSArray arrayWithObjects:listController, layoutController, nil];
    [listController release];
    [layoutController release];
    
    EstateConsultantAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.viewController = splitController;
    [splitController release];
}


@end
