//
//  ClientViewController.h
//  EstateConsultant
//
//  Created by farthinker on 5/29/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StackScrollViewController.h"
#import "DataProvider.h"


@interface ClientViewController : StackScrollViewController {
    Consultant *_consultant;
}

@property (nonatomic, retain) Consultant *consultant;

@end
