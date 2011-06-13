//
//  ClientListViewController.h
//  EstateConsultant
//
//  Created by farthinker on 5/1/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataProvider.h"
#import "SingleSelectControl.h"

@interface ClientListController : UIViewController <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource> {
    NSMutableArray *_clients;
    Consultant *_consultant;
    NSArray *_dataSource;
    UITableView *_tableView;
    UITextField *_searchField;
}

@property (nonatomic, retain) Consultant *consultant;
@property (nonatomic, retain) NSArray *dataSource;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet UITextField *searchField;

- (void)addObserverForClient:(Client *)client;
- (void)removeObserverForClient:(Client *)client;
- (void)filterClients:(NSString *)searchString;


@end
