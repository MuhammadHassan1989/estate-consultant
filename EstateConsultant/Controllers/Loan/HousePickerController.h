//
//  HousePickerController.h
//  EstateConsultant
//
//  Created by farthinker on 6/12/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoanCalculatorController.h"
#import "DataProvider.h"


@interface HousePickerController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    Position *_position;
    UITableView *_tableView;
    LoanCalculatorController *_calculatorController;
    UIPopoverController *_parentPopover;
    NSArray *_houses;
}

@property (nonatomic, retain) Position *position;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, assign) LoanCalculatorController *calculatorController;
@property (nonatomic, assign) UIPopoverController *parentPopover;

- (void)selectHouse:(House *)house animated:(Boolean)animated;

@end
