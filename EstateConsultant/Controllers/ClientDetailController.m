//
//  ClientDetailController.m
//  EstateConsultant
//
//  Created by farthinker on 5/6/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import "ClientDetailController.h"
#import "ProfileFieldView.h"
#import "ClientHistoryView.h"


@implementation ClientDetailController

@synthesize client = _client;
@synthesize navItemView = _navItemView;
@synthesize navItem = _navItem;
@synthesize scrollView = _scrollView;
@synthesize infoList = _infoList;
@synthesize historyList = _historyList;
@synthesize starImage = _starImage;
@synthesize nameLabel = _nameLabel;
@synthesize sexLabel = _sexLabel;
@synthesize phoneLabel = _phoneLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _profileFields = [[NSMutableArray alloc] init];
        _historyViews = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [_client release];
    [_navItemView release];
    [_navItem release];
    [_scrollView release];
    [_infoList release];
    [_historyList release];
    [_starImage release];
    [_nameLabel release];
    [_sexLabel release];
    [_profileFields release];
    [_phoneLabel release];
    [_historyViews release];
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
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.navItemView];
    self.navItem.rightBarButtonItem = barButtonItem;
    [barButtonItem release];
    
    NSArray *profiles = [[DataProvider sharedProvider] getAllProfiles];
    NSInteger index = 0;
    for (Profile *profile in profiles) {
        UIViewController *profileFieldController = [[UIViewController alloc] initWithNibName:@"ProfileFieldView" bundle:nil];
        ProfileFieldView *profileField = (ProfileFieldView *)profileFieldController.view;
        profileField.frame = CGRectMake(42, index * 60 + 40, 620, 50);
        profileField.profile = profile;
        
        [self.infoList addSubview:profileField];
        [_profileFields addObject:profileField];
        [profileFieldController release];
        
        index++;
    }
    
    CGRect infoFrame = CGRectMake(0, 0, 702, 40 + index * 60);
    [self.infoList setFrame:infoFrame];
    [self.scrollView setContentSize:CGSizeMake(702, infoFrame.origin.y + infoFrame.size.height + 20)];
}

- (void)viewDidUnload
{
    [self setClient:nil];
    [self setNavItemView:nil];
    [self setNavItem:nil];
    [self setScrollView:nil];
    [self setInfoList:nil];
    [self setHistoryList:nil];
    [self setStarImage:nil];
    [self setNameLabel:nil];
    [self setSexLabel:nil];
    [self setPhoneLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (void)setClient:(Client *)client
{
    if (client == _client) {
        return;
    }
    
    if (client.starred.intValue == 1) {
        self.starImage.highlighted = YES;
    } else {
        self.starImage.highlighted = NO;
    }
    
    self.nameLabel.text = client.name;
    
    if (client.sex.intValue == 1) {
        self.sexLabel.text = @"先生";
    } else if (client.sex.intValue == 0) {
        self.sexLabel.text = @"女士";
    }
    CGRect sexFrame = self.sexLabel.frame;
    sexFrame.origin.x = 83 + [client.name sizeWithFont:self.sexLabel.font].width + 10;
    self.sexLabel.frame = sexFrame;
    
    self.phoneLabel.text = client.phone;
    CGRect phoneFrame = self.phoneLabel.frame;
    phoneFrame.origin.x = sexFrame.origin.x + [self.sexLabel.text sizeWithFont:self.phoneLabel.font].width + 20;
    self.phoneLabel.frame = phoneFrame;
    
    for (ProfileFieldView *profileField in _profileFields) {
        profileField.client = client;
    }
    
    [_historyViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_historyViews removeAllObjects];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];
    NSArray *historyItems = [client.history sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    [sortDescriptor release];
    
    NSInteger index = 0;
    for (History *history in historyItems) {
        UIViewController *historyController = [[UIViewController alloc] initWithNibName:@"ClientHistoryView" bundle:nil];
        ClientHistoryView *historyView = (ClientHistoryView *)historyController.view;
        historyView.frame = CGRectMake(42, index * 60 + 40, 620, 50);
        historyView.history = history;
        
        [self.historyList addSubview:historyView];
        [_historyViews addObject:historyView];
        [historyController release];
        
        index++;
    }
    
    NSInteger originY = self.infoList.frame.origin.y + self.infoList.frame.size.height + 20;
    CGRect historyFrame = CGRectMake(0, originY, 702, 40 + index * 60);
    [self.historyList setFrame:historyFrame];
    [self.scrollView setContentSize:CGSizeMake(702, historyFrame.origin.y + historyFrame.size.height + 20)];
    
    [_client release];
    _client = [client retain];
}

- (IBAction)editClient:(id)sender {
    
}

@end
