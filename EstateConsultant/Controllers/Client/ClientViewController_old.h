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
#import "ClientEditController.h"

@interface ClientViewController : UIViewController <UINavigationControllerDelegate> {
    UINavigationController *_listNavController;
    ClientDetailController *_detailController;
    ClientEditController *_editController;
    Consultant *_consultant;
    UIView *_maskView;
}

@property (nonatomic, retain) Consultant *consultant;
@property (nonatomic, retain) ClientDetailController *detailController;

@end
