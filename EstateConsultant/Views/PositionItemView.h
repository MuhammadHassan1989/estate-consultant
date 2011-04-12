//
//  PositionItemView.h
//  EstateConsultant
//
//  Created by farthinker on 4/11/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataProvider.h"


@interface PositionItemView : UIView {
}

@property (nonatomic, assign) NSInteger layoutID;
@property (nonatomic, retain) Position *position;
@property (nonatomic, retain) IBOutlet UIButton *button;

- (IBAction)selectPosition:(id)sender forEvent:(UIEvent *)event;

@end
