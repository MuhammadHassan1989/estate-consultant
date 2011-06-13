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
#import "Profile.h"
#import "ClientProfile.h"
#import "House.h"
#import "Layout.h"
#import "Position.h"
#import "History.h"
#import "Batch.h"
#import "Building.h"
#import "Unit.h"
#import "Estate.h"


@interface DataProvider : NSObject {
    NSManagedObjectContext *_managedObjectContext;
    NSManagedObjectContext *_demoManagedObjectContext;
    NSManagedObjectModel *_managedObjectModel;
    NSPersistentStoreCoordinator *_persistentStoreCoordinator;
    NSPersistentStoreCoordinator *_demoPersistentStoreCoordinator;
    Boolean _isDemo;
}

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, assign) Boolean isDemo;

+ (DataProvider *)sharedProvider;

- (void)saveContext;
- (void)loadDemoData;

#pragma mark - Consultant Data Provider
- (Estate *)getEstateByID:(NSInteger)estateID;

#pragma mark - Consultant Data Provider
- (Boolean)authenticateConsultant:(NSString *)username withPassword:(NSString *)password;
- (Consultant *)getConsultantByUsername:(NSString *)username;
- (Consultant *)getConsultantByID:(NSInteger)consultantID;

#pragma mark - Client Data Provider
- (Client *)getClientByID:(NSInteger)clientID;
- (NSArray *)getClientsOfEstate:(Estate *)estate;
- (Client *)clientWithName:(NSString *)name andPhone:(NSString *)phone andSex:(NSInteger)sex ofConsultant:(Consultant *)consultant;

#pragma mark - Profile Data Provider
- (Profile *)getProfileByID:(NSInteger)profileID;
- (ClientProfile *)getClientProfile:(Profile *)profile ofClient:(Client *)client;

#pragma mark - House Data Provider
- (House *)getHouseByID:(NSInteger)houseID;

#pragma mark - Layout Data Provider
- (Layout *)getLayoutByID:(NSInteger)layoutID;

#pragma mark - Position Data Provider
- (Batch *)getBatchByID:(NSInteger)batchID;
- (Position *)getPositionByID:(NSInteger)positionID;
- (NSArray *)getPositions;

#pragma mark - History Data Provider
- (History *)getHistoryByID:(NSInteger)historyID;
- (History *)historyOfClient:(Client *)client withAction:(NSInteger)action andHouse:(House *)house;


@end
