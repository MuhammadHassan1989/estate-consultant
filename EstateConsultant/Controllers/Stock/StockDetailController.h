//
//  StockDetailController.h
//  EstateConsultant
//
//  Created by farthinker on 5/18/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataProvider.h"

@interface StockDetailController : UIViewController {
    Position *_position;
    UILabel *_layoutNameLabel;
    UILabel *_layoutAreaLabel;
    UILabel *_layoutActualAreaFieldLabel;
    UILabel *_layoutActualAreaLabel;
    UILabel *_layoutDescLabel;
    UIScrollView *_scrollView;
    NSArray *_houses;
    NSMutableArray *_houseItemViews;
}

@property (nonatomic, retain) Position *position;
@property (nonatomic, retain) IBOutlet UILabel *layoutNameLabel;
@property (nonatomic, retain) IBOutlet UILabel *layoutAreaLabel;
@property (nonatomic, retain) IBOutlet UILabel *layoutActualAreaFieldLabel;
@property (nonatomic, retain) IBOutlet UILabel *layoutActualAreaLabel;
@property (nonatomic, retain) IBOutlet UILabel *layoutDescLabel;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;


@end
