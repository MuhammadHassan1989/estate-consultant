//
//  HouseItemView.m
//  EstateConsultant
//
//  Created by farthinker on 6/9/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import "HouseItemView.h"


@implementation HouseItemView

@synthesize house = _house;
@synthesize floorLabel = _floorLabel;
@synthesize statusLabel = _statusLabel;
@synthesize numberLabel = _numberLabel;
@synthesize priceLabel = _priceLabel;
@synthesize totalPriceLabel = _totalPriceLabel;
@synthesize followLabel = _followLabel;
@synthesize backgroundImage = _backgroundImage;

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
    [_statusLabel release];
    [_numberLabel release];
    [_priceLabel release];
    [_totalPriceLabel release];
    [_followLabel release];
    [_backgroundImage release];
    [super dealloc];
}

- (void)setHouse:(House *)house
{
    if (house == _house) {
        return;
    }
    
    self.floorLabel.text = [NSString stringWithFormat:@"%@", house.floor];
    self.numberLabel.text = [NSString stringWithFormat:@"%@", house.num];
    self.followLabel.text = [NSString stringWithFormat:@"%i", house.followers.count];
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    CGFloat totalPrice = house.price.floatValue / 10000;
    [numberFormatter setPositiveFormat:@"#,##0.#"];
    self.totalPriceLabel.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:totalPrice]];
    
    CGFloat price = house.price.floatValue / (house.layout.floorArea.floatValue + house.layout.poolArea.floatValue);
    [numberFormatter setPositiveFormat:@"#,###,##0"];
    self.priceLabel.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:price]];
    [numberFormatter release];
    
    if (house.status.intValue == 1) {
        self.statusLabel.text = @"待售";
    } else if (house.status.intValue == 2) {
        self.statusLabel.text = @"已认购";
        self.backgroundImage.image = [UIImage imageNamed:@"housedetail-ordered.png"];
    } else if (house.status.intValue > 2) {
        self.statusLabel.text = @"已售";
        self.backgroundImage.image = [UIImage imageNamed:@"housedetail-sold.png"];
        self.priceLabel.textColor = [UIColor colorWithHue:0 saturation:0 brightness:0.4f alpha:1.0f];
        self.totalPriceLabel.textColor = [UIColor colorWithHue:0 saturation:0 brightness:0.4f alpha:1.0f];
        self.followLabel.textColor = [UIColor colorWithHue:0 saturation:0 brightness:0.4f alpha:1.0f];
    }
    
    [_house release];
    _house = [house retain];
}

- (IBAction)showCalculator:(id)sender {
    NSDictionary *userInfo = [[NSDictionary alloc] initWithObjectsAndKeys:self.house, @"house", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CalculateLoan"
                                                        object:self 
                                                      userInfo:userInfo];
    [userInfo release];
}

@end
