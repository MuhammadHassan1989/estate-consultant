//
//  PopoverPickerController.h
//  EstateConsultant
//
//  Created by farthinker on 5/19/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataProvider.h"


@protocol PopoverPickerDelegate;

@interface PopoverPickerController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
    UIPickerView *_pickerView;
    NSArray *_dataList;
    id<PopoverPickerDelegate> _delegate;
    UIPopoverController *_parentPopover;
    UIView *_triggerView;
}

@property (nonatomic, retain) NSArray *dataList;
@property (nonatomic, assign) id<PopoverPickerDelegate> delegate;
@property (nonatomic, assign) UIPopoverController *parentPopover;
@property (nonatomic, assign) UIView *triggerView;
@property (nonatomic, retain) IBOutlet UIPickerView *pickerView;

- (IBAction)confirmPick:(id)sender;
- (void)selectObject:(id)object;

@end


@protocol PopoverPickerDelegate <NSObject>

- (NSString *)popoverPicker:(PopoverPickerController *)popoverPicker titleForObject:(id)object;

@optional

- (void)popoverPicker:(PopoverPickerController *)popoverPicker didSelectObject:(id)object;

@end
