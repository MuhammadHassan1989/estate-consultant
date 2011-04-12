//
//  ClientHistoryView.m
//  EstateConsultant
//
//  Created by farthinker on 4/7/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import "ClientHistoryView.h"
#import "LayoutThumbView.h"
#import "EstateConsultantUtils.h"


@implementation ClientHistoryView

@synthesize history = _history;
@synthesize dateLabel = _dateLabel;
@synthesize actionLabel = _actionLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)layoutSubviews
{
    NSInteger index = 0;
    for (LayoutThumbView *view in _layoutThumbViews) {
        NSInteger width = (self.frame.size.width - 120) / 2;
        NSInteger originX = (index % 2) * (width + 40) + 40;
        CGRect frame = [view frame];
        [view setFrame:CGRectMake(originX, frame.origin.y, width, frame.size.height)];
        index++;
    }
}

- (void)setHistory:(History *)history
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [self.dateLabel setText:[dateFormatter stringFromDate:history.date]];
    [dateFormatter release];
    
    NSString *actionText = nil;
    NSInteger action = [history.action intValue];
    if (action == 0) {
        actionText = @"关注";
    } else if (action == 1) {
        actionText = @"意向购买";
    } else if (action == 2) {
        actionText = @"预订购买";
    } else if (action == 3) {
        actionText = @"签订购买合同";
    }
    [self.actionLabel setText:actionText];
    
    NSString *documentsPath = [[[EstateConsultantUtils sharedUtils] documentsURL] path];
    NSMutableArray *targets = nil;
    if (action == 0) {
        targets = [[NSMutableArray alloc] initWithCapacity:[history.layouts count]];
        for (Layout *target in history.layouts) {
            NSInteger layoutID = [target.layoutID intValue];
            NSString *pathComponent = [NSString stringWithFormat:@"layout/layout-%i/layout-%i.jpg", layoutID, layoutID];
            NSString *imgPath = [documentsPath stringByAppendingPathComponent:pathComponent];
            UIImage *img = [[UIImage alloc] initWithContentsOfFile:imgPath];
            
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:3];
            [dict setObject:target.name forKey:@"name"];
            [dict setObject:[NSNumber numberWithInt:1] forKey:@"status"];
            [dict setObject:img forKey:@"image"];
            [targets addObject:dict];
            
            [img release];
            [dict release];
        }
    } else {
        targets = [[NSMutableArray alloc] initWithCapacity:[history.houses count]];
        for (House *target in history.houses) {
            NSInteger layoutID = [target.layout.layoutID intValue];
            NSString *pathComponent = [NSString stringWithFormat:@"layout/layout-%i/layout-%i.jpg", layoutID, layoutID];
            NSString *imgPath = [documentsPath stringByAppendingPathComponent:pathComponent];
            UIImage *img = [[UIImage alloc] initWithContentsOfFile:imgPath];
            
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:3];
            [dict setObject:[target.layout.name stringByAppendingFormat:@"(%@)", target.num] forKey:@"name"];
            [dict setObject:target.status forKey:@"status"];
            [dict setObject:img forKey:@"image"];
            [targets addObject:dict];
            
            [img release];
            [dict release];
        }
    }
    
    if (_layoutThumbViews != nil) {
        for (LayoutThumbView *view in _layoutThumbViews) {
            [view removeFromSuperview];
        }
        [_layoutThumbViews release];
    }
    _layoutThumbViews = [[NSMutableArray alloc] initWithCapacity:[targets count]];
    
    NSInteger index = 0;
    for (NSDictionary *target in targets) {
        NSInteger originX = 40 + (index % 2) * 320;
        NSInteger originY = 90 + floor(index / 2) * 320;
        UIViewController *targetController = [[UIViewController alloc] initWithNibName:@"LayoutThumbView" bundle:nil];
        [targetController.view setFrame:CGRectMake(originX, originY, 280, 280)];
        [(LayoutThumbView *)targetController.view setLayoutInfo:target];
        
        [self addSubview:targetController.view];
        [_layoutThumbViews addObject:targetController.view];
        [targetController release];
        index++;
    }    
    
    [targets release];
    
    CGRect frame = [self frame];
    [self setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 90 + 320 * ceil(index / 2))];
    
    if (_history != nil) {
        [_history release];
        _history = nil;
    }
    _history = [history retain];
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
    [_layoutThumbViews release];
    [super dealloc];
}

@end
