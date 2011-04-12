//
//  LayoutPictureView.m
//  EstateConsultant
//
//  Created by farthinker on 4/12/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import "LayoutPictureView.h"
#import "EstateConsultantUtils.h"


@implementation LayoutPictureView

@synthesize layout = _layout;
@synthesize layoutPicsScrollView = _layoutPicsScrollView;
@synthesize layoutPicsPager = _layoutPicsPager;
@synthesize navArrowLeft = _navArrowLeft;
@synthesize navArrowRight = _navArrowRight;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
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
    [_layoutPicsScrollView release];
    [_layoutPicsPager release];
    [_navArrowLeft release];
    [_navArrowRight release];
    [_layout release];
    [super dealloc];
}

- (void)setLayout:(Layout *)layout
{
    NSString *documentsPath = [[[EstateConsultantUtils sharedUtils] documentsURL] path];
    NSString *pathComponent = [NSString stringWithFormat:@"layout/layout-%i", layout.layoutID.intValue];
    NSString *layoutPath = [documentsPath stringByAppendingPathComponent:pathComponent];
    CGRect frame = [self.layoutPicsScrollView frame];
    NSMutableArray *picNames = [NSMutableArray arrayWithArray:[layout.pics componentsSeparatedByString:@";"]];
    [picNames insertObject:[NSString stringWithFormat:@"layout-%i.jpg", layout.layoutID.intValue] atIndex:0];
    
    if (_layoutPics != nil) {
        for (UIImageView *pic in _layoutPics) {
            [pic removeFromSuperview];
        }
        [_layoutPics release];
        _layoutPics = nil;
    }
    _layoutPics = [[NSMutableArray alloc] initWithCapacity:picNames.count];
    
    NSInteger index = 0;
    for (NSString *picName in picNames) {
        NSString *picPath = [layoutPath stringByAppendingPathComponent:picName];
        UIImage *picImage = [[UIImage alloc] initWithContentsOfFile:picPath];
        UIImageView *picView = [[UIImageView alloc] initWithImage:picImage];
        [picView setFrame:CGRectMake(index * frame.size.width + 20, 20, frame.size.width - 40, frame.size.height - 20)];
        [picView setContentMode:UIViewContentModeScaleAspectFit];
        [self.layoutPicsScrollView addSubview:picView];
        [_layoutPics addObject:picView];
        
        [picImage release];
        [picView release];
        index++;
    }
    
    [self.layoutPicsPager setNumberOfPages:index];
    [self.layoutPicsPager setCurrentPage:0];
    [self.navArrowLeft setHidden:YES];
    [self.layoutPicsScrollView setContentSize:CGSizeMake(index * frame.size.width, frame.size.height)];
    
    if (_layout != nil) {
        [_layout release];
        _layout = nil;
    }
    _layout = [layout retain];
}

- (void)awakeFromNib
{
    UITapGestureRecognizer *tapLeft = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapLayoutPicsNav:)];
    [self.navArrowLeft addGestureRecognizer:tapLeft];
    [tapLeft release];
    
    UITapGestureRecognizer *tapRight = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapLayoutPicsNav:)];
    [self.navArrowRight addGestureRecognizer:tapRight];
    [tapRight release];
}

- (void)tapLayoutPicsNav:(UITapGestureRecognizer *)gesture
{
    UIImageView *view = (UIImageView *)gesture.view;
    NSInteger currentPage = [self.layoutPicsPager currentPage];
    
    if (view == self.navArrowLeft) {
        currentPage = currentPage - 1;
    } else if ( view == self.navArrowRight) {
        currentPage = currentPage + 1;
    }
    
    [self.layoutPicsPager setCurrentPage:currentPage];
    [self.layoutPicsScrollView setContentOffset:CGPointMake(currentPage * self.layoutPicsScrollView.frame.size.width, 0) animated:YES];
    
    if (currentPage == 0) {
        [self.navArrowLeft setHidden:YES];
        [self.navArrowRight setHidden:NO];
    } else if (currentPage + 1 == self.layoutPicsPager.numberOfPages) {
        [self.navArrowLeft setHidden:NO];
        [self.navArrowRight setHidden:YES];
    } else {
        [self.navArrowLeft setHidden:NO];
        [self.navArrowRight setHidden:NO];
    }
}

- (void)layoutSubviews
{
    NSInteger index = 0;
    CGRect picsFrame = [self.layoutPicsScrollView frame];
    for (UIImageView *pic in _layoutPics) {
        [pic setFrame:CGRectMake(index * picsFrame.size.width + 20, 20, picsFrame.size.width - 40, picsFrame.size.height - 20)];
        index++;
    }
    
    NSInteger currentPage = [_layoutPicsPager currentPage];
    [self.layoutPicsScrollView setContentOffset:CGPointMake(currentPage * picsFrame.size.width, 0) animated:YES];
}

@end
