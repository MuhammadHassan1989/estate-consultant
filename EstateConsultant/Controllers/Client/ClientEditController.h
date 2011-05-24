//
//  ClientEditController.h
//  EstateConsultant
//
//  Created by farthinker on 5/14/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataProvider.h"


@interface ClientEditController : UIViewController {
    Client *_client;
    UIImageView *_starImage;
    UISegmentedControl *_sexSegments;
    UITextField *_nameField;
    UITextField *_phoneField;
    UIScrollView *_profileList;
    NSMutableArray *_profileFields;
}

@property (nonatomic, retain) Client *client;
@property (nonatomic, retain) IBOutlet UIImageView *starImage;
@property (nonatomic, retain) IBOutlet UISegmentedControl *sexSegments;
@property (nonatomic, retain) IBOutlet UITextField *nameField;
@property (nonatomic, retain) IBOutlet UITextField *phoneField;
@property (nonatomic, retain) IBOutlet UIScrollView *profileList;

- (IBAction)endEdit:(id)sender;
- (IBAction)cancelEdit:(id)sender;


@end
