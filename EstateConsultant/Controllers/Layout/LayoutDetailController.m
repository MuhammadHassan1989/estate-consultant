//
//  LayoutDetailController.m
//  EstateConsultant
//
//  Created by farthinker on 5/17/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "LayoutDetailController.h"
#import "PictureGalleryController.h"
#import "EstateConsultantUtils.h"
#import "EstateConsultantAppDelegate.h"

@implementation LayoutDetailController

@synthesize layout = _layout;
@synthesize nameLabel = _nameLabel;
@synthesize areaLabel = _areaLabel;
@synthesize actualAreaLabel = _actualAreaLabel;
@synthesize actualAreaFieldLabel = _actualAreaFieldLabel;
@synthesize descLabel = _descLabel;
@synthesize followLabel = _followLabel;
@synthesize stockLabel = _stockLabel;
@synthesize scrollView = _scrollView;
@synthesize prevButton = _prevButton;
@synthesize nextButton = _nextButton;
@synthesize currentPage = _currentPage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _pictureImages = [[NSMutableArray alloc] init];
        _pictureViews = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    [_layout release];
    [_nameLabel release];
    [_areaLabel release];
    [_descLabel release];
    [_followLabel release];
    [_stockLabel release];
    [_scrollView release];
    [_pictureImages release];
    [_pictureViews release];
    [_actualAreaLabel release];
    [_actualAreaFieldLabel release];
    [_prevButton release];
    [_nextButton release];
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
                                             selector:@selector(willCloseGallery:)
                                                 name:@"ClosePictureGallery"
                                               object:nil];
}

