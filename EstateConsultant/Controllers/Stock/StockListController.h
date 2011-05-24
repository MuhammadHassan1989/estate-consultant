//
//  StockListController.h
//  EstateConsultant
//
//  Created by farthinker on 5/17/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface StockListController : UITableViewController {
    NSArray *_positions;
}

@property (nonatomic, retain) NSArray *positions;

@end
