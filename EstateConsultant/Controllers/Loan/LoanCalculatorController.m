//
//  LoanCalculatorViewController.m
//  EstateConsultant
//
//  Created by farthinker on 4/13/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import "LoanCalculatorController.h"
#import "EstateConsultantUtils.h"
#import "ClientPickerController.h"
#import "PositionPickerController.h"
#import "HousePickerController.h"
#import "DownPaymentInputView.h"
#import "NumberInputView.h"

@implementation LoanCalculatorController

@synthesize batch = _batch;
@synthesize consultant = _consultant;
@synthesize position = _position;
@synthesize client = _client;
@synthesize house = _house;
@synthesize totalLabel = _totalLabel;
@synthesize paymentType = _paymentType;
@synthesize loanRate = _loanRate;
@synthesize discountRate = _discountRate;
@synthesize downPayment = _downPayment;
@synthesize loanPeriod = _loanPeriod;
@synthesize resultLabel = _resultLabel;
@synthesize positionButton = _positionButton;
@synthesize floorButton = _floorButton;
@synthesize clientButton = _clientButton;
@synthesize clientView = _clientView;
@synthesize pickClientButton = _pickClientButton;
@synthesize cancelClientButton = _cancelClientButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [_batch release];
    [_consultant release];
    [_totalLabel release];
    [_paymentType release];
    [_loanRate release];
    [_discountRate release];
    [_downPayment release];
    [_loanPeriod release];
    [_resultLabel release];
    [_house release];
    [_client release];
    [_position release];
    [_loanRateInfo release];
    [_positionButton release];
    [_floorButton release];
    [_clientButton release];
    [_clientView release];
    [_pickClientButton release];
    [_cancelClientButton release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)setPosition:(Position *)position
{    
    if (position == nil) {
        [self.positionButton setTitle:@"轻击选择位置" forState:UIControlStateNormal];
        [self startTwinkle:self.positionButton];
    } else if (position != _position) {
        [self stopTwinkle:self.positionButton];
        NSString *positionString = [NSString stringWithFormat:@"%@号楼%@单元%@号", position.unit.building.number, position.unit.number, position.name];
        [self.positionButton setTitle:positionString forState:UIControlStateNormal];
    }
    
    [_position release];
    _position = [position retain];
}

- (void)setHouse:(House *)house
{    
    if (house == nil) {
        if (self.position == nil) {
            [self.floorButton setTitle:@"请先选择房源位置" forState:UIControlStateNormal];
        } else {
            [self.floorButton setTitle:@"轻击选择楼层" forState:UIControlStateNormal];
            [self startTwinkle:self.floorButton];
        }
        _totalPrice = 0;
    } else if (house != _house) {
        [self stopTwinkle:self.floorButton];
        NSString *floorText = [NSString stringWithFormat:@"%@楼", house.floor, house.num];
        [self.floorButton setTitle:floorText forState:UIControlStateNormal];
        _totalPrice = house.price.intValue;
    }
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@"###,###,###"];
    NSString *numberString = [numberFormatter stringFromNumber:[NSNumber numberWithInt:_totalPrice]];
    [self.totalLabel setText:[NSString stringWithFormat:@"%@ 元", numberString]];
    [numberFormatter release];
    
    [self calculateMonthlyPayment];
    
    [_house release];
    _house = [house retain];
}

