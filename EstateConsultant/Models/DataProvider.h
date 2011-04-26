//
//  AbstractProvider.h
//  EstateConsultant
//
//  Created by farthinker on 3/31/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Consultant.h"
#import "Client.h"
#import "House.h"
#import "Layout.h"
#import "Position.h"
#import "History.h"


@interface DataProvider : NSObject {
    NSManagedObjectContext *_managedObjectContext;
    NSManagedObjectContext *_demoManagedObjectContext;
    NSManagedObjectModel *_managedObjectModel;
    NSPersistentStoreCoordinator *_persistentStoreCoordinator;
    NSPersistentStoreCoordinator *_demoPersistentStoreCoordinator;
}

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, assign) Boolean isDemo;

+ (DataProvider *)sharedProvider;

- (void)saveContext;
- (void)loadDemoData;

#pragma mark - Consultant Data Provider
- (Boolean)authenticateConsultant:(NSString *)username withPassword:(NSString *)password;
- (Consultant *)getConsultantByUsername:(NSString *)username;
- (Consultant *)getConsultantByID:(NSInteger)consultantID;

#pragma mark - Client Data Provider
- (Client *)getClientByID:(NSInteger)clientID;
- (Client *)clientWithName:(NSString *)name andPhone:(NSString *)phone andSex:(NSInteger)sex ofConsultant:(Consultant *)consultant;

#pragma mark - House Data Provider
- (House *)getHouseByID:(NSInteger)houseID;
- (NSSet *)getOnSaleHousesOfLayout:(Layout *)layout;

#pragma mark - Layout Data Provider
- (Layout *)getLayoutByID:(NSInteger)layoutID;
- (NSArray *)getLayouts;

#pragma mark - Position Data Provider
- (Position *)getPositionByID:(NSInteger)positionID;

#pragma mark - History Data Provider
- (History *)getHistoryByID:(NSInteger)historyID;
- (History *)getHistoryByDate:(NSDate *)date;
- (History *)historyOfClient:(Client *)client withAction:(NSInteger)action andTarget:(id)target;


@end
