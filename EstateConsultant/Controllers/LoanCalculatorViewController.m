//
//  LoanCalculatorViewController.m
//  EstateConsultant
//
//  Created by farthinker on 4/13/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import "LoanCalculatorViewController.h"
#import "EstateConsultantUtils.h"
#import "DataProvider.h"


@implementation LoanCalculatorViewController

@synthesize client = _client;
@synthesize house = _house;
@synthesize totalLabel = _totalLabel;
@synthesize paymentType = _paymentType;
@synthesize loanRate = _loanRate;
@synthesize discountRate = _discountRate;
@synthesize downPayment = _downPayment;
@synthesize loanPeriod = _loanPeriod;
@synthesize resultLabel = _resultLabel;
@synthesize layoutController = _layoutController;

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
    [_totalLabel release];
    [_paymentType release];
    [_loanRate release];
    [_discountRate release];
    [_downPayment release];
    [_loanPeriod release];
    [_resultLabel release];
    [_house release];
    [_client release];
    [_loanRateInfo release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *documentPath = [[[EstateConsultantUtils sharedUtils] documentsURL] path];
    NSString *ratePath = [documentPath stringByAppendingPathComponent:@"LoanRate.plist"];
	_loanRateInfo = [[NSArray alloc] initWithContentsOfFile:ratePath];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"完成"
                                                                   style:UIBarButtonItemStyleDone
                                                                  target:self
                                                                  action:@selector(closeCalculator:)];
    [self.navigationItem setRightBarButtonItem:doneButton];
    [doneButton release];
    
    [self.downPayment setDelegate:self];
    [self.loanPeriod setDelegate:self];

}

- (void)viewDidUnload
{
    [self setTotalLabel:nil];
    [self setPaymentType:nil];
    [self setLoanRate:nil];
    [self setDiscountRate:nil];
    [self setDownPayment:nil];
    [self setLoanPeriod:nil];
    [self setResultLabel:nil];
    [self setHouse:nil];
    [self setClient:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (void)setHouse:(House *)house
{
    [self.navigationItem setTitle:[NSString stringWithFormat:@"计算房贷：%@楼", house.floor]];
    
    _totalPrice = house.price.intValue * house.layout.area.intValue;
    [self.totalLabel setText:[NSString stringWithFormat:@"%i元", _totalPrice]];
        
    if (_house != nil) {
        [_house release];
        _house = nil;
    }
    _house = [house retain];
    
    [self calculateMonthlyPayment];
}

- (IBAction)calculateLoan:(id)sender 
{
    [self calculateMonthlyPayment];
}

- (void)closeCalculator:(id)sender
{
    [self.layoutController dismissModalViewControllerAnimated:YES];    
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
    NSInteger paymentType = [self.paymentType selectedSegmentIndex];
    NSInteger downPayment = [self.downPayment.text intValue];
    NSInteger loanPeriod = [self.loanPeriod.text intValue];
	NSInteger monthCount = loanPeriod * 12;
    CGFloat rateDiscount = 1;
    CGFloat yearRate = 0;
	CGFloat monthRate = 0;
	NSInteger monthlyPayment = 0;
    
    NSInteger selectedLoanRate = [self.loanRate selectedSegmentIndex];
    if (selectedLoanRate == 0) {
        rateDiscount = 1;
    } else if (selectedLoanRate == 1) {
        rateDiscount = 0.85;
    } else if (selectedLoanRate == 2) {
        rateDiscount = 1.1;
    }
    
    NSInteger selectedDiscount = [self.discountRate selectedSegmentIndex];
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
    
    if (loanPeriod == 0) {
        monthlyPayment = 0;
    } else {
        monthlyPayment = (totalPrice - downPayment) * monthRate * pow(1 + monthRate, monthCount) / (pow(1 + monthRate, monthCount) - 1);
        [[DataProvider sharedProvider] historyOfClient:self.client withAction:1 andTarget:self.house];
    }
	[self.resultLabel setText:[NSString stringWithFormat:@"月供金额：%i 元", monthlyPayment]];
}

@end
