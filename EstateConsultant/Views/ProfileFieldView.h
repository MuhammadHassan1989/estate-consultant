//
//  ProfileFieldView.h
//  EstateConsultant
//
//  Created by farthinker on 5/9/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataProvider.h"

@interface ProfileFieldView : UIView {
    Profile *_profile;
    Client *_client;
    UILabel *_nameLabel;
    UILabel *_valueLabel;
}

@property (nonatomic, retain) Profile* profile;
@property (nonatomic, retain) Client* client;
@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UILabel *valueLabel;

@end
