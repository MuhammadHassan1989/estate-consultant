//
//  HouseListViewController.h
//  EstateConsultant
//
//  Created by farthinker on 4/13/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataProvider.h"
#import "LayoutViewController.h"
#import "LoanCalculatorViewController.h"


@interface HouseListViewController : UIViewController {
    NSMutableArray *_houseViews;
    LoanCalculatorViewController *_calcController;
}

@property (nonatomic, retain) Client *client;
@property (nonatomic, retain) Position *position;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, assign) LayoutViewController *layoutController;

- (IBAction)closeHouseList:(id)sender;

@end
