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
    UILabel *_actualAreaLabel;
    UILabel *_actualAreaFieldLabel;
    UILabel *_descLabel;
    UILabel *_followLabel;
    UILabel *_stockLabel;
    UIScrollView *_scrollView;
    UIButton *_prevButton;
    UIButton *_nextButton;
    NSMutableArray *_pictureImages;
    NSMutableArray *_pictureViews;
    NSInteger _currentPage;
}

@property (nonatomic, retain) Layout *layout;
@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UILabel *areaLabel;
@property (nonatomic, retain) IBOutlet UILabel *actualAreaLabel;
@property (nonatomic, retain) IBOutlet UILabel *actualAreaFieldLabel;
@property (nonatomic, retain) IBOutlet UILabel *descLabel;
@property (nonatomic, retain) IBOutlet UILabel *followLabel;
@property (nonatomic, retain) IBOutlet UILabel *stockLabel;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UIButton *prevButton;
@property (nonatomic, retain) IBOutlet UIButton *nextButton;
@property (nonatomic, assign) NSInteger currentPage;

- (void)setCurrentPage:(NSInteger)currentPage animated:(Boolean)animated;
- (void)loadPicture:(NSInteger)page;
- (IBAction)showPrevPicture:(id)sender;
- (IBAction)showNextPicture:(id)sender;
- (void)refreshNavButtons;

@end
