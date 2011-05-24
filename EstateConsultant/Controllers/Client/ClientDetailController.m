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
    [self removeObserverForClient:_client];
    [_client release];
    
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
    
    NSArray *profiles = [[DataProvider sharedProvider] getProfiles];
    NSInteger index = 0;
    for (Profile *profile in profiles) {
        UIViewController *profileFieldController = [[UIViewController alloc] initWithNibName:@"ProfileFieldView" bundle:nil];
        ProfileFieldView *profileField = (ProfileFieldView *)profileFieldController.view;
        profileField.frame = CGRectMake(40, index * 60 + 100, 620, 50);
        profileField.profile = profile;
        
        [self.infoList addSubview:profileField];
        [_profileFields addObject:profileField];
        [profileFieldController release];
        
        index++;
    }
    
    CGRect infoFrame = CGRectMake(0, 0, 702, 100 + index * 60);
    [self.infoList setFrame:infoFrame];
    [self.scrollView setContentSize:CGSizeMake(702, infoFrame.origin.y + infoFrame.size.height + 20)];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self 
                                                                                 action:@selector(tapStar:)];
    [self.starImage addGestureRecognizer:tapGesture];
    [tapGesture release];
}

- (void)viewDidUnload
{
    [self setClient:nil];
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
    
    self.starImage.highlighted = client.starred.boolValue;    
    self.nameLabel.text = client.name;
    self.phoneLabel.text = client.phone;

    if (client.sex.intValue == 1) {
        self.sexLabel.text = @"先生";
    } else if (client.sex.intValue == 0) {
        self.sexLabel.text = @"女士";
    }
    CGRect sexFrame = self.sexLabel.frame;
    sexFrame.origin.x = 83 + [client.name sizeWithFont:self.sexLabel.font].width + 10;
    self.sexLabel.frame = sexFrame;
    
    for (ProfileFieldView *profileField in _profileFields) {
        profileField.client = client;
    }
    
    [_historyViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_historyViews removeAllObjects];
    
    NSSortDescriptor *sortDate = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];
    NSSortDescriptor *sortAction = [[NSSortDescriptor alloc] initWithKey:@"action" ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDate, sortAction, nil];
    NSArray *historyItems = [client.history sortedArrayUsingDescriptors:sortDescriptors];
    [sortAction release];
    [sortDate release];
    [sortDescriptors release];
    
    self.historyList.hidden = (historyItems.count < 1);
    
    NSInteger index = 0;
    for (History *history in historyItems) {
        UIViewController *historyController = [[UIViewController alloc] initWithNibName:@"ClientHistoryView" bundle:nil];
        ClientHistoryView *historyView = (ClientHistoryView *)historyController.view;
        historyView.frame = CGRectMake(40, index * 60 + 40, 620, 50);
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
    
    [self addObserverForClient:client];
    [self removeObserverForClient:_client];
    
    [_client release];
    _client = [client retain];
}

- (IBAction)editClient:(id)sender {
    NSDictionary *userInfo = [[NSDictionary alloc] initWithObjectsAndKeys:self.client, @"client", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"StartEditClient" 
                                                        object:self
                                                      userInfo:userInfo];
    [userInfo release];
}

- (void)tapStar:(UIGestureRecognizer *)gesture
{
    self.starImage.highlighted = !self.starImage.highlighted;
    self.client.starred = [NSNumber numberWithBool:self.starImage.highlighted];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"starred"]) {
        self.starImage.highlighted = [[object valueForKeyPath:keyPath] boolValue];
    } else if([keyPath isEqualToString:@"name"]) {
        self.nameLabel.text = [object valueForKeyPath:keyPath];
    } else if([keyPath isEqualToString:@"phone"]) {
        self.phoneLabel.text = [object valueForKeyPath:keyPath];
    } else if([keyPath isEqualToString:@"sex"]) {
        NSInteger sex = [[object valueForKeyPath:keyPath] intValue];
        if (sex == 1) {
            self.sexLabel.text = @"先生";
        } else if (sex == 0) {
            self.sexLabel.text = @"女士";
        }
        CGRect sexFrame = self.sexLabel.frame;
        sexFrame.origin.x = 83 + [self.nameLabel.text sizeWithFont:self.sexLabel.font].width + 10;
        self.sexLabel.frame = sexFrame;
    }
}

- (void)addObserverForClient:(Client *)client
{
    [client addObserver:self forKeyPath:@"starred" options:NSKeyValueObservingOptionNew context:nil];
    [client addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    [client addObserver:self forKeyPath:@"phone" options:NSKeyValueObservingOptionNew context:nil];
    [client addObserver:self forKeyPath:@"sex" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)removeObserverForClient:(Client *)client
{
    [client removeObserver:self forKeyPath:@"starred"];
    [client removeObserver:self forKeyPath:@"name"];
    [client removeObserver:self forKeyPath:@"phone"];
    [client removeObserver:self forKeyPath:@"sex"];
}


@end
