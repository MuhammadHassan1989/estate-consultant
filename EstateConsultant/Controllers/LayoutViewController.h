//
//  LayoutViewController.h
//  EstateConsultant
//
//  Created by farthinker on 4/9/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataProvider.h"


@interface LayoutViewController : UIViewController {
    NSMutableArray *_layoutPics;
    NSMutableArray *_positionItems;
    UIPopoverController *_layoutListPopover;
}

@property (nonatomic, retain) Client *client;
@property (nonatomic, retain) Layout *layout;
@property (nonatomic, retain) IBOutlet UILabel *descLabel;
@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UILabel *areaLabel;
@property (nonatomic, retain) IBOutlet UILabel *priceLabel;
@property (nonatomic, retain) IBOutlet UILabel *totalPriceLabel;
@property (nonatomic, retain) IBOutlet UILabel *followerLabel;
@property (nonatomic, retain) IBOutlet UILabel *onSaleCountLabel;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UIView *positionView;
@property (nonatomic, retain) IBOutlet UIButton *layoutListButton;

- (IBAction)showLayoutList:(id)sender forEvent:(UIEvent *)event;
- (IBAction)returnToClient:(id)sender forEvent:(UIEvent *)event;


@end
