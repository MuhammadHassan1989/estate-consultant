//
//  LoanCalculatorViewController.h
//  EstateConsultant
//
//  Created by farthinker on 4/13/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataProvider.h"
#import "PopoverPickerController.h"

@interface LoanCalculatorController : UIViewController <UITextFieldDelegate, UIPopoverControllerDelegate, PopoverPickerDelegate> {
    Position *_position;
    House *_house;
    Client *_client;
    UILabel *_totalLabel;
    UISegmentedControl *_paymentType;
    UISegmentedControl *_loanRate;
    UISegmentedControl *_discountRate;
    UITextField *_downPayment;
    UITextField *_loanPeriod;
    UILabel *_resultLabel;
    UIButton *_positionButton;
    UIButton *_floorButton;
    UIButton *_clientButton;
    UIView *_clientView;
    UILabel *_clientLabel;
    NSArray *_loanRateInfo;
    NSInteger _totalPrice;
}

@property (nonatomic, retain) Position *position;
@property (nonatomic, retain) House *house;
@property (nonatomic, retain) Client *client;
@property (nonatomic, retain) IBOutlet UILabel *totalLabel;
@property (nonatomic, retain) IBOutlet UISegmentedControl *paymentType;
@property (nonatomic, retain) IBOutlet UISegmentedControl *loanRate;
@property (nonatomic, retain) IBOutlet UISegmentedControl *discountRate;
@property (nonatomic, retain) IBOutlet UITextField *downPayment;
@property (nonatomic, retain) IBOutlet UITextField *loanPeriod;
@property (nonatomic, retain) IBOutlet UILabel *resultLabel;
@property (nonatomic, retain) IBOutlet UIButton *positionButton;
@property (nonatomic, retain) IBOutlet UIButton *floorButton;
@property (nonatomic, retain) IBOutlet UIButton *clientButton;
@property (nonatomic, retain) IBOutlet UIView *clientView;
@property (nonatomic, retain) IBOutlet UILabel *clientLabel;

- (IBAction)pickClient:(UIButton *)sender;
- (IBAction)pickPosition:(UIButton *)sender;
- (IBAction)pickFloor:(UIButton *)sender;
- (IBAction)calculateLoan:(id)sender;
- (IBAction)closeCalculator:(id)sender;
- (IBAction)cancelClient:(id)sender;

- (void)calculateMonthlyPayment;
- (void)showPicker:(UIView *)trigger withDataSource:(NSArray *)dataSource andSelectedObject:(id)object;
- (void)startTwinkle:(UIView *)view;
- (void)stopTwinkle:(UIView *)view;

@end
