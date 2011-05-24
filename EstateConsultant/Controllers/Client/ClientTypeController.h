//
//  ClientTypeController.h
//  EstateConsultant
//
//  Created by farthinker on 4/30/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataProvider.h"


@interface ClientTypeController : UITableViewController {
    Consultant *_consultant;
}

@property (nonatomic, retain) Consultant *consultant;

@end
