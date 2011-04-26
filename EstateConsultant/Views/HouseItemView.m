//
//  HouseItemView.m
//  EstateConsultant
//
//  Created by farthinker on 4/13/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import "HouseItemView.h"


@implementation HouseItemView

@synthesize house = _house;
@synthesize floorLabel = _floorLabel;
@synthesize numLabel = _numLabel;
@synthesize priceLabel = _priceLabel;
@synthesize totalLabel = _totalLabel;
@synthesize statusLabel = _statusLabel;

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
    [_house release];
    [_floorLabel release];
    [_numLabel release];
    [_priceLabel release];
    [_totalLabel release];
    [_statusLabel release];
    [super dealloc];
}

- (void)setHouse:(House *)house
{
    self.floorLabel.text = [NSString stringWithFormat:@"%@楼", house.floor];
    self.numLabel.text = [NSString stringWithFormat:@"#%@", house.num];
    self.priceLabel.text = [NSString stringWithFormat:@"%i元/m²", house.price];
    
    NSInteger totalPrice = round(house.price.intValue * house.layout.area.intValue / 10000);
    self.priceLabel.text = [NSString stringWithFormat:@"%i万元", totalPrice];
    
    if (house.status.intValue == 1) {
        self.statusLabel.text = @"待售";
        self.statusLabel.textColor = [UIColor colorWithRed:0 green:0.5 blue:0.25 alpha:1];
    } else if (house.status.intValue == 2) {
        self.statusLabel.text = @"预订";
        self.statusLabel.textColor = [UIColor lightGrayColor];
    } else if (house.status.intValue == 3) {
        self.statusLabel.text = @"已售";
        self.statusLabel.textColor = [UIColor lightGrayColor];
    } else if (house.status.intValue == 4) {
        self.statusLabel.text = @"锁定";
        self.statusLabel.textColor = [UIColor lightGrayColor];
    }
    
    if (_house != nil) {
        [_house release];
        _house = nil;
    }
    _house = [house retain];
}

@end
