//
//  ClientHistoryView.h
//  EstateConsultant
//
//  Created by farthinker on 5/14/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataProvider.h"


@interface ClientHistoryView : UIView {
    UILabel *_dateLabel;
    UILabel *_actionLabel;
    History *_history;
    NSMutableArray *_houseLabels;
}

@property (nonatomic, retain) History *history;
@property (nonatomic, retain) IBOutlet UILabel *dateLabel;
@property (nonatomic, retain) IBOutlet UILabel *actionLabel;


@end
