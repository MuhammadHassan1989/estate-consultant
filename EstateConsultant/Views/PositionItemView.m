//
//  PositionItemView.m
//  EstateConsultant
//
//  Created by farthinker on 4/11/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import "PositionItemView.h"


@implementation PositionItemView

@synthesize layoutID = _layoutID;
@synthesize position = _position;
@synthesize button = _button;
@synthesize delegate = _delegate;

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
    [_position release];
    [_button release];
    [super dealloc];
}

- (void)setPosition:(Position *)position
{
    [self.button setTitle:position.name forState:UIControlStateNormal];
    
    if (_position != nil) {
        [_position release];
        _position = nil;
    }
    _position = [position retain];
}

- (IBAction)selectPosition:(id)sender forEvent:(UIEvent *)event {
    [self.delegate positionSelected:self.position];
}

@end
