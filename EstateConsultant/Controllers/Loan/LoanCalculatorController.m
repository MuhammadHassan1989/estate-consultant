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

@implementation LoanCalculatorController

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
@synthesize clientLabel = _clientLabel;

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
    [_position release];
    [_loanRateInfo release];
    [_positionButton release];
    [_floorButton release];
    [_clientButton release];
    [_clientView release];
    [_clientLabel release];
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
    } else if (position != _position) {
        [self.positionButton setTitle:position.name forState:UIControlStateNormal];
    }
    
    [_position release];
    _position = [position retain];
}

- (void)setHouse:(House *)house
{    
    if (house == nil) {
        [self.floorButton setTitle:@"轻击选择楼层" forState:UIControlStateNormal];
        _totalPrice = 0;
        [self startTwinkle:self.floorButton];
    } else if (house != _house) {
        [self stopTwinkle:self.floorButton];
        NSString *floorText = [NSString stringWithFormat:@"%@楼(#%@)", house.floor, house.num];
        [self.floorButton setTitle:floorText forState:UIControlStateNormal];
        _totalPrice = house.price.intValue * house.layout.area.intValue;
    }
    
    [self.totalLabel setText:[NSString stringWithFormat:@"%i元", _totalPrice]];
    [self calculateMonthlyPayment];
    
    [_house release];
    _house = [house retain];
}

- (void)setClient:(Client *)client
{    
    if (client == nil) {
        self.clientButton.hidden = NO;
        self.clientView.hidden = YES;
        [self startTwinkle:self.clientButton];
    } else if (client != _client) {
        [self stopTwinkle:self.clientButton];
        self.clientButton.hidden = YES;
        self.clientView.hidden = NO;
        
        NSString *format;
        if (client.sex.intValue == 1) {
            format = @"%@先生";
        } else {
            format = @"%@女士";
        }
        self.clientLabel.text = [NSString stringWithFormat:format, client.name];
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
    [self setPosition:nil];
    [self setPositionButton:nil];
    [self setFloorButton:nil];
    [self setClientButton:nil];
    [self setClientView:nil];
    [self setClientLabel:nil];
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
    pickerController.contentSizeForViewInPopover = CGSizeMake(320, 482);
    
    UIPopoverController *popoverController = [[UIPopoverController alloc] initWithContentViewController:pickerController];
    popoverController.delegate = self;
    pickerController.parentPopover = popoverController;
    pickerController.calculatorController = self;
    
    [popoverController presentPopoverFromRect:self.clientButton.frame
                                       inView:self.view
                     permittedArrowDirections:UIPopoverArrowDirectionAny
                                     animated:YES];
    
    [pickerController release];
}

- (IBAction)pickPosition:(UIButton *)sender {
    NSArray *positions = [[DataProvider sharedProvider] getPositions];
    [self showPicker:sender withDataSource:positions andSelectedObject:self.position];
}

- (IBAction)pickFloor:(UIButton *)sender {
    NSSortDescriptor *sortFloor = [[NSSortDescriptor alloc] initWithKey:@"floor" ascending:NO];
    NSArray *houses = [self.position.houses sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortFloor]];
    [sortFloor release];
    
    [self showPicker:sender withDataSource:houses andSelectedObject:self.house];
}

- (NSString *)popoverPicker:(PopoverPickerController *)popoverPicker titleForObject:(id)object
{
    NSString *title = nil;
    if (popoverPicker.triggerView == self.floorButton) {
        House *house = (House *)object;
        title = [NSString stringWithFormat:@"%@楼 - #%@", house.floor, house.num];
    } else if (popoverPicker.triggerView == self.positionButton) {
        Position *position = (Position *)object;
        title = position.name;
    }
    
    return title;
}

- (void)popoverPicker:(PopoverPickerController *)popoverPicker didSelectObject:(id)object
{
    if (popoverPicker.triggerView == self.floorButton) {
        self.house = (House *)object;
    } if (popoverPicker.triggerView == self.positionButton) {
        self.position = (Position *)object;
        self.house = nil;
    }
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    [popoverController release];
}

- (void)showPicker:(UIView *)trigger withDataSource:(NSArray *)dataSource andSelectedObject:(id)object
{
    PopoverPickerController *pickerController = [[PopoverPickerController alloc] initWithNibName:@"PopoverPickerController" bundle:nil];
    pickerController.contentSizeForViewInPopover = CGSizeMake(320, 260);
    pickerController.delegate = self;
    pickerController.dataList = dataSource;
    pickerController.triggerView = trigger;
    
    UIPopoverController *popoverController = [[UIPopoverController alloc] initWithContentViewController:pickerController];
    popoverController.delegate = self;
    pickerController.parentPopover = popoverController;
    
    [popoverController presentPopoverFromRect:trigger.frame
                                       inView:self.view
                     permittedArrowDirections:UIPopoverArrowDirectionAny
                                     animated:YES];
    
    [pickerController selectObject:object];
    [pickerController release];
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
    
    if (loanPeriod == 0 || totalPrice < downPayment) {
        monthlyPayment = 0;
    } else {
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
        
        monthlyPayment = (totalPrice - downPayment) * monthRate * pow(1 + monthRate, monthCount) / (pow(1 + monthRate, monthCount) - 1);
        
        if (self.client != nil) {
            [[DataProvider sharedProvider] historyOfClient:self.client withAction:1 andHouse:self.house];
        }
    }
    
	[self.resultLabel setText:[NSString stringWithFormat:@"月供金额：%i 元", monthlyPayment]];
}

@end
