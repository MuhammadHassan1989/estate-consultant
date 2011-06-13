//
//  PictureGalleryController.m
//  EstateConsultant
//
//  Created by farthinker on 5/22/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import "PictureGalleryController.h"
#import "LayoutDetailController.h"


@implementation PictureGalleryController

@synthesize pictures = _pictures;
@synthesize scrollView = _scrollView;
@synthesize currentPage = _currentPage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _pictureViews = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [_pictures release];
    [_scrollView release];
    [_pictureViews release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
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
    }
}

- (void)loadPicture:(NSInteger)page
{
    if ([_pictureViews objectAtIndex:page] != [NSNull null]) {
        return;
    }
    
    UIImage *picImage = [[UIImage alloc] initWithContentsOfFile:[self.pictures objectAtIndex:page]];
    UIImageView *picImageView = [[UIImageView alloc] initWithImage:picImage];
    picImageView.frame = CGRectMake(20 + page * 1064, 0, 1024, 748);
    picImageView.contentMode = UIViewContentModeScaleAspectFit;
    picImageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(closeGallery:)];
    [picImageView addGestureRecognizer:tapGesture];
    [tapGesture release];
    
    [self.scrollView addSubview:picImageView];
    [picImage release];
    [picImageView release];
        
    [_pictureViews replaceObjectAtIndex:page withObject:picImageView];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    for (id object in self.pictures) {
        [_pictureViews addObject:[NSNull null]];
    }

    [self.scrollView setContentSize:CGSizeMake(self.pictures.count * 1064, 748)];
}

- (void)viewDidUnload
{
    [self setPictures:nil];
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

- (void)closeGallery:(UIGestureRecognizer *)gesture
{
    NSDictionary *userInfo = [[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInteger:self.currentPage], @"page", nil];
        
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ClosePictureGallery" object:self userInfo:userInfo];
    [userInfo release];
    
    [self dismissModalViewControllerAnimated:NO];
}

@end
