//
//  StockDetailController.h
//  EstateConsultant
//
//  Created by farthinker on 5/18/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataProvider.h"

@interface StockDetailController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    Position *_position;
    UINavigationItem *_navItem;
    UITableView *_tableView;
    NSArray *_houses;
}

@property (nonatomic, retain) Position *position;
@property (nonatomic, retain) IBOutlet UINavigationItem *navItem;
@property (nonatomic, retain) IBOutlet UITableView *tableView;


@end
