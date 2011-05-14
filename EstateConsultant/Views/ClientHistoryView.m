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
    
    if (history.action.intValue == 1) {
        self.actionLabel.text = @"关注";
    } else if (history.action.intValue == 2) {
        self.actionLabel.text = @"认购";
    } else if (history.action.intValue == 3) {
        self.actionLabel.text = @"购买";
    }
    
    NSInteger originX = 210;
    for (House *house in history.houses) {
        UIFont *houseFont = [UIFont systemFontOfSize:16];
        NSString *houseText = [NSString stringWithFormat:@"#%@(%@)", house.num, house.layout.name];
        NSInteger textWidth = [houseText sizeWithFont:houseFont].width;
        CGRect frame = CGRectMake(originX, 0, textWidth, 50);
        UILabel *houseLabel = [[UILabel alloc] initWithFrame:frame];
        houseLabel.font = houseFont;
        houseLabel.text = houseText;
        houseLabel.backgroundColor = [UIColor clearColor];
        
        [self addSubview:houseLabel];
        [_houseLabels addObject:houseLabel];
        [houseLabel release];
        
        originX = originX + textWidth + 20;
    }
    
    [_history release];
    _history = [history retain];
}

@end