- (void)viewDidUnload
{
    [self setLayout:nil];
    [self setNameLabel:nil];
    [self setAreaLabel:nil];
    [self setDescLabel:nil];
    [self setFollowLabel:nil];
    [self setStockLabel:nil];
    [self setScrollView:nil];
    [self setActualAreaLabel:nil];
    [self setActualAreaFieldLabel:nil];
    [self setPrevButton:nil];
    [self setNextButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (void)setCurrentPage:(NSInteger)currentPage
{
    [self setCurrentPage:currentPage animated:NO];
}

- (void)setCurrentPage:(NSInteger)currentPage animated:(Boolean)animated
{
    CGPoint offset = CGPointMake(currentPage * self.scrollView.frame.size.width, 0);
    if (offset.x == self.scrollView.contentOffset.x) {
        [self loadPicture:currentPage];
        if (currentPage - 1 >= 0) {
            [self loadPicture:currentPage - 1];
        }
        
        if (currentPage + 1 < _pictureViews.count) {
            [self loadPicture:currentPage + 1];
        }
    } else {
        [self.scrollView setContentOffset:offset animated:animated];
    }
}

- (void)setLayout:(Layout *)layout
{
    if (layout == _layout) {
        return;
    }
    
    self.nameLabel.text = layout.name;
    CGFloat area = layout.floorArea.floatValue + layout.poolArea.floatValue;
    self.areaLabel.text = [NSString stringWithFormat:@"%i㎡", (NSInteger)roundf(area)];
    self.descLabel.text = layout.desc;
    
    if (layout.actualArea.floatValue == 0 || layout.actualArea.floatValue == area) {
        self.actualAreaLabel.hidden = YES;
        self.actualAreaFieldLabel.hidden = YES;
    } else {
        self.actualAreaLabel.hidden = NO;
        self.actualAreaFieldLabel.hidden = NO;
        self.actualAreaLabel.text = [NSString stringWithFormat:@"%i㎡", layout.actualArea.intValue];
    }
    
    NSArray *followers = [layout valueForKey:@"followers"];
    self.followLabel.text = [NSString stringWithFormat:@"%i", followers.count];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.status == 1"];
    NSSet *stockHouses = [layout.houses filteredSetUsingPredicate:predicate];
    self.stockLabel.text = [NSString stringWithFormat:@"%i", stockHouses.count];
    
    for (id pictureView in _pictureViews) {
        if (pictureView != [NSNull null]) {
            [pictureView removeFromSuperview];
        }
    }
    [_pictureViews removeAllObjects];
    [_pictureImages removeAllObjects];
    
    NSString *documentPath = [[[EstateConsultantUtils sharedUtils] documentsURL] path];
    NSString *layoutPath = [documentPath stringByAppendingFormat:@"/layout/layout-%@", layout.layoutID];
    NSArray *picNames = [layout.pics componentsSeparatedByString:@";"];
    NSInteger index = 0;
    for (NSString *picName in picNames) {
        NSString *picPath = [layoutPath stringByAppendingPathComponent:picName];
        [_pictureImages addObject:picPath];
        [_pictureViews addObject:[NSNull null]];
        index++;
    }
    
    [self.scrollView setContentSize:CGSizeMake(index * 702, 624)];
    
    [self setCurrentPage:0];
    [self refreshNavButtons];
    
    [_layout release];
    _layout = [layout retain];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger page = round(self.scrollView.contentOffset.x / self.scrollView.frame.size.width);
    if (page < 0) {
        page = 0;
    } else if (page + 1 > _pictureViews.count) {
        page = _pictureViews.count - 1;
    }
    
    NSMutableIndexSet *indexSet = [[NSMutableIndexSet alloc] init];
    NSMutableArray *nullObjects = [[NSMutableArray alloc] init];
    NSInteger index = 0;
    for (id object in _pictureViews) {
        if ((index > page + 1 || index < page - 1) && object != [NSNull null]) {
            [(UIImageView *)object removeFromSuperview];
            [indexSet addIndex:index];
            [nullObjects addObject:[NSNull null]];
        }
        
        index++;
    }
    [_pictureViews replaceObjectsAtIndexes:indexSet withObjects:nullObjects];
    [indexSet release];
    [nullObjects release];
    
    [self loadPicture:page];
    
    if (page - 1 >= 0) {
        [self loadPicture:page - 1];
    }
    
    if (page + 1 < _pictureViews.count) {
        [self loadPicture:page + 1];
    }
    
    if (page != _currentPage) {
        _currentPage = page;
        [self refreshNavButtons];
    }
}

- (void)refreshNavButtons
{
    if (self.currentPage == 0) {
        self.prevButton.hidden = YES;
        self.nextButton.hidden = NO;
    } else if (self.currentPage == _pictureViews.count - 1) {
        self.prevButton.hidden = NO;
        self.nextButton.hidden = YES;
    } else {
        self.prevButton.hidden = NO;
        self.nextButton.hidden = NO;
    }
}

- (void)loadPicture:(NSInteger)page
{
    if ([_pictureViews objectAtIndex:page] != [NSNull null]) {
        return;
    }
    
    UIImage *picImage = [[UIImage alloc] initWithContentsOfFile:[_pictureImages objectAtIndex:page]];
    UIImageView *picImageView = [[UIImageView alloc] initWithImage:picImage];
    CGFloat pageWidth = CGRectGetWidth(self.scrollView.frame);
    CGFloat pageHeight = CGRectGetHeight(self.scrollView.frame);
    CGFloat width = pageWidth - 60;
    CGFloat height = pageHeight - 60;
    if (picImage.size.width / picImage.size.height > width / height) {
        height = width * picImage.size.height / picImage.size.width;
    } else {
        width = picImage.size.width * height / picImage.size.height;
    }
    
    CGFloat originX = (pageWidth - width) / 2 + page * pageWidth;
    CGFloat originY = (pageHeight - height) / 2;
    picImageView.frame = CGRectMake(originX, originY, width, height);
    picImageView.contentMode = UIViewContentModeScaleAspectFit;
    picImageView.userInteractionEnabled = YES;
    picImageView.layer.borderWidth = 1.0f;
    picImageView.layer.borderColor = [[UIColor whiteColor] CGColor];
    picImageView.layer.shadowRadius = 8;
    picImageView.layer.shadowColor = [[UIColor blackColor] CGColor];
    picImageView.layer.shadowOpacity = 0.35;
    picImageView.layer.shadowOffset = CGSizeMake(0, 2);
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(showGallery:)];
    [picImageView addGestureRecognizer:tapGesture];
    [tapGesture release];
    
    [self.scrollView addSubview:picImageView];
    [picImage release];
    [picImageView release];
    
    [_pictureViews replaceObjectAtIndex:page withObject:picImageView];
}

- (IBAction)showPrevPicture:(id)sender {
    if (self.currentPage > 0) {
        [self setCurrentPage:self.currentPage - 1 animated:YES];
    }
}

- (IBAction)showNextPicture:(id)sender {
    if (self.currentPage < _pictureViews.count - 1) {
        [self setCurrentPage:self.currentPage + 1 animated:YES];
    }
}

- (void)showGallery:(UIGestureRecognizer *)gesture
{
    UIImageView *picImageView = (UIImageView *)gesture.view;
    
    UIApplication *application = [UIApplication sharedApplication];
    EstateConsultantAppDelegate *appDelegate = (EstateConsultantAppDelegate *)[application delegate];
    UIViewController *rootController = appDelegate.window.rootViewController.modalViewController;
        
    UIView *maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 748)];
    maskView.backgroundColor = [UIColor blackColor];
    maskView.alpha = 0;
    [rootController.view addSubview:maskView];
    [maskView release];
    
    UIImageView *proxyImageView = [[UIImageView alloc] initWithImage:picImageView.image];
    proxyImageView.frame = [self.scrollView convertRect:picImageView.frame toView:rootController.view];
    proxyImageView.contentMode = UIViewContentModeScaleAspectFit;
    [rootController.view addSubview:proxyImageView];
    [proxyImageView release];
        
    [UIView animateWithDuration:0.3
                     animations:^{
                         proxyImageView.frame = CGRectMake(0, 0, 1024, 748);
                         maskView.alpha = 1;
                     }
                     completion:^(BOOL fninished){
                         PictureGalleryController *galleryController = [[PictureGalleryController alloc] initWithNibName:@"PictureGalleryController"
                                                                                                                  bundle:nil];                         
                         galleryController.pictures = _pictureImages;
                         galleryController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
                         
                         [rootController presentModalViewController:galleryController
                                                 animated:NO];
                         
                         galleryController.currentPage = self.currentPage;
                         [galleryController release];
                         
                         [proxyImageView removeFromSuperview];
                         [maskView removeFromSuperview];                         
                     }];
}

