//
//  StockTableViewCell.m
//  EstateConsultant
//
//  Created by farthinker on 5/18/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import "StockTableViewCell.h"


@implementation StockTableViewCell

@synthesize house = _house;
@synthesize floorLabel = _floorLabel;
@synthesize numberLabel = _numberLabel;
@synthesize priceLabel = _priceLabel;
@synthesize totalPriceLabel = _totalPriceLabel;
@synthesize statusLabel = _statusLabel;
@synthesize followLabel = _followLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc
{
    [_house release];
    [_floorLabel release];
    [_numberLabel release];
    [_priceLabel release];
    [_totalPriceLabel release];
    [_statusLabel release];
    [_followLabel release];
    [super dealloc];
}

- (void)setHouse:(House *)house
{
    if (house == _house) {
        return;
    }
    
    self.floorLabel.text = [NSString stringWithFormat:@"%@楼", house.floor];
    self.numberLabel.text = [NSString stringWithFormat:@"#%@", house.num];
    self.priceLabel.text = [NSString stringWithFormat:@"%@元/㎡", house.price];
    self.followLabel.text = [NSString stringWithFormat:@"%i人关注", house.followers.count];
    
    NSInteger totalPrice = house.price.intValue * house.layout.floorArea.intValue / 10000;
    self.totalPriceLabel.text = [NSString stringWithFormat:@"%i万元", totalPrice];
    
    if (house.status.intValue == 1) {
        self.statusLabel.text = @"待售";
        self.statusLabel.textColor = [UIColor colorWithRed:0 green:0.5 blue:0.25 alpha:1];
    } else if (house.status.intValue == 2) {
        self.statusLabel.text = @"已认购";
        self.statusLabel.textColor = [UIColor orangeColor];
    } else if (house.status.intValue > 2) {
        self.statusLabel.text = @"已售";  
        self.statusLabel.textColor = [UIColor lightGrayColor];
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
