//
//  ProfileFieldView.m
//  EstateConsultant
//
//  Created by farthinker on 5/9/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import "ProfileFieldView.h"


@implementation ProfileFieldView

@synthesize profile = _profile;
@synthesize client = _client;
@synthesize nameLabel = _nameLabel;
@synthesize valueLabel = _valueLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
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
    [_profile release];
    [_client release];
    [_nameLabel release];
    [_valueLabel release];
    [super dealloc];
}

- (void)setProfile:(Profile *)profile
{
    if (profile == _profile) {
        return;
    }
    
    self.nameLabel.text = profile.name;
    
    [_profile release];
    _profile = [profile retain];
}

- (void)setClient:(Client *)client
{
    if (client == _client) {
        return;
    }
    
    ClientProfile *clientProfile = [[DataProvider sharedProvider] getClientProfile:self.profile ofClient:client];
    if ([self.profile.type isEqualToString:@"text"]) {
        self.valueLabel.text = clientProfile.value;
    } else if ([self.profile.type isEqualToString:@"select"]) {
        NSArray *segments = [self.profile.meta componentsSeparatedByString:@";"];
        self.valueLabel.text = [segments objectAtIndex:[clientProfile.value intValue]];
    }
    
    [clientProfile addObserver:self forKeyPath:@"value" options:NSKeyValueObservingOptionNew context:nil];
    
    [_client release];
    _client = [client retain];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([self.profile.type isEqualToString:@"text"]) {
        self.valueLabel.text = [object valueForKeyPath:keyPath];
    } else if ([self.profile.type isEqualToString:@"select"]) {
        NSArray *segments = [self.profile.meta componentsSeparatedByString:@";"];
        self.valueLabel.text = [segments objectAtIndex:[[object valueForKeyPath:keyPath] intValue]];
    }
}

@end
