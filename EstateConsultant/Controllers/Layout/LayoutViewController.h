//
//  LayoutViewController.h
//  EstateConsultant
//
//  Created by farthinker on 4/29/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LayoutDetailController.h"
#import "StackScrollViewController.h"
#import "DataProvider.h"


@interface LayoutViewController : StackScrollViewController {
    Batch *_batch;
}

@property (nonatomic, retain) Batch *batch;

@end
