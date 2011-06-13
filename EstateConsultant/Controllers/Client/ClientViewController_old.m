//
//  ClientViewController.m
//  EstateConsultant
//
//  Created by farthinker on 4/29/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import "ClientViewController.h"
#import "ClientTypeController.h"
#import "ClientListController.h"

@implementation ClientViewController

@synthesize consultant = _consultant;
@synthesize detailController = _detailController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)dealloc
{
    [_listNavController release];
    [_detailController release];
    [_editController release];
    [_consultant release];
    [_maskView release];
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
    
    _maskView = [[UIView alloc] initWithFrame:self.view.frame];
    _maskView.backgroundColor = [UIColor blackColor];
    _maskView.hidden = YES;
    _maskView.alpha = 0;
    [self.view addSubview:_maskView];
    
    ClientTypeController *clientTypeController = [[ClientTypeController alloc] initWithNibName:@"ClientTypeController" bundle:nil];
    clientTypeController.consultant = self.consultant;
    clientTypeController.navigationItem.title = @"分类";
    _listNavController = [[UINavigationController alloc] initWithRootViewController:clientTypeController];
    _listNavController.delegate = self;
    [clientTypeController release];
    
    ClientListController *clientListController = [[ClientListController alloc] initWithNibName:@"ClientListViewController" bundle:nil];
    clientListController.clientType = 0;
    clientListController.consultant = self.consultant;
    clientListController.navigationItem.title = @"我的客户";
    [_listNavController pushViewController:clientListController animated:NO];
    [clientListController release];
    
    [_listNavController.view setFrame:CGRectMake(0, 0, 320, 694)];
    [self.view addSubview:_listNavController.view];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showClient:)
                                                 name:@"SelectClient"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(startEditClient:)
                                                 name:@"StartEditClient"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(endEditClient:)
                                                 name:@"EndEditClient"
                                               object:nil];
}

- (void)viewDidUnload
{
    [self setConsultant:nil];
    [self setDetailController:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft) ||
    (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (void)showClient:(NSNotification *)notification
{
    if (_detailController == nil) {
        _detailController = [[ClientDetailController alloc] initWithNibName:@"ClientDetailController" bundle:nil];
        [_detailController.view setFrame:CGRectMake(322, 0, 702, 694)];
        [self.view addSubview:_detailController.view];
    }
    
    Client *client = [[notification userInfo] valueForKey:@"client"];
    _detailController.client = client;
}

- (void)startEditClient:(NSNotification *)notification
{
    _maskView.frame = _listNavController.view.frame;
    _maskView.hidden = NO;
    [self.view bringSubviewToFront:_maskView];
    
    if (_editController == nil) {
        _editController = [[ClientEditController alloc] initWithNibName:@"ClientEditController" bundle:nil];
        [_editController.view setFrame:CGRectMake(322, 0, 702, 694)];
        [_editController.view setAlpha:0];
        [self.view addSubview:_editController.view];
    }
    
    Client *client = [[notification userInfo] valueForKey:@"client"];
    _editController.client = client;
    _editController.view.hidden = NO;
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         _maskView.alpha = 0.4;
                         _editController.view.alpha = 1;
                     }];
}

- (void)endEditClient:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3
                     animations:^{
                         _maskView.alpha = 0;
                         _editController.view.alpha = 0;
                     }
                     completion:^(BOOL finished){
                         _maskView.hidden = YES;
                         _editController.view.hidden = YES;
                     }];
}

- (void)navigationController:(UINavigationController *)navigationController 
      willShowViewController:(UIViewController *)viewController 
                    animated:(BOOL)animated
{
    if (viewController == [navigationController.viewControllers objectAtIndex:0]
        && _detailController != nil) {
        _maskView.frame = _detailController.view.frame;
        _maskView.hidden = NO;
        [self.view bringSubviewToFront:_maskView];
        
        [UIView animateWithDuration:0.3 
                         animations:^{
                             _maskView.alpha = 0.4;
                         }];
    } else {
        [UIView animateWithDuration:0.3 
                         animations:^{
                             _maskView.alpha = 0;
                         }
                         completion:^(BOOL finished){
                             _maskView.hidden = YES;
                         }];
    }
}


@end
