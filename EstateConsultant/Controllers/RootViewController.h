//
//  RootViewController.h
//  EstateConsultant
//
//  Created by farthinker on 4/28/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClientViewController.h"
#import "LayoutViewController.h"
#import "StockViewController.h"


@interface RootViewController : UIViewController {
    UISegmentedControl *_navTab;
    ClientViewController *_clientViewController;
    LayoutViewController *_layoutViewController;
    StockViewController *_stockViewController;
    UIView *_selectedView;
    Consultant *_consultant;
}

@property (nonatomic, retain) Consultant *consultant;
@property (nonatomic, retain) IBOutlet UISegmentedControl *navTab;

- (IBAction)selectTab:(UISegmentedControl *)sender forEvent:(UIEvent *)event;

@end
