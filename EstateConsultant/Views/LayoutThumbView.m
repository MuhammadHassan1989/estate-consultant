//
//  LayoutThumbView.m
//  EstateConsultant
//
//  Created by farthinker on 4/7/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import "LayoutThumbView.h"


@implementation LayoutThumbView

@synthesize layoutInfo = _layoutInfo;
@synthesize thumbImage = _thumbImage;
@synthesize nameLabel = _nameLabel;
@synthesize statusImage = _statusImage;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setLayoutInfo:(NSDictionary *)layoutInfo
{
    [self.nameLabel setText:[layoutInfo valueForKey:@"name"]];
    [self.thumbImage setImage:[layoutInfo valueForKey:@"image"]];
    
    if ([[layoutInfo valueForKey:@"status"] intValue] > 1) {
        [self.statusImage setHidden:NO];
    } else {
        [self.statusImage setHidden:YES];
    }
    
    if (_layoutInfo != nil) {
        [_layoutInfo release];
        _layoutInfo = nil;
    }
    _layoutInfo = [layoutInfo retain];
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
    [_layoutInfo release];
    [_thumbImage release];
    [_nameLabel release];
    [_statusImage release];
    [super dealloc];
}

@end
