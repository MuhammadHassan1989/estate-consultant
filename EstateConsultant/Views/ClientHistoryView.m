//
//  ClientHistoryView.m
//  EstateConsultant
//
//  Created by farthinker on 5/14/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import "ClientHistoryView.h"


@implementation ClientHistoryView

@synthesize dateLabel = _dateLabel;
@synthesize actionLabel = _actionLabel;
@synthesize history = _history;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _houseLabels = [[NSMutableArray alloc] init];
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
    [_history release];
    [_dateLabel release];
    [_actionLabel release];
    [_houseLabels release];
    [super dealloc];
}

- (void)setHistory:(History *)history
{
    if (history == _history) {
        return;
    }
    
    [_houseLabels makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_houseLabels removeAllObjects];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    self.dateLabel.text = [dateFormatter stringFromDate:history.date];
    [dateFormatter release];
    
    if (history.action.intValue == 0) {
        self.actionLabel.text = @"首次来访";
        self.actionLabel.textColor = [UIColor blackColor];
    } else if (history.action.intValue == 1) {
        self.actionLabel.text = @"关注";
    } else if (history.action.intValue == 2) {
        self.actionLabel.text = @"认购";
    } else if (history.action.intValue == 3) {
        self.actionLabel.text = @"购买";
    }
    
    NSInteger originY = 0;
    for (House *house in history.houses) {
        UIFont *houseFont = [UIFont fontWithName:@"STHeitiSC-Medium" size:20];
        
        NSString *houseText = [NSString stringWithFormat:@"%@ - %@号楼%@单元%@号%@楼 - ", house.layout.name,
                               house.position.unit.building.number,house.position.unit.number, house.position.name, house.floor];
        CGRect frame = CGRectMake(220, originY, 320, 50);
        UILabel *houseLabel = [[UILabel alloc] initWithFrame:frame];
        houseLabel.font = houseFont;
        houseLabel.text = houseText;
        houseLabel.textColor = [UIColor colorWithHue:0.086 saturation:0.62 brightness:0.51 alpha:1.0];
        houseLabel.backgroundColor = [UIColor clearColor];
        
        CGRect statusFrame = CGRectMake(220 + [houseText sizeWithFont:houseFont].width, originY, 80, 50);
        UILabel *statusLabel = [[UILabel alloc] initWithFrame:statusFrame];
        statusLabel.font = houseFont;
        statusLabel.textColor = [UIColor colorWithHue:0.086 saturation:0.62 brightness:0.51 alpha:1.0];
        statusLabel.backgroundColor = [UIColor clearColor];
        
        if (house.status.intValue == 1) {
            statusLabel.text = @"待售";
        } else if (house.status.intValue == 2) {
            statusLabel.text = @"认购";
        } else if (house.status.intValue == 3) {
            statusLabel.text = @"已售";
        }
        
        [self addSubview:houseLabel];
        [self addSubview:statusLabel];
        [_houseLabels addObject:houseLabel];
        [_houseLabels addObject:statusLabel];
        [houseLabel release];
        
        originY += 50;
    }
    
    CGRect frame = self.frame;
    frame.size.height = MAX(50, originY - 10);
    self.frame = frame;
    
    [_history release];
    _history = [history retain];
}

@end
