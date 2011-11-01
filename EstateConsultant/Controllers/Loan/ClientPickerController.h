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


@interface ClientPickerController : UIViewController <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource> {
    NSMutableArray *_clients;
    Consultant *_consultant;
    NSArray *_dataSource;
    UITableView *_tableView;
    UITextField *_searchField;
    UIImageView *_searchFieldBackground;
    UIPopoverController *_parentPopover;
    LoanCalculatorController *_calculatorController;
}

@property (nonatomic, retain) Consultant *consultant;
@property (nonatomic, assign) UIPopoverController *parentPopover;
@property (nonatomic, assign) LoanCalculatorController *calculatorController;
@property (nonatomic, retain) NSArray *dataSource;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet UITextField *searchField;
@property (nonatomic, retain) IBOutlet UIImageView *searchFieldBackground;

- (void)filterClients:(NSString *)searchString;
- (void)selectClient:(Client *)client animated:(Boolean)animated;
- (IBAction)textFieldDidChange:(UITextField *)sender;

@end
