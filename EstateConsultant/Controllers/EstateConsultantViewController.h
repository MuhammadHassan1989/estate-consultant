//
//  EstateConsultantViewController.h
//  EstateConsultant
//
//  Created by farthinker on 5/28/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataProvider.h"

@class StackScrollViewController, ClientViewController, LayoutViewController, StockViewController, LoanCalculatorController, ClientCreateController;


@interface EstateConsultantViewController : UIViewController <UIPopoverControllerDelegate> {
    UIButton *_clientButton;
    UIButton *_layoutButton;
    UIButton *_stockButton;
    UIButton *_calculatorButton;
    UIImageView *_consultantAvatar;
    UIView *_avatarShadow;
    UIButton *_batchButton;
    UILabel *_consultantNameLabel;
    Consultant *_consultant;
    Batch *_batch;
    ClientViewController *_clientViewController;
    LayoutViewController *_layoutViewController;
    StockViewController *_stockViewController;
    LoanCalculatorController *_loanCalculatorController;
    UIViewController *_currentController;
    UIButton *_currentButton;
    UIView *_maskView;
    ClientCreateController *_clientCreateController;
}

@property (nonatomic, retain) Consultant *consultant;
@property (nonatomic, retain) Batch *batch;
@property (nonatomic, retain) IBOutlet UIButton *clientButton;
@property (nonatomic, retain) IBOutlet UIButton *layoutButton;
@property (nonatomic, retain) IBOutlet UIButton *stockButton;
@property (nonatomic, retain) IBOutlet UIButton *calculatorButton;
@property (nonatomic, retain) IBOutlet UIImageView *consultantAvatar;
@property (nonatomic, retain) IBOutlet UIView *avatarShadow;
@property (nonatomic, retain) IBOutlet UIButton *batchButton;
@property (nonatomic, retain) IBOutlet UILabel *consultantNameLabel;

- (IBAction)selectMenu:(id)sender;
- (IBAction)createClient:(id)sender;
- (void)cancelCreateClient;
- (IBAction)selectBatch:(id)sender;
- (IBAction)logout:(id)sender;

@end
