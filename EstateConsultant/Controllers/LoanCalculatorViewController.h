//
//  LoanCalculatorViewController.h
//  EstateConsultant
//
//  Created by farthinker on 4/13/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataProvider.h"
#import "LayoutViewController.h"

@interface LoanCalculatorViewController : UIViewController <UITextFieldDelegate> {
    NSArray *_loanRateInfo;
    NSInteger _totalPrice;
}

@property (nonatomic, retain) House *house;
@property (nonatomic, retain) Client *client;
@property (nonatomic, retain) IBOutlet UILabel *totalLabel;
@property (nonatomic, retain) IBOutlet UISegmentedControl *paymentType;
@property (nonatomic, retain) IBOutlet UISegmentedControl *loanRate;
@property (nonatomic, retain) IBOutlet UISegmentedControl *discountRate;
@property (nonatomic, retain) IBOutlet UITextField *downPayment;
@property (nonatomic, retain) IBOutlet UITextField *loanPeriod;
@property (nonatomic, retain) IBOutlet UILabel *resultLabel;
@property (nonatomic, assign) LayoutViewController *layoutController;

- (IBAction)calculateLoan:(id)sender;

- (void)calculateMonthlyPayment;

@end
