//
//  BatchListViewController.h
//  EstateConsultant
//
//  Created by farthinker on 6/20/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataProvider.h"
#import "EstateConsultantViewController.h"


@interface BatchListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    UITableView *_tableView;
    Estate *_estate;
    UIPopoverController *_parentPopover;
    EstateConsultantViewController *_rootController;
    NSArray *_batches;
}

@property (nonatomic, retain) Estate *estate;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, assign) UIPopoverController *parentPopover;
@property (nonatomic, assign) EstateConsultantViewController *rootController;

- (void)selectBatch:(Batch *)batch;

@end
