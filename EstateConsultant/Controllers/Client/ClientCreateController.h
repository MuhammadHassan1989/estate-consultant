//
//  ClientCreateViewController.h
//  EstateConsultant
//
//  Created by farthinker on 4/8/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataProvider.h"


@class EstateConsultantViewController, SingleSelectControl;

@interface ClientCreateController : UIViewController <UITextFieldDelegate> {
    EstateConsultantViewController *_rootController;
}

@property (nonatomic, assign) EstateConsultantViewController *rootController;
@property (nonatomic, retain) Consultant *consultant;
@property (nonatomic, retain) IBOutlet UITextField *nameLabel;
@property (nonatomic, retain) IBOutlet UITextField *phoneLabel;
@property (nonatomic, retain) IBOutlet SingleSelectControl *sexSelect;
@property (nonatomic, retain) IBOutlet UIButton *addClientButton;

- (IBAction)addClient:(id)sender;

@end
