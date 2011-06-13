//
//  PositionPickerController.h
//  EstateConsultant
//
//  Created by farthinker on 6/12/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoanCalculatorController.h"
#import "DataProvider.h"

@interface PositionPickerController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    Batch *_batch;
    NSArray *_buildings;
    NSMutableArray *_positionArray;
    UITableView *_tableView;
    LoanCalculatorController *_calculatorController;
    UIPopoverController *_parentPopover;
}

@property (nonatomic, retain) Batch *batch;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, assign) LoanCalculatorController *calculatorController;
@property (nonatomic, assign) UIPopoverController *parentPopover;

- (void)selectPosition:(Position *)position animated:(Boolean)animated;

@end
