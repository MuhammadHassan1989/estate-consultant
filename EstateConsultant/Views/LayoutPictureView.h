//
//  LayoutPictureView.h
//  EstateConsultant
//
//  Created by farthinker on 4/12/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataProvider.h"


@interface LayoutPictureView : UIView {
    NSMutableArray *_layoutPics;
}

@property (nonatomic, retain) Layout *layout;
@property (nonatomic, retain) IBOutlet UIScrollView *layoutPicsScrollView;
@property (nonatomic, retain) IBOutlet UIPageControl *layoutPicsPager;
@property (nonatomic, retain) IBOutlet UIImageView *navArrowLeft;
@property (nonatomic, retain) IBOutlet UIImageView *navArrowRight;


@end
