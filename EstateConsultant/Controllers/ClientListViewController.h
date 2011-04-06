//
//  ClientListViewController.h
//  EstateConsultant
//
//  Created by farthinker on 4/1/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Consultant.h"


@interface ClientListViewController : UIViewController <UITextFieldDelegate> {
    NSInteger _scrollTopInset;
    NSMutableArray *_clientItems;
}

@property (nonatomic, retain) Consultant *consultant;
@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UIView *emptyInfo;
@property (nonatomic, retain) IBOutlet UIScrollView *clientList;
@property (nonatomic, retain) IBOutlet UITextField *searchField;

- (IBAction)logout:(id)sender forEvent:(UIEvent *)event;
- (IBAction)showStat:(id)sender forEvent:(UIEvent *)event;
- (void)filterClients:(NSString *)text;

@end
