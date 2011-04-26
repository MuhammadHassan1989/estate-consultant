//
//  LayoutListViewController.m
//  EstateConsultant
//
//  Created by farthinker on 4/9/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import "LayoutListViewController.h"
#import "DataProvider.h"


@implementation LayoutListViewController

@synthesize scrollView = _scrollView;
@synthesize layouts = _layouts;
@synthesize selectedLayout = _selectedLayout;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [_scrollView release];
    [_layouts release];
    [_layoutItems release];
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
    [self setScrollView:nil];
    [self setLayouts:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (void)setLayouts:(NSArray *)layouts
{    
    if (_layoutItems != nil) {
        for (LayoutItemView *item in _layoutItems) {
            [item removeFromSuperview];
        }
        [_layoutItems release];
        _layoutItems = nil;
    }
    _layoutItems = [[NSMutableArray alloc] initWithCapacity:layouts.count];
    
    NSInteger index = 0;
    for (Layout *layout in layouts) {
        UIViewController *layoutItemController = [[UIViewController alloc] initWithNibName:@"LayoutItemView" bundle:nil];
        [layoutItemController.view setFrame:CGRectMake(0, index * 82, self.view.frame.size.width, 80)];
        [(LayoutItemView *)layoutItemController.view setLayout:layout];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectLayout:)];
        [layoutItemController.view addGestureRecognizer:tapGesture];
        [tapGesture release];
        
        [self.scrollView addSubview:layoutItemController.view];
        [_layoutItems addObject:layoutItemController.view];
        [layoutItemController release];
        index ++;
    }
    
    [self.scrollView setContentSize:CGSizeMake(self.contentSizeForViewInPopover.width, index * 82)];
    
    if (_layouts != nil) {
        [_layouts release];
        _layouts = nil;
    }
    _layouts = [layouts retain];
}

- (void)setSelectedLayout:(Layout *)selectedLayout
{
    for (LayoutItemView *itemView in _layoutItems) {
        if (itemView.layout.layoutID == selectedLayout.layoutID) {
            itemView.selected = YES;
        } else {
            itemView.selected = NO;
        }
    }
    
    _selectedLayout = selectedLayout;
}

- (void)selectLayout:(UIGestureRecognizer *)gesture
{
    LayoutItemView *layoutItem = (LayoutItemView *)gesture.view;
    if (_selectedLayout.layoutID == layoutItem.layout.layoutID) {
        return;
    }
    
    [self setSelectedLayout:layoutItem.layout];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LayoutSelected" object:layoutItem];
}


@end