- (void)willCloseGallery:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSInteger page = [[userInfo valueForKey:@"page"] intValue];
    [self setCurrentPage:page];
    
    UIImageView *picImageView = [_pictureViews objectAtIndex:page];
    self.scrollView.contentOffset = CGPointMake(page * CGRectGetWidth(self.scrollView.frame), 0);
    
    UIApplication *application = [UIApplication sharedApplication];
    EstateConsultantAppDelegate *appDelegate = (EstateConsultantAppDelegate *)[application delegate];
    UIViewController *rootController = appDelegate.window.rootViewController.modalViewController;
    
    UIView *maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 748)];
    maskView.backgroundColor = [UIColor blackColor];
    [rootController.view addSubview:maskView];
    [maskView release];
    
    UIImageView *proxyImageView = [[UIImageView alloc] initWithImage:picImageView.image];
    proxyImageView.frame = CGRectMake(0, 0, 1024, 748);
    proxyImageView.contentMode = UIViewContentModeScaleAspectFit;
    [rootController.view addSubview:proxyImageView];
    [proxyImageView release];
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         maskView.alpha = 0;
                         proxyImageView.frame = [self.scrollView convertRect:picImageView.frame toView:rootController.view];
                     }
                     completion:^(BOOL finished){
                         [maskView removeFromSuperview];
                         [proxyImageView removeFromSuperview];
                     }];
    
}

@end
