//
//  StockListHeaderView.m
//  EstateConsultant
//
//  Created by farthinker on 6/8/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import "StockListHeaderView.h"


@implementation StockListHeaderView

@synthesize nameLabel = _nameLabel;

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
    [_nameLabel release];
    [super dealloc];
}

@end
