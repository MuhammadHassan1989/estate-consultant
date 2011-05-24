//
//  LayoutDetailController.m
//  EstateConsultant
//
//  Created by farthinker on 5/17/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import "LayoutDetailController.h"
#import "PictureGalleryController.h"
#import "EstateConsultantUtils.h"
#import "EstateConsultantAppDelegate.h"

@implementation LayoutDetailController

@synthesize layout = _layout;
@synthesize nameLabel = _nameLabel;
@synthesize areaLabel = _areaLabel;
@synthesize descLabel = _descLabel;
@synthesize followLabel = _followLabel;
@synthesize stockLabel = _stockLabel;
@synthesize scrollView = _scrollView;
@synthesize pageControl = _pageControl;

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
    [_layout release];
    [_nameLabel release];
    [_areaLabel release];
    [_descLabel release];
    [_followLabel release];
    [_stockLabel release];
    [_scrollView release];
    [_pageControl release];
    [_pictureImages release];
    [_pictureViews release];
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
    [self setPageControl:nil];
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
        self.scrollView.contentOffset = offset;
    }
}

- (NSInteger)currentPage
{
    NSInteger page = round(self.scrollView.contentOffset.x / self.scrollView.frame.size.width);
    if (page < 0) {
        page = 0;
    } else if (page + 1 > _pictureViews.count) {
        page = _pictureViews.count - 1;
    }
    return page;
}

- (void)setLayout:(Layout *)layout
{
    if (layout == _layout) {
        return;
    }
    
    self.nameLabel.text = layout.name;
    self.areaLabel.text = [NSString stringWithFormat:@"%@㎡", layout.area];
    self.descLabel.text = layout.desc;
    
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
    [self.pageControl setNumberOfPages:index];
    
    if (index > 0) {
        [self setCurrentPage:0];
    }
    
    [_layout release];
    _layout = [layout retain];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger currentPage = self.currentPage;
    
    NSMutableIndexSet *indexSet = [[NSMutableIndexSet alloc] init];
    NSMutableArray *nullObjects = [[NSMutableArray alloc] init];
    NSInteger index = 0;
    for (id object in _pictureViews) {
        if ((index > currentPage + 1 || index < currentPage - 1) && object != [NSNull null]) {
            [(UIImageView *)object removeFromSuperview];
            [indexSet addIndex:index];
            [nullObjects addObject:[NSNull null]];
        }
        
        index++;
    }
    [_pictureViews replaceObjectsAtIndexes:indexSet withObjects:nullObjects];
    [indexSet release];
    [nullObjects release];
    
    [self loadPicture:currentPage];
    
    if (currentPage - 1 >= 0) {
        [self loadPicture:currentPage - 1];
    }
    
    if (currentPage + 1 < _pictureViews.count) {
        [self loadPicture:currentPage + 1];
    }
    
    if (currentPage != self.pageControl.currentPage) {
        self.pageControl.currentPage = currentPage;
    }
}

- (void)loadPicture:(NSInteger)page
{
    if ([_pictureViews objectAtIndex:page] != [NSNull null]) {
        return;
    }
    
    UIImage *picImage = [[UIImage alloc] initWithContentsOfFile:[_pictureImages objectAtIndex:page]];
    UIImageView *picImageView = [[UIImageView alloc] initWithImage:picImage];
    picImageView.frame = CGRectMake(20 + page * 702, 20, 662, 564);
    picImageView.contentMode = UIViewContentModeScaleAspectFit;
    picImageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(showGallery:)];
    [picImageView addGestureRecognizer:tapGesture];
    [tapGesture release];
    
    [self.scrollView addSubview:picImageView];
    [picImage release];
    [picImageView release];
    
    [_pictureViews replaceObjectAtIndex:page withObject:picImageView];
}

- (void)showGallery:(UIGestureRecognizer *)gesture
{
    UIImageView *picImageView = (UIImageView *)gesture.view;
    
    EstateConsultantAppDelegate *appDelegate = (EstateConsultantAppDelegate *)[[UIApplication sharedApplication] delegate];
    UIViewController *rootController = appDelegate.window.rootViewController;
        
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
                         proxyImageView.frame = CGRectMake(20, 20, 984, 708);
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
    self.scrollView.contentOffset = CGPointMake(page * 702, 0);
        
    EstateConsultantAppDelegate *appDelegate = (EstateConsultantAppDelegate *)[[UIApplication sharedApplication] delegate];
    UIViewController *rootController = appDelegate.window.rootViewController;
    
    UIView *maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 748)];
    maskView.backgroundColor = [UIColor blackColor];
    [rootController.view addSubview:maskView];
    [maskView release];
    
    UIImageView *proxyImageView = [[UIImageView alloc] initWithImage:picImageView.image];
    proxyImageView.frame = CGRectMake(20, 20, 984, 708);
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
