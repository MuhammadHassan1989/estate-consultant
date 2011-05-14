//
//  ClientViewController.h
//  EstateConsultant
//
//  Created by farthinker on 4/29/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataProvider.h"
#import "ClientDetailController.h"


@interface ClientViewController : UIViewController {
    UINavigationController *_listNavController;
    ClientDetailController *_detailController;
    Consultant *_consultant;
}

@property (nonatomic, retain) Consultant *consultant;

@end
