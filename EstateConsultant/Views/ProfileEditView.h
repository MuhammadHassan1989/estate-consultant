//
//  ProfileEditView.h
//  EstateConsultant
//
//  Created by farthinker on 5/14/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataProvider.h"

@interface ProfileEditView : UIView {
    Profile *_profile;
    Client *_client;
    UILabel *_nameLabel;
    UITextField *_textField;
    UISegmentedControl *_segmentField;
}

@property (nonatomic, retain) Profile* profile;
@property (nonatomic, retain) Client* client;
@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UITextField *textField;
@property (nonatomic, retain) IBOutlet UISegmentedControl *segmentField;

- (void)saveChanges;

@end