- (void)setClient:(Client *)client
{    
    if (client == nil) {
        self.pickClientButton.hidden = NO;
        self.clientView.hidden = YES;
        [self startTwinkle:self.pickClientButton];
    } else if (client != _client) {
        [self stopTwinkle:self.pickClientButton];
        self.pickClientButton.hidden = YES;
        self.clientView.hidden = NO;
        
        NSString *format;
        if (client.sex.intValue == 1) {
            format = @"%@先生";
        } else {
            format = @"%@女士";
        }
        
        NSString *buttonText = [NSString stringWithFormat:format, client.name];
        [self.clientButton setTitle:buttonText forState:UIControlStateNormal];
        
        CGRect buttonFrame = self.clientButton.frame;
        CGFloat buttonWidth = [buttonText sizeWithFont:self.clientButton.titleLabel.font].width + 60;
        buttonFrame.size.width = buttonWidth;
        self.clientButton.frame = buttonFrame;
        
        CGRect cancelFrame = self.cancelClientButton.frame;
        cancelFrame.origin.x = CGRectGetMaxX(buttonFrame) - CGRectGetWidth(cancelFrame);
        self.cancelClientButton.frame = cancelFrame;
        
        UILabel *label = (UILabel *)[self.clientView viewWithTag:1];
        CGRect labelFrame = label.frame;
        labelFrame.origin.x = CGRectGetMaxX(buttonFrame);
        label.frame = labelFrame;
    }
    
    [_client release];
    _client = [client retain];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *documentPath = [[[EstateConsultantUtils sharedUtils] documentsURL] path];
    NSString *ratePath = [documentPath stringByAppendingPathComponent:@"LoanRate.plist"];
	_loanRateInfo = [[NSArray alloc] initWithContentsOfFile:ratePath];
    
    UIImage *defaultBackground = [[UIImage imageNamed:@"calculator-segmented.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:0];
    UIImage *selectedBackground = [[UIImage imageNamed:@"calculator-segmented-selected.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:0];
    self.paymentType.defaultBackground = defaultBackground;
    self.paymentType.selectedBackground = selectedBackground;
    self.paymentType.titleFont = [UIFont fontWithName:@"STHeitiSC-Medium" size:16];
    self.paymentType.titleColor = [UIColor whiteColor];
    self.paymentType.titleShadowColor = [UIColor colorWithWhite:0 alpha:0.75];
    self.paymentType.selectedTitleShadowColor = [UIColor colorWithWhite:1.0 alpha:0.75];
    self.paymentType.selectedTitleColor = [UIColor colorWithWhite:0.35 alpha:1.0];
    self.paymentType.titleShadowOffset = CGSizeMake(0, -1);
    self.paymentType.selectedTitleShadowOffset = CGSizeMake(0, 2);
    self.paymentType.contentEdgeInsets = UIEdgeInsetsMake(-5, 0, 0, 0);
    self.paymentType.selectedContentEdgeInsets = UIEdgeInsetsMake(3, 0, 0, 0);
    self.paymentType.items = [NSArray arrayWithObjects:@"商业贷款", @"公积金", nil];
    self.paymentType.selectedIndex = 0;
    
    self.loanRate.defaultBackground = defaultBackground;
    self.loanRate.selectedBackground = selectedBackground;
    self.loanRate.titleFont = [UIFont fontWithName:@"STHeitiSC-Medium" size:16];
    self.loanRate.titleColor = [UIColor whiteColor];
    self.loanRate.titleShadowColor = [UIColor colorWithWhite:0 alpha:0.75];
    self.loanRate.selectedTitleColor = [UIColor colorWithWhite:0.35 alpha:1.0];
    self.loanRate.selectedTitleShadowColor = [UIColor colorWithWhite:1.0 alpha:0.75];
    self.loanRate.titleShadowOffset = CGSizeMake(0, -1);
    self.loanRate.selectedTitleShadowOffset = CGSizeMake(0, 2);
    self.loanRate.contentEdgeInsets = UIEdgeInsetsMake(-5, 0, 0, 0);
    self.loanRate.selectedContentEdgeInsets = UIEdgeInsetsMake(3, 0, 0, 0);
    self.loanRate.items = [NSArray arrayWithObjects:@"无", @"8.5折", @"1.1倍", nil];
    self.loanRate.selectedIndex = 0;

    self.discountRate.defaultBackground = defaultBackground;
    self.discountRate.selectedBackground = selectedBackground;
    self.discountRate.titleFont = [UIFont fontWithName:@"STHeitiSC-Medium" size:16];
    self.discountRate.titleColor = [UIColor whiteColor];
    self.discountRate.titleShadowColor = [UIColor colorWithWhite:0 alpha:0.75];
    self.discountRate.selectedTitleColor = [UIColor colorWithWhite:0.35 alpha:1.0];
    self.discountRate.selectedTitleShadowColor = [UIColor colorWithWhite:1.0 alpha:0.75];
    self.discountRate.titleShadowOffset = CGSizeMake(0, -1);
    self.discountRate.selectedTitleShadowOffset = CGSizeMake(0, 2);
    self.discountRate.contentEdgeInsets = UIEdgeInsetsMake(-5, 0, 0, 0);
    self.discountRate.selectedContentEdgeInsets = UIEdgeInsetsMake(3, 0, 0, 0);
    self.discountRate.items = [NSArray arrayWithObjects:@"无", @"1%", @"2%", @"3%", @"4%", @"5%", nil];
    self.discountRate.selectedIndex = 0;
        
    [self.downPayment setDelegate:self];
    [self.loanPeriod setDelegate:self];
    
    UIViewController *downPaymentInputController = [[UIViewController alloc] initWithNibName:@"DownPaymentInputView" bundle:nil];
    DownPaymentInputView *downPaymentInputView = (DownPaymentInputView *)downPaymentInputController.view;
    downPaymentInputView.textfield = self.downPayment;
    self.downPayment.inputView = downPaymentInputView;
    [downPaymentInputController release];
    
    UIViewController *numberInputController = [[UIViewController alloc] initWithNibName:@"NumberInputView" bundle:nil];
    NumberInputView *numberInputView = (NumberInputView *)numberInputController.view;
    numberInputView.textfield = self.loanPeriod;
    self.loanPeriod.inputView = numberInputView;
    [numberInputController release];
    
    UIImage *clientButtonBg = [UIImage imageNamed:@"calculator-button.png"];
    [self.clientButton setBackgroundImage:[clientButtonBg stretchableImageWithLeftCapWidth:20 topCapHeight:0] forState:UIControlStateNormal];
}

- (void)viewDidUnload
{
    [self setBatch:nil];
    [self setConsultant:nil];
    [self setTotalLabel:nil];
    [self setPaymentType:nil];
    [self setLoanRate:nil];
    [self setDiscountRate:nil];
    [self setDownPayment:nil];
    [self setLoanPeriod:nil];
    [self setResultLabel:nil];
    [self setHouse:nil];
    [self setClient:nil];
    [self setPosition:nil];
    [self setPositionButton:nil];
    [self setFloorButton:nil];
    [self setClientButton:nil];
    [self setClientView:nil];
    [self setPickClientButton:nil];
    [self setCancelClientButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (IBAction)pickClient:(UIButton *)sender {
    ClientPickerController *pickerController = [[ClientPickerController alloc] initWithNibName:@"ClientPickerController" bundle:nil];
    pickerController.consultant = self.consultant;
    pickerController.contentSizeForViewInPopover = CGSizeMake(320, 600);
    
    UIPopoverController *popoverController = [[UIPopoverController alloc] initWithContentViewController:pickerController];
    popoverController.delegate = self;
    pickerController.parentPopover = popoverController;
    pickerController.calculatorController = self;
    
    [popoverController presentPopoverFromRect:sender.frame
                                       inView:self.view
                     permittedArrowDirections:UIPopoverArrowDirectionLeft
                                     animated:YES];
    
    [pickerController release];
}

- (IBAction)changeClient:(UIButton *)sender {
    ClientPickerController *pickerController = [[ClientPickerController alloc] initWithNibName:@"ClientPickerController" bundle:nil];
    pickerController.consultant = self.consultant;
    pickerController.contentSizeForViewInPopover = CGSizeMake(320, 600);
    
    UIPopoverController *popoverController = [[UIPopoverController alloc] initWithContentViewController:pickerController];
    popoverController.delegate = self;
    pickerController.parentPopover = popoverController;
    pickerController.calculatorController = self;
    
    [popoverController presentPopoverFromRect:sender.frame
                                       inView:self.clientView
                     permittedArrowDirections:UIPopoverArrowDirectionLeft
                                     animated:YES];
    
    [pickerController selectClient:self.client animated:NO];
    [pickerController release];
}

- (IBAction)pickPosition:(UIButton *)sender {
    PositionPickerController *pickerController = [[PositionPickerController alloc] initWithNibName:@"PositionPickerController" bundle:nil];
    pickerController.batch = self.batch;
    pickerController.contentSizeForViewInPopover = CGSizeMake(320, 600);
    
    UIPopoverController *popoverController = [[UIPopoverController alloc] initWithContentViewController:pickerController];
    popoverController.delegate = self;
    pickerController.parentPopover = popoverController;
    pickerController.calculatorController = self;
    
    [popoverController presentPopoverFromRect:sender.frame
                                       inView:self.view
                     permittedArrowDirections:UIPopoverArrowDirectionLeft
                                     animated:YES];
    
    if (self.position != nil) {
        [pickerController selectPosition:self.position animated:NO];
    }
    
    [pickerController release];
}

- (IBAction)pickFloor:(UIButton *)sender {
    if (self.position == nil) {
        return;
    }
    
    HousePickerController *pickerController = [[HousePickerController alloc] initWithNibName:@"HousePickerController" bundle:nil];
    pickerController.position = self.position;
    pickerController.contentSizeForViewInPopover = CGSizeMake(320, 600);
    
    UIPopoverController *popoverController = [[UIPopoverController alloc] initWithContentViewController:pickerController];
    popoverController.delegate = self;
    pickerController.parentPopover = popoverController;
    pickerController.calculatorController = self;
    
    [popoverController presentPopoverFromRect:sender.frame
                                       inView:self.view
                     permittedArrowDirections:UIPopoverArrowDirectionRight
                                     animated:YES];
    
    if (self.position != nil) {
        [pickerController selectHouse:self.house animated:NO];
    }
    
    [pickerController release];
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    [popoverController release];
}

- (void)startTwinkle:(UIView *)view
{
    view.alpha = 1;
    [UIView animateWithDuration:0.8
                          delay:0
                        options:UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse | UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         view.alpha = 0.5;
                     }
                     completion:nil];
}

- (void)stopTwinkle:(UIView *)view
{
    [UIView animateWithDuration:0.01
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         view.alpha = 1;
                     }
                     completion:nil];
}

- (IBAction)calculateLoan:(id)sender 
{
    [self calculateMonthlyPayment];
}

- (IBAction)closeCalculator:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)cancelClient:(id)sender {
    self.client = nil;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect bounds = self.view.bounds;
    if (textField == self.downPayment) {
        [(DownPaymentInputView *)textField.inputView setTotalPrice:_totalPrice];
        
        bounds.origin.y = 100;
    } else if (textField == self.loanPeriod) {
        bounds.origin.y = 170;
    }
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.view.bounds = bounds;
                     }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    CGRect bounds = self.view.bounds;
    bounds.origin.y = 0;
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.view.bounds = bounds;
                     }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self calculateMonthlyPayment];
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSPredicate *numberPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES '^[0-9]*$'"];
    if (![numberPredicate evaluateWithObject:string]) {
        return NO;
    }
    return YES;
}

