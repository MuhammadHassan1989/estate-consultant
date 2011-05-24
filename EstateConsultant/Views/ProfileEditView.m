//
//  ProfileEditView.m
//  EstateConsultant
//
//  Created by farthinker on 5/14/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import "ProfileEditView.h"


@implementation ProfileEditView

@synthesize client = _client;
@synthesize profile = _profile;
@synthesize nameLabel = _nameLabel;
@synthesize textField = _textField;
@synthesize segmentField = _segmentField;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc
{
    [_client release];
    [_profile release];
    [_nameLabel release];
    [_textField release];
    [_segmentField release];
    [super dealloc];
}

- (void)setProfile:(Profile *)profile
{
    if (profile == _profile) {
        return;
    }
    
    self.nameLabel.text = profile.name;
    
    [self.segmentField removeAllSegments];
    NSArray *segments = [profile.meta componentsSeparatedByString:@";"];
    NSEnumerator *enumerator = [segments reverseObjectEnumerator];
    NSString *segmentTitle;
    while ((segmentTitle = [enumerator nextObject])) {
        [self.segmentField insertSegmentWithTitle:segmentTitle atIndex:0 animated:NO];
    }
    
    [_profile release];
    _profile = [profile retain];
}

- (void)setClient:(Client *)client
{    
    ClientProfile *clientProfile = [[DataProvider sharedProvider] getClientProfile:self.profile
                                                                          ofClient:client];
    if ([self.profile.type isEqualToString:@"text"]) {
        self.textField.hidden = NO;
        self.segmentField.hidden = YES;
        self.textField.text = clientProfile.value;
    } else if ([self.profile.type isEqualToString:@"select"]) {
        self.textField.hidden = YES;
        self.segmentField.hidden = NO;
        self.segmentField.selectedSegmentIndex = [clientProfile.value intValue];
    }
    
    [_client release];
    _client = [client retain];
}

- (void)saveChanges
{
    ClientProfile *clientProfile = [[DataProvider sharedProvider] getClientProfile:self.profile
                                                                          ofClient:self.client];
    if ([self.profile.type isEqualToString:@"text"]) {
        clientProfile.value = self.textField.text;
    } else if ([self.profile.type isEqualToString:@"select"]) {
        clientProfile.value = [NSString stringWithFormat:@"%i", self.segmentField.selectedSegmentIndex];
    }
}

@end
