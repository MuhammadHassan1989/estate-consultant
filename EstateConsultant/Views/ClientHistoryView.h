//
//  ClientHistoryView.h
//  EstateConsultant
//
//  Created by farthinker on 4/7/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataProvider.h"


@interface ClientHistoryView : UIView {
    NSMutableArray *_layoutThumbViews;
}

@property (nonatomic, retain) History *history;
@property (nonatomic, retain) IBOutlet UILabel *dateLabel;
@property (nonatomic, retain) IBOutlet UILabel *actionLabel;


@end
