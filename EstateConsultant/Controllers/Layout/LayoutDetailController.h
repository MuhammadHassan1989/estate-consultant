//
//  LayoutDetailController.h
//  EstateConsultant
//
//  Created by farthinker on 5/17/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataProvider.h"


@interface LayoutDetailController : UIViewController <UIScrollViewDelegate> {
    Layout *_layout;
    UILabel *_nameLabel;
    UILabel *_areaLabel;
    UILabel *_descLabel;
    UILabel *_followLabel;
    UILabel *_stockLabel;
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
    NSMutableArray *_pictureImages;
    NSMutableArray *_pictureViews;
}

@property (nonatomic, retain) Layout *layout;
@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UILabel *areaLabel;
@property (nonatomic, retain) IBOutlet UILabel *descLabel;
@property (nonatomic, retain) IBOutlet UILabel *followLabel;
@property (nonatomic, retain) IBOutlet UILabel *stockLabel;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UIPageControl *pageControl;
@property (nonatomic, assign) NSInteger currentPage;

- (void)loadPicture:(NSInteger)page;

@end
