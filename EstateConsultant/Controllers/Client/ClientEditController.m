//
//  ClientEditController.m
//  EstateConsultant
//
//  Created by farthinker on 5/14/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import "ClientEditController.h"
#import "ProfileEditView.h"


@implementation ClientEditController

@synthesize client = _client;
@synthesize starImage = _starImage;
@synthesize sexSegments = _sexSegments;
@synthesize nameField = _nameField;
@synthesize phoneField = _phoneField;
@synthesize profileList = _profileList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _profileFields = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [_client release];
    [_starImage release];
    [_sexSegments release];
    [_nameField release];
    [_phoneField release];
    [_profileList release];
    [_profileFields release];
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
        UIViewController *profileFieldController = [[UIViewController alloc] initWithNibName:@"ProfileEditView" bundle:nil];
        ProfileEditView *profileField = (ProfileEditView *)profileFieldController.view;
        profileField.frame = CGRectMake(40, index * 60 + 120, 620, 50);
        profileField.profile = profile;
        
        [self.profileList addSubview:profileField];
        [_profileFields addObject:profileField];
        [profileFieldController release];
        
        index++;
    }
    
    [self.profileList setContentSize:CGSizeMake(702, index * 60 + 120)];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self 
                                                                                 action:@selector(tapStar:)];
    [self.starImage addGestureRecognizer:tapGesture];
    [tapGesture release];
}

- (void)viewDidUnload
{
    [self setClient:nil];
    [self setStarImage:nil];
    [self setSexSegments:nil];
    [self setNameField:nil];
    [self setPhoneField:nil];
    [self setProfileList:nil];
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
    if (client.starred.intValue) {
        self.starImage.highlighted = YES;
    }
    
    self.nameField.text = client.name;
    self.phoneField.text = client.phone;
    self.sexSegments.selectedSegmentIndex = client.sex.intValue;
    self.starImage.highlighted = client.starred.boolValue;
    [_profileFields makeObjectsPerformSelector:@selector(setClient:) withObject:client];
    
    
    [_client release];
    _client = [client retain];
}

- (void)tapStar:(UIGestureRecognizer *)gesture
{
    self.starImage.highlighted = !self.starImage.highlighted;
}

- (IBAction)endEdit:(id)sender {
    self.client.starred = [NSNumber numberWithBool:self.starImage.highlighted];    
    self.client.name = self.nameField.text;
    self.client.sex = [NSNumber numberWithInteger:self.sexSegments.selectedSegmentIndex];
    self.client.phone = self.phoneField.text;
    
    [_profileFields makeObjectsPerformSelector:@selector(saveChanges)];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"EndEditClient" object:self];
}

- (IBAction)cancelEdit:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"EndEditClient" object:self];
}

@end
