//
//  ClientTableViewCell.h
//  EstateConsultant
//
//  Created by farthinker on 5/2/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataProvider.h"


@interface ClientTableViewCell : UITableViewCell {
    UIImageView *_starView;
    UILabel *_nameLabel;
    UILabel *_phoneLabel;
    Client *_client;
}

@property (nonatomic, retain) IBOutlet UIImageView *starView;
@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UILabel *phoneLabel;
@property (nonatomic, retain) Client *client;


@end
