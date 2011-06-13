//
//  ClientEditController.h
//  EstateConsultant
//
//  Created by farthinker on 5/14/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataProvider.h"
#import "SingleSelectControl.h"

@interface ClientEditController : UIViewController <UITextFieldDelegate> {
    Client *_client;
    NSArray *_profiles;
    UIImageView *_starImage;
    SingleSelectControl *_sexSegments;
    UITextField *_nameField;
    UITextField *_phoneField;
    UIScrollView *_profileList;
    NSMutableArray *_profileFields;
}

@property (nonatomic, retain) Client *client;
@property (nonatomic, retain) NSArray *profiles;
@property (nonatomic, retain) IBOutlet UIImageView *starImage;
@property (nonatomic, retain) IBOutlet SingleSelectControl *sexSegments;
@property (nonatomic, retain) IBOutlet UITextField *nameField;
@property (nonatomic, retain) IBOutlet UITextField *phoneField;
@property (nonatomic, retain) IBOutlet UIScrollView *profileList;

- (IBAction)endEdit:(id)sender;
- (IBAction)cancelEdit:(id)sender;


@end
