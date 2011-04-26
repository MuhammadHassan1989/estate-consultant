//
//  HouseListViewController.m
//  EstateConsultant
//
//  Created by farthinker on 4/13/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import "HouseListViewController.h"
#import "LoanCalculatorViewController.h"
#import "HouseItemView.h"


@implementation HouseListViewController

@synthesize client = _client;
@synthesize scrollView = _scrollView;
@synthesize position = _position;
@synthesize layoutController = _layoutController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)dealloc
{
    [_client release];
    [_scrollView release];
    [_position release];
    [_houseViews release];
    [_calcController release];
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
        
    UIBarButtonItem *returnButton = [[UIBarButtonItem alloc] initWithTitle:@"返回"
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:@selector(closeHouseList:)];
    [self.navigationItem setLeftBarButtonItem:returnButton];
    [returnButton release];
    
    [self.navigationItem setTitle:self.position.name];
    
    NSSortDescriptor *numDescriptor = [[NSSortDescriptor alloc] initWithKey:@"num" ascending:NO];
    NSSortDescriptor *statusDescriptor = [[NSSortDescriptor alloc] initWithKey:@"status" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:statusDescriptor, numDescriptor, nil];
    NSArray *houses = [self.position.houses sortedArrayUsingDescriptors:sortDescriptors];
    [numDescriptor release];
    [statusDescriptor release];
    
    if (_houseViews != nil) {
        for (HouseItemView *item in _houseViews) {
            [item removeFromSuperview];
        }
        [_houseViews release];
        _houseViews = nil;
    }
    _houseViews = [[NSMutableArray alloc] initWithCapacity:houses.count];
    
    NSInteger index = 0;
    for (House *house in houses) {
        UIViewController *houseItemController = [[UIViewController alloc] initWithNibName:@"HouseItemView" bundle:nil];
        [houseItemController.view setFrame:CGRectMake(0, index * 52, self.scrollView.frame.size.width, 50)];
        [(HouseItemView *)houseItemController.view setHouse:house];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self 
                                                                                     action:@selector(selectHouse:)];
        [houseItemController.view addGestureRecognizer:tapGesture];
        [tapGesture release];
        
        [self.scrollView addSubview:houseItemController.view];
        [_houseViews addObject:houseItemController.view];
        [houseItemController release];
        index++;
    }
    
    [self.scrollView setContentSize:CGSizeMake(540, index * 52)];
}

- (void)viewDidUnload
{
    [self setClient:nil];
    [self setScrollView:nil];
    [self setPosition:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

//- (void)setPosition:(Position *)position
//{
//    if (_position != nil) {
//        [_position release];
//        _position = nil;
//    }
//    _position = [position retain];
//}

- (IBAction)closeHouseList:(id)sender {
    [self.layoutController dismissModalViewControllerAnimated:YES];
}

- (void)selectHouse:(UIGestureRecognizer *)gesture
{
    if (_calcController == nil) {
        _calcController = [[LoanCalculatorViewController alloc] initWithNibName:@"LoanCalculatorViewController" bundle:nil];
        [_calcController setLayoutController:self.layoutController];
        [_calcController setClient:self.client];
    }
    
    [self.navigationController pushViewController:_calcController animated:YES];
    HouseItemView *houseItem = (HouseItemView *)gesture.view;
    [_calcController setHouse:houseItem.house];
}

@end
