//
//  LayoutViewController.m
//  EstateConsultant
//
//  Created by farthinker on 4/9/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import "LayoutViewController.h"
#import "ClientViewController.h"
#import "LayoutListViewController.h"
#import "HouseListViewController.h"
#import "CustomNavigationController.h"
#import "PositionItemView.h"
#import "LayoutItemView.h"
#import "EstateConsultantAppDelegate.h"
#import "EstateConsultantUtils.h"


@implementation LayoutViewController

@synthesize client = _client;
@synthesize layout = _layout;
@synthesize descLabel = _descLabel;
@synthesize nameLabel = _nameLabel;
@synthesize areaLabel = _areaLabel;
@synthesize priceLabel = _priceLabel;
@synthesize totalPriceLabel = _totalPriceLabel;
@synthesize followerLabel = _followerLabel;
@synthesize onSaleCountLabel = _onSaleCountLabel;
@synthesize scrollView = _scrollView;
@synthesize positionView = _positionView;
@synthesize layoutListButton = _layoutListButton;

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
    [_client release];
    [_layout release];
    [_descLabel release];
    [_nameLabel release];
    [_areaLabel release];
    [_priceLabel release];
    [_totalPriceLabel release];
    [_followerLabel release];
    [_onSaleCountLabel release];
    [_scrollView release];
    [_positionView release];
    [_layoutListButton release];
    [_layoutListPopover release];
    [_positionItems release];
    [_layoutPictureView release];
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(layoutSelected:) 
                                                 name:@"LayoutSelected" 
                                               object:nil];
}

- (void)viewDidUnload
{
    [self setClient:nil];
    [self setLayout:nil];
    [self setNameLabel:nil];
    [self setDescLabel:nil];
    [self setNameLabel:nil];
    [self setAreaLabel:nil];
    [self setPriceLabel:nil];
    [self setTotalPriceLabel:nil];
    [self setFollowerLabel:nil];
    [self setOnSaleCountLabel:nil];
    [self setScrollView:nil];
    [self setPositionView:nil];
    [self setLayoutListButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft
        || self.interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        [UIView animateWithDuration:duration
                         animations:^{
                             self.layoutListButton.alpha = 0;
                         }
                         completion:^(BOOL finished){
                             self.layoutListButton.hidden = YES;
                         }];
        
    } else {
        [UIView animateWithDuration:duration
                         animations:^{
                             self.layoutListButton.hidden = NO;
                             self.layoutListButton.alpha = 1;
                         }
                         completion:nil];
    }
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width, self.scrollView.contentSize.height)];
}

