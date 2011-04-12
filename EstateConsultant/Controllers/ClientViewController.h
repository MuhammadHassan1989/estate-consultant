//
//  ClientViewController.h
//  EstateConsultant
//
//  Created by farthinker on 4/6/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataProvider.h"


@interface ClientViewController : UIViewController <UITextFieldDelegate> {
    NSInteger _scrollTopInset;
    UIPopoverController *_layoutListPopover;
}

@property (nonatomic, retain) Client *client;
@property (nonatomic, retain) IBOutlet UITextField *nameField;
@property (nonatomic, retain) IBOutlet UITextField *phoneField;
@property (nonatomic, retain) IBOutlet UISegmentedControl *sexSelect;
@property (nonatomic, retain) IBOutlet UISegmentedControl *estateTypeSelect;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UIView *emptyInfo;

- (IBAction)returnClientList:(id)sender forEvent:(UIEvent *)event;
- (IBAction)showLayoutList:(id)sender forEvent:(UIEvent *)event;
- (IBAction)changeSex:(id)sender forEvent:(UIEvent *)event;
- (IBAction)changeEstateType:(id)sender forEvent:(UIEvent *)event;

- (void)loadLayoutView:(Layout *)layout;

@end
