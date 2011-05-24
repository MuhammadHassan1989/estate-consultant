//
//  ClientListViewController.h
//  EstateConsultant
//
//  Created by farthinker on 5/1/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataProvider.h"


@interface ClientListController : UITableViewController <UIPopoverControllerDelegate> {
    NSInteger _clientType;
    NSMutableArray *_clients;
    NSArray *_filteredClients;
    Consultant *_consultant;
}

@property (nonatomic, assign) NSInteger clientType;
@property (nonatomic, retain) Consultant *consultant;
@property (nonatomic, retain) NSMutableArray *clients;

- (void)addObserverForClient:(Client *)client;
- (void)removeObserverForClient:(Client *)client;


@end
