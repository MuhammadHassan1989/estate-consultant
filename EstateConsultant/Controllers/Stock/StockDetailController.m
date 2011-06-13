//
//  StockDetailController.m
//  EstateConsultant
//
//  Created by farthinker on 5/18/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import "StockDetailController.h"
#import "StockTableViewCell.h"
#import "HouseItemView.h"


@implementation StockDetailController

@synthesize position = _position;
@synthesize layoutNameLabel = _layoutNameLabel;
@synthesize layoutAreaLabel = _layoutAreaLabel;
@synthesize layoutActualAreaFieldLabel = _layoutActualAreaFieldLabel;
@synthesize layoutActualAreaLabel = _layoutActualAreaLabel;
@synthesize layoutDescLabel = _layoutDescLabel;
@synthesize scrollView = _scrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _houseItemViews = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [_position release];
    [_houses release];
    [_layoutNameLabel release];
    [_layoutAreaLabel release];
    [_layoutActualAreaFieldLabel release];
    [_layoutActualAreaLabel release];
    [_layoutDescLabel release];
    [_scrollView release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)viewDidUnload
{
    [self setPosition:nil];
    [self setLayoutNameLabel:nil];
    [self setLayoutAreaLabel:nil];
    [self setLayoutActualAreaFieldLabel:nil];
    [self setLayoutActualAreaLabel:nil];
    [self setLayoutDescLabel:nil];
    [self setScrollView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (void)setPosition:(Position *)position
{
    if (position == _position) {
        return;
    }
    
    Layout *layout = [(House *)[position.houses anyObject] layout];
    self.layoutNameLabel.text = layout.name;
    CGFloat area = layout.floorArea.floatValue + layout.poolArea.floatValue;
    self.layoutAreaLabel.text = [NSString stringWithFormat:@"%i㎡", (NSInteger)roundf(area)];
    self.layoutDescLabel.text = layout.desc;
    
    if (layout.actualArea.floatValue == 0 || layout.actualArea.floatValue == area) {
        self.layoutActualAreaLabel.hidden = YES;
        self.layoutActualAreaFieldLabel.hidden = YES;
    } else {
        self.layoutActualAreaLabel.hidden = NO;
        self.layoutActualAreaFieldLabel.hidden = NO;
        self.layoutActualAreaLabel.text = [NSString stringWithFormat:@"%i㎡", layout.actualArea.intValue];
    }
    
    [_houseItemViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_houseItemViews removeAllObjects];
    
    [_houses release];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"floor" ascending:NO];
    _houses = [[position.houses sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]] retain];
    [sortDescriptor release];
    
    NSInteger index = 0;
    for (House *house in _houses) {
        NSInteger originY = 96 + index * 110;
        UIViewController *houseItemController = [[UIViewController alloc] initWithNibName:@"HouseItemView" bundle:nil];
        HouseItemView *houseItemView = (HouseItemView *)houseItemController.view;
        houseItemView.frame = CGRectMake(30, originY, 690, 90);
        houseItemView.house = house;
        
        [self.scrollView addSubview:houseItemView];
        [_houseItemViews addObject:houseItemView];
        [houseItemController release];
        index++;
    }
    
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.scrollView.frame), 96 + index * 110);
    
    [_position release];
    _position = [position retain];
}

@end
