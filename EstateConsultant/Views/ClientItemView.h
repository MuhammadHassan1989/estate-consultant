//
//  ClientItemView.h
//  EstateConsultant
//
//  Created by farthinker on 4/2/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Client.h"


@interface ClientItemView : UIView {
}

@property (nonatomic, retain) Client *client;
@property (nonatomic, retain) NSArray *clientHistory;
@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UILabel *phoneLabel;
@property (nonatomic, retain) IBOutlet UILabel *dateLabel;

@end
