//
//  ClientPickerController.h
//  EstateConsultant
//
//  Created by farthinker on 5/20/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataProvider.h"
#import "LoanCalculatorController.h"


@interface ClientPickerController : UITableViewController {
    NSArray *_clients;
    NSArray *_filteredClients;
    UIPopoverController *_parentPopover;
    LoanCalculatorController *_calculatorController;
}

@property (nonatomic, retain) NSArray *clients;
@property (nonatomic, assign) UIPopoverController *parentPopover;
@property (nonatomic, assign) LoanCalculatorController *calculatorController;

@end
