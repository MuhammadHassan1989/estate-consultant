//
//  LayoutListViewController.h
//  EstateConsultant
//
//  Created by farthinker on 4/9/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LayoutItemView.h"
#import "DataProvider.h"


@interface LayoutListViewController : UIViewController {
    NSMutableArray *_layoutItems;
}

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) NSArray *layouts;
@property (nonatomic, assign) Layout *selectedLayout;

@end
