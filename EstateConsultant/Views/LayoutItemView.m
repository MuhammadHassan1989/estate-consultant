//
//  LayoutItemView.m
//  EstateConsultant
//
//  Created by farthinker on 4/9/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import "LayoutItemView.h"


@implementation LayoutItemView
@synthesize layout = _layout;
@synthesize selected = _selected;
@synthesize nameLabel = _nameLabel;
@synthesize areaLabel = _areaLabel;
@synthesize onSaleCountLabel = _onSaleCountLabel;
@synthesize arrowImage = _arrowImage;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setLayout:(Layout *)layout
{
    [self.nameLabel setText:layout.name];
    [self.areaLabel setText:[NSString stringWithFormat:@"%im²", [layout.area intValue]]];
    
    NSSet *onSaleHouses = [[DataProvider sharedProvider] getOnSaleHousesOfLayout:layout];
    [self.onSaleCountLabel setText:[NSString stringWithFormat:@"余%u套", onSaleHouses.count]];
    
    if (_layout != nil) {
        [_layout release];
        _layout = nil;
    }
    _layout = [layout retain];
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
    [_layout release];
    [_nameLabel release];
    [_areaLabel release];
    [_onSaleCountLabel release];
    [_arrowImage release];
    [super dealloc];
}

- (void)setSelected:(Boolean)selected
{
    if (selected) {
        self.backgroundColor = [UIColor whiteColor];
    } else {
        self.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];        
    }
    
    _selected = selected;
}


@end
