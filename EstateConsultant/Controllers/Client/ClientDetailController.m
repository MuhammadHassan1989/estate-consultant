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
@synthesize profiles = _profiles;
@synthesize scrollView = _scrollView;
@synthesize infoList = _infoList;
@synthesize historyList = _historyList;
@synthesize starImage = _starImage;
@synthesize nameLabel = _nameLabel;
@synthesize sexLabel = _sexLabel;
@synthesize phoneLabel = _phoneLabel;
@synthesize consultantLabel = _consultantLabel;
@synthesize delButton = _delButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _historyViews = [[NSMutableArray alloc] init];
        _profileFields = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    [self removeObserverForClient:_client];
    [_client release];
    [_profiles release];
    [_infoList release];
    [_scrollView release];
    [_historyList release];
    [_starImage release];
    [_nameLabel release];
    [_sexLabel release];
    [_profileFields release];
    [_phoneLabel release];
    [_historyViews release];
    [_clientEditController release];
    [_consultantLabel release];
    [_delButton release];
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

    NSInteger index = 0;
//    for (Profile *profile in self.profiles) {
//        UIViewController *profileFieldController = [[UIViewController alloc] initWithNibName:@"ProfileFieldView" bundle:nil];
//        ProfileFieldView *profileField = (ProfileFieldView *)profileFieldController.view;
//        profileField.frame = CGRectMake(40, index * 60 + 175, 628, 50);
//        profileField.profile = profile;
//        
//        [self.infoList addSubview:profileField];
//        [_profileFields addObject:profileField];
//        [profileFieldController release];
//        
//        index++;
//    }
    
    CGRect infoFrame = self.infoList.frame;
    infoFrame.size.height = index * 60 + 175;
    [self.infoList setFrame:infoFrame];
    [self.scrollView setContentSize:CGSizeMake(702, infoFrame.origin.y + infoFrame.size.height + 20)];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self 
                                                                                 action:@selector(tapStar:)];
    [self.starImage addGestureRecognizer:tapGesture];
    [tapGesture release];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(endEditClient:) 
                                                 name:@"EndEditClient"
                                               object:nil];
}

- (void)viewDidUnload
{    
    [self setClient:nil];
    [self setProfiles:nil];
    [self setScrollView:nil];
    [self setInfoList:nil];
    [self setHistoryList:nil];
    [self setStarImage:nil];
    [self setNameLabel:nil];
    [self setSexLabel:nil];
    [self setPhoneLabel:nil];
    [self setConsultantLabel:nil];
    [self setDelButton:nil];
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
    self.consultantLabel.text = client.consultant.name;

    if (client.sex.intValue == 1) {
        self.sexLabel.text = @"先生";
    } else if (client.sex.intValue == 0) {
        self.sexLabel.text = @"女士";
    }
    CGRect sexFrame = self.sexLabel.frame;
    sexFrame.origin.x = CGRectGetMinX(self.nameLabel.frame) + [client.name sizeWithFont:self.nameLabel.font].width + 10;
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
    
    CGFloat originY = 55;
    for (History *history in historyItems) {
        UIViewController *historyController = [[UIViewController alloc] initWithNibName:@"ClientHistoryView" bundle:nil];
        ClientHistoryView *historyView = (ClientHistoryView *)historyController.view;
        historyView.frame = CGRectMake(40, originY, 605, 50);
        historyView.history = history;
        
        [self.historyList addSubview:historyView];
        [_historyViews addObject:historyView];
        [historyController release];
        
        originY += CGRectGetHeight(historyView.frame) + 20;
    }
    
    CGRect historyFrame = self.historyList.frame;
    historyFrame.origin.y = CGRectGetMaxY(self.infoList.frame) + 15;
    historyFrame.size.height = originY;
    [self.historyList setFrame:historyFrame];
    [self.scrollView setContentSize:CGSizeMake(702, CGRectGetMaxY(historyFrame) + 20)];
    
    [self addObserverForClient:client];
    [self removeObserverForClient:_client];
    
    [_client release];
    _client = [client retain];
}

- (IBAction)editClient:(id)sender {
    if (_clientEditController == nil) {
        _clientEditController = [[ClientEditController alloc] initWithNibName:@"ClientEditController" bundle:nil];
        _clientEditController.profiles = self.profiles;
        _clientEditController.view.frame = self.view.bounds;
        _clientEditController.view.alpha = 0;
        [self.view addSubview:_clientEditController.view];
    }
    
    _clientEditController.client = self.client;
    [UIView animateWithDuration:0.3
                     animations:^{
                         _clientEditController.view.alpha = 1;
                     }];
}

- (void)endEditClient:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3
                     animations:^{
                         _clientEditController.view.alpha = 0;
                     }
                     completion:^(BOOL finished){
                         [_clientEditController.view removeFromSuperview];
                         [_clientEditController release];
                         _clientEditController = nil;
                     }];
}

- (IBAction)deleteClient:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" 
                                                        message:@"确定要删除这个客户的信息吗？" 
                                                       delegate:self 
                                              cancelButtonTitle:@"取消" 
                                              otherButtonTitles:@"删除", nil];
    [alertView show];
    [alertView release];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSDictionary *userInfo = [[NSDictionary alloc] initWithObjectsAndKeys:self.client, @"client", nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"DeleteClient" 
                                                            object:self
                                                          userInfo:userInfo];
        [userInfo release];
    }
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
        
        CGRect sexFrame = self.sexLabel.frame;
        sexFrame.origin.x = CGRectGetMinX(self.nameLabel.frame) + [self.nameLabel.text sizeWithFont:self.nameLabel.font].width + 10;
        self.sexLabel.frame = sexFrame;
    } else if([keyPath isEqualToString:@"phone"]) {
        self.phoneLabel.text = [object valueForKeyPath:keyPath];
    } else if([keyPath isEqualToString:@"sex"]) {
        NSInteger sex = [[object valueForKeyPath:keyPath] intValue];
        if (sex == 1) {
            self.sexLabel.text = @"先生";
        } else if (sex == 0) {
            self.sexLabel.text = @"女士";
        }
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
