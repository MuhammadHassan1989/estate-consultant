//
//  ClientListViewController.h
//  EstateConsultant
//
//  Created by farthinker on 5/1/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataProvider.h"


@interface ClientListViewController : UITableViewController {
    NSInteger _clientType;
    NSArray *_clients;
    Consultant *_consultant;
}

@property (nonatomic, assign) NSInteger clientType;
@property (nonatomic, retain) Consultant *consultant;
@property (nonatomic, retain) NSArray *clients;

@end