- (void)setLayout:(Layout *)layout
{
    [self.nameLabel setText:layout.name];
    [self.descLabel setText:layout.desc];
    [self.areaLabel setText:[NSString stringWithFormat:@"%im²", layout.area.intValue]];
    
    NSInteger maxPrice = [[layout valueForKeyPath:@"houses.@max.price"] intValue];
    NSInteger minPrice = [[layout valueForKeyPath:@"houses.@min.price"] intValue];
    NSInteger maxTotal = layout.area.intValue * maxPrice / 10000;
    NSInteger minTotal = layout.area.intValue * minPrice / 10000;
    [self.priceLabel setText:[NSString stringWithFormat:@"%i~%i元/m²", minPrice, maxPrice]];
    [self.totalPriceLabel setText:[NSString stringWithFormat:@"%i~%i万元", minTotal, maxTotal]];
    
    [self.followerLabel setText:[NSString stringWithFormat:@"%i", layout.followers.count]];
    
    NSSet *onSaleHouses = [[DataProvider sharedProvider] getOnSaleHousesOfLayout:layout];
    [self.onSaleCountLabel setText:[NSString stringWithFormat:@"%i", onSaleHouses.count]];
    
    if (_layoutPictureView != nil) {
        [_layoutPictureView removeFromSuperview];
        _layoutPictureView = nil;
    }
    UIViewController *picsController = [[UIViewController alloc] initWithNibName:@"LayoutPictureView" bundle:nil];
    _layoutPictureView = (LayoutPictureView *)picsController.view;    
    [_layoutPictureView setFrame:CGRectMake(0, 236, self.scrollView.frame.size.width, 612)];
    [_layoutPictureView setLayout:layout];
    [self.scrollView addSubview:_layoutPictureView];
    [picsController release];
    
    NSSet *positions = [layout valueForKeyPath:@"houses.@distinctUnionOfObjects.position"];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"positionID" ascending:YES];
    NSArray *sortedPositions = [positions sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    CGRect positionFrame = [self.positionView frame];
    CGRect newPositionFrame = CGRectMake(positionFrame.origin.x, positionFrame.origin.y, positionFrame.size.width, 20 + sortedPositions.count / 2 * 70);
    [self.positionView setFrame:newPositionFrame];
    
    if (_positionItems != nil) {
        for (PositionItemView *pItem in _positionItems) {
            [pItem removeFromSuperview];
        }
        [_positionItems release];
        _positionItems = nil;
    }
    _positionItems = [[NSMutableArray alloc] initWithCapacity:sortedPositions.count];
    
    NSInteger pIndex = 0;
    for (Position *position in sortedPositions) {
        NSInteger originX = 40 + (pIndex % 2) * (newPositionFrame.size.width / 2 - 20);
        NSInteger originY = 20 + pIndex / 2 * 70;
        UIViewController *positionItemController = [[UIViewController alloc] initWithNibName:@"PositionItemView" bundle:nil];
        PositionItemView *pView = (PositionItemView *)positionItemController.view;
        [pView setFrame:CGRectMake(originX, originY, newPositionFrame.size.width / 2 - 60, 50)];
        [pView setPosition:position];
        [pView setLayoutID:self.layout.layoutID.intValue];
        [pView setDelegate:self];
        
        [self.positionView addSubview:pView];
        [_positionItems addObject:pView];
        [positionItemController release];
        pIndex++;
    }
    
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width, newPositionFrame.origin.y + newPositionFrame.size.height)];
    
    [[DataProvider sharedProvider] historyOfClient:self.client withAction:0 andTarget:layout];
    
    if (_layout != nil) {
        [_layout release];
        _layout = nil;
    }
    _layout = [layout retain];
}

- (void)layoutSelected:(NSNotification *)notification
{   
    [_layoutListPopover dismissPopoverAnimated:NO];
    LayoutItemView *view = (LayoutItemView *)notification.object;        
    [self setLayout:view.layout];
}

- (void)positionSelected:(Position *)position
{
    HouseListViewController *houseLiseController = [[HouseListViewController alloc] initWithNibName:@"HouseListViewController" bundle:nil];
    [houseLiseController setClient:self.client];
    [houseLiseController setPosition:position];
    [houseLiseController setLayoutController:self];
    
    CustomNavigationController *navController = [[CustomNavigationController alloc] initWithRootViewController:houseLiseController];
    [navController setModalPresentationStyle:UIModalPresentationFormSheet];
    
    [self presentModalViewController:navController animated:YES];
    [houseLiseController release];
    [navController release];
}

- (void)closeHouseList
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)closeCalculator
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)showLayoutList:(id)sender forEvent:(UIEvent *)event {
    if (_layoutListPopover == nil) {
        LayoutListViewController *layoutListController = [self.splitViewController.viewControllers objectAtIndex:0];
        NSInteger popHeight = layoutListController.layouts.count * 82;
        if (popHeight > 600) {
            popHeight = 600;
        }
        layoutListController.contentSizeForViewInPopover = CGSizeMake(320, popHeight);
                
        _layoutListPopover = [[UIPopoverController alloc] initWithContentViewController:layoutListController];
    }
    
    [_layoutListPopover presentPopoverFromRect:((UIButton *)sender).frame
                                        inView:self.view
                      permittedArrowDirections:UIPopoverArrowDirectionAny
                                      animated:NO];
}

- (IBAction)returnToClient:(id)sender forEvent:(UIEvent *)event {
    ClientViewController *clientController = [[ClientViewController alloc] initWithNibName:@"ClientViewController" bundle:nil];
    [clientController setClient:self.client];
    [clientController.view setFrame:[UIScreen mainScreen].applicationFrame];
    
    EstateConsultantAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.viewController = clientController;
    [clientController release];
}

@end
