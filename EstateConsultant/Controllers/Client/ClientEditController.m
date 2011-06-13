//
//  ClientEditController.m
//  EstateConsultant
//
//  Created by farthinker on 5/14/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import "ClientEditController.h"
#import "ProfileEditView.h"
#import "NumberInputView.h"


@implementation ClientEditController

@synthesize client = _client;
@synthesize profiles = _profiles;
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
    [_profiles release];
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
    
    UIImage *defaultBackground = [UIImage imageNamed:@"profile-field.png"];
    UIImage *selectedBackground = [UIImage imageNamed:@"profile-field-selected.png"];
    self.sexSegments.defaultBackground = [defaultBackground stretchableImageWithLeftCapWidth:10 topCapHeight:0];
    self.sexSegments.selectedBackground = [selectedBackground stretchableImageWithLeftCapWidth:10 topCapHeight:0];
    self.sexSegments.items = [NSArray arrayWithObjects:@"女士", @"先生", nil];
        
    NSInteger index = 0;
    for (Profile *profile in self.profiles) {
        UIViewController *profileFieldController = [[UIViewController alloc] initWithNibName:@"ProfileEditView" bundle:nil];
        ProfileEditView *profileField = (ProfileEditView *)profileFieldController.view;
        profileField.frame = CGRectMake(40, index * 60 + 175, 628, 50);
        profileField.profile = profile;
        
        [self.profileList addSubview:profileField];
        [_profileFields addObject:profileField];
        [profileFieldController release];
        
        index++;
    }
    
    [self.profileList setContentSize:CGSizeMake(710, index * 60 + 175)];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self 
                                                                                 action:@selector(tapStar:)];
    [self.starImage addGestureRecognizer:tapGesture];
    [tapGesture release];
    
    UIViewController *numberInputController = [[UIViewController alloc] initWithNibName:@"NumberInputView" bundle:nil];
    NumberInputView *numberInputView = (NumberInputView *)numberInputController.view;
    numberInputView.textfield = self.phoneField;
    self.phoneField.inputView = numberInputView;
    [numberInputController release];
}

- (void)viewDidUnload
{
    [self setClient:nil];
    [self setProfiles:nil];
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField != self.phoneField) {
        return YES;
    }
    
    NSPredicate *numberPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES '^[0-9]*$'"];
    if (![numberPredicate evaluateWithObject:string]) {
        return NO;
    } else {
        return YES;
    }
}

- (void)setClient:(Client *)client
{
    if (client.starred.intValue) {
        self.starImage.highlighted = YES;
    }
    
    self.nameField.text = client.name;
    self.phoneField.text = client.phone;
    self.sexSegments.selectedIndex = client.sex.intValue;
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
    self.client.sex = [NSNumber numberWithInteger:self.sexSegments.selectedIndex];
    self.client.phone = self.phoneField.text;
    
    [_profileFields makeObjectsPerformSelector:@selector(saveChanges)];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"EndEditClient" object:self];
}

- (IBAction)cancelEdit:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"EndEditClient" object:self];
}

@end
