//
//  ClientDetailController.h
//  EstateConsultant
//
//  Created by farthinker on 5/6/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataProvider.h"


@interface ClientDetailController : UIViewController {
    UIScrollView *_scrollView;
    UIView *_infoList;
    UIView *_historyList;
    UIImageView *_starImage;
    UILabel *_nameLabel;
    UILabel *_sexLabel;
    UILabel *_phoneLabel;
    Client *_client;
    NSMutableArray *_profileFields;
    NSMutableArray *_historyViews;
}

@property (nonatomic, retain) Client *client;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UIView *infoList;
@property (nonatomic, retain) IBOutlet UIView *historyList;
@property (nonatomic, retain) IBOutlet UIImageView *starImage;
@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UILabel *sexLabel;
@property (nonatomic, retain) IBOutlet UILabel *phoneLabel;


- (IBAction)editClient:(id)sender;
- (void)addObserverForClient:(Client *)client;
- (void)removeObserverForClient:(Client *)client;


@end
