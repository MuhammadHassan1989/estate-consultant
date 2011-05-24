//
//  PopoverPickerController.m
//  EstateConsultant
//
//  Created by farthinker on 5/19/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import "PopoverPickerController.h"


@implementation PopoverPickerController

@synthesize pickerView = _pickerView;
@synthesize delegate = _delegate;
@synthesize parentPopover = _parentPopover;
@synthesize dataList = _dataList;
@synthesize triggerView = _triggerView;

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
    [_dataList release];
    [_pickerView release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)selectObject:(id)object
{
    NSInteger row = [self.dataList indexOfObject:object];
    [self.pickerView selectRow:row inComponent:0 animated:NO];
}

- (IBAction)confirmPick:(id)sender {
    id selectedObject = [self.dataList objectAtIndex:[self.pickerView selectedRowInComponent:0]];
    [self.delegate popoverPicker:self didSelectObject:selectedObject];
    
    [self.parentPopover dismissPopoverAnimated:YES];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [self setDataList:nil];
    [self setPickerView:nil];
    [self setParentPopover:nil];
    [self setDelegate:nil];
    [self setTriggerView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

#pragma mark - Pick View Delegate Implementation

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.delegate popoverPicker:self titleForObject:[self.dataList objectAtIndex:row]];
}

#pragma mark - Pick View Data Source Implementation

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.dataList.count;
}

@end
