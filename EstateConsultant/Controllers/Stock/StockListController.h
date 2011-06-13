//
//  StockListController.h
//  EstateConsultant
//
//  Created by farthinker on 5/17/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataProvider.h"

@interface StockListController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    Batch *_batch;
    NSArray *_buildings;
    NSMutableArray *_positionArray;
    UITableView *_tableView;
}

@property (nonatomic, retain) Batch *batch;
@property (nonatomic, retain) IBOutlet UITableView *tableView;

@end
