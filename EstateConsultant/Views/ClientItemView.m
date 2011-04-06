//
//  ClientItemView.m
//  EstateConsultant
//
//  Created by farthinker on 4/2/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import "ClientItemView.h"
#import "DataProvider.h"


@implementation ClientItemView

@synthesize client = _client;
@synthesize clientHistory = _clientHistory;
@synthesize nameLabel = _nameLabel;
@synthesize phoneLabel = _phoneLabel;
@synthesize dateLabel = _dateLabel;

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
    [_clientHistory release];
    [_nameLabel release];
    [_phoneLabel release];
    [_dateLabel release];
    [super dealloc];
}


- (void)setClient:(Client *)client
{
    NSString *name = nil;
    if ([client.sex intValue] == 0) {
        name = [client.name stringByAppendingString:@"女士"];
    } else {
        name = [client.name stringByAppendingString:@"先生"];        
    }
    
    [self.nameLabel setText:name];
    [self.phoneLabel setText:client.phone];

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [self.dateLabel setText:[dateFormatter stringFromDate:client.date]];
    
    _client = [client retain];
}

@end