- (void)calculateMonthlyPayment {
    NSInteger totalPrice = _totalPrice;
    NSInteger paymentType = [self.paymentType selectedIndex];
    NSInteger downPayment = [self.downPayment.text intValue];
    NSInteger loanPeriod = [self.loanPeriod.text intValue];
	NSInteger monthCount = loanPeriod * 12;
    CGFloat rateDiscount = 1;
    CGFloat yearRate = 0;
	CGFloat monthRate = 0;
	NSInteger monthlyPayment = 0;
    
    if (loanPeriod == 0 || totalPrice < downPayment) {
        monthlyPayment = 0;
    } else {
        NSInteger selectedLoanRate = [self.loanRate selectedIndex];
        if (selectedLoanRate == 0) {
            rateDiscount = 1;
        } else if (selectedLoanRate == 1) {
            rateDiscount = 0.85;
        } else if (selectedLoanRate == 2) {
            rateDiscount = 1.1;
        }
        
        NSInteger selectedDiscount = [self.discountRate selectedIndex];
        if (selectedDiscount == 1) {
            totalPrice = totalPrice * 0.99;
        } else if (selectedDiscount == 2) {
            totalPrice = totalPrice * 0.98;
        } else if (selectedDiscount == 3) {
            totalPrice = totalPrice * 0.97;
        } else if (selectedDiscount == 4) {
            totalPrice = totalPrice * 0.96;
        } else if (selectedDiscount == 5) {
            totalPrice = totalPrice * 0.95;
        }
        
        NSDictionary *rateInfo = [_loanRateInfo objectAtIndex:paymentType];
        if (loanPeriod == 1) {
            yearRate = [[rateInfo objectForKey:@"rate1"] floatValue] / 100;
        } else if (loanPeriod <= 3) {
            yearRate = [[rateInfo objectForKey:@"rate3"] floatValue] / 100;
        } else if (loanPeriod <= 5) {
            yearRate = [[rateInfo objectForKey:@"rate5"] floatValue] / 100;
        } else {
            yearRate = [[rateInfo objectForKey:@"rate5+"] floatValue] / 100;
        }
        monthRate = yearRate * rateDiscount / 12;
        
        monthlyPayment = (totalPrice - downPayment) * monthRate * pow(1 + monthRate, monthCount) / (pow(1 + monthRate, monthCount) - 1);
        
        if (self.client != nil) {
            [[DataProvider sharedProvider] historyOfClient:self.client withAction:1 andHouse:self.house];
        }
    }
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@"###,###,###"];
	[self.resultLabel setText:[numberFormatter stringFromNumber:[NSNumber numberWithInt:monthlyPayment]]];
    [numberFormatter release];
}

@end
