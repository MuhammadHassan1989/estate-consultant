//
//  AbstractProvider.m
//  EstateConsultant
//
//  Created by farthinker on 3/31/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import "DataProvider.h"
#import "EstateConsultantUtils.h"

static DataProvider *sharedProvider = nil;

@implementation DataProvider

@synthesize isDemo = _isDemo;


+ (DataProvider *)sharedProvider
{
    if (sharedProvider == nil) {
        sharedProvider = [[super allocWithZone:NULL] init];
    }
    return sharedProvider;
}


#pragma mark - Overrides for Singleton

+ (id)allocWithZone:(NSZone *)zone
{
    return [[self sharedProvider] retain];
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (id)retain
{
    return self;
}

- (NSUInteger)retainCount
{
    return NSUIntegerMax;  //denotes an object that cannot be released
}

- (void)release
{
    //do nothing
}

- (id)autorelease
{
    return self;
}


#pragma mark - Core data related

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil)
    {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil)
    {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"EstateConsultant" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];    
    return _managedObjectModel;
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil)
    {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[[EstateConsultantUtils sharedUtils] documentsURL] URLByAppendingPathComponent:@"EstateConsultant.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

- (void)setIsDemo:(Boolean)isDemo
{
    if (isDemo == _isDemo) {
        return;
    } else if (_managedObjectContext != nil) {
        [self saveContext];
        [_managedObjectContext release];
        _managedObjectContext = nil;
    } else if (_persistentStoreCoordinator != nil) {
        [_persistentStoreCoordinator release];
        _persistentStoreCoordinator = nil;
    }
    
    _isDemo = isDemo;
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
        NSLog(@"context saved");
    }
}

- (void)loadDemoData
{
    self.isDemo = YES;
    
    NSString *documentsPath = [[[EstateConsultantUtils sharedUtils] documentsURL] path];
    NSString *storePath = [documentsPath stringByAppendingPathComponent:@"EstateConsultant.sqlite"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:storePath]) {
        NSManagedObjectContext *moc = [self managedObjectContext];
        
        // layout data
        NSString *layoutsFile = [[NSBundle mainBundle] pathForResource:@"Layout.plist" ofType:nil];
        NSArray *layouts = [[NSArray alloc] initWithContentsOfFile:layoutsFile];
        for (NSDictionary *layout in layouts) {
            Layout *newLayout = [NSEntityDescription insertNewObjectForEntityForName:@"Layout"
                                                              inManagedObjectContext:moc];
            newLayout.layoutID = [layout valueForKey:@"id"];
            newLayout.area = [layout valueForKey:@"area"];
            newLayout.desc = [layout valueForKey:@"desc"];
            newLayout.name = [layout valueForKey:@"name"];
            newLayout.pics = [layout valueForKey:@"pics"];
        }
        [layouts release];
        
        // position data
        NSString *positionFile = [[NSBundle mainBundle] pathForResource:@"Position.plist" ofType:nil];
        NSArray *positions = [[NSArray alloc] initWithContentsOfFile:positionFile];
        for (NSDictionary *position in positions) {
            Position *newPosition = [NSEntityDescription insertNewObjectForEntityForName:@"Position"
                                                            inManagedObjectContext:moc];
            newPosition.name = [position valueForKey:@"name"];
            newPosition.positionID = [position valueForKey:@"id"];
        }
        [positions release];
        
        // house data
        NSString *houseFile = [[NSBundle mainBundle] pathForResource:@"House.plist" ofType:nil];
        NSArray *houses = [[NSArray alloc] initWithContentsOfFile:houseFile];
        for (NSDictionary *house in houses) {
            House *newHosue = [NSEntityDescription insertNewObjectForEntityForName:@"House"
                                                                inManagedObjectContext:moc];
            newHosue.houseID = [house valueForKey:@"id"];
            newHosue.floor = [house valueForKey:@"floor"];
            newHosue.num = [house valueForKey:@"num"];
            newHosue.price = [house valueForKey:@"price"];
            newHosue.status = [house valueForKey:@"status"];
            newHosue.layout = [self getLayoutByID:[[house valueForKey:@"layout"] intValue]];
            newHosue.position = [self getPositionByID:[[house valueForKey:@"position"] intValue]];
        }
        [houses release];
        
        // consultant data
        NSString *consultantsFile = [[NSBundle mainBundle] pathForResource:@"Consultant.plist" ofType:nil];
        NSArray *consultants = [[NSArray alloc] initWithContentsOfFile:consultantsFile];
        for (NSDictionary *consultant in consultants) {
            Consultant *newConsultant = [NSEntityDescription insertNewObjectForEntityForName:@"Consultant"
                                                                      inManagedObjectContext:moc];
            newConsultant.consultantID = [consultant valueForKey:@"id"];
            newConsultant.name = [consultant valueForKey:@"name"];
            newConsultant.username = [consultant valueForKey:@"username"];
        }
        [consultants release];
        
        // profile data
        NSString *profilesFile = [[NSBundle mainBundle] pathForResource:@"Profile.plist" ofType:nil];
        NSArray *profiles = [[NSArray alloc] initWithContentsOfFile:profilesFile];
        for (NSDictionary *profile in profiles) {
            Profile *newProfile = [NSEntityDescription insertNewObjectForEntityForName:@"Profile"
                                                                      inManagedObjectContext:moc];
            newProfile.profileID = [profile valueForKey:@"id"];
            newProfile.type = [profile valueForKey:@"type"];
            newProfile.name = [profile valueForKey:@"name"];
            newProfile.meta = [profile valueForKey:@"meta"];
            newProfile.defaultValue = [profile valueForKey:@"default"];
            newProfile.sequence = [profile valueForKey:@"sequence"];
        }
        [profiles release];
        
        // client data
        NSString *clientsFile = [[NSBundle mainBundle] pathForResource:@"Client.plist" ofType:nil];
        NSArray *clients = [[NSArray alloc] initWithContentsOfFile:clientsFile];
        for (NSDictionary *client in clients) {
            Client *newClient = [NSEntityDescription insertNewObjectForEntityForName:@"Client"
                                                              inManagedObjectContext:moc];
            newClient.clientID = [client valueForKey:@"id"];
            newClient.phone = [client valueForKey:@"phone"];
            newClient.name = [client valueForKey:@"name"];
            newClient.sex = [client valueForKey:@"sex"];
            newClient.starred = [client valueForKey:@"starred"];
            newClient.consultant = [self getConsultantByID:[[client valueForKey:@"consultant"] intValue]];
            
            NSArray* followIDs = [client valueForKey:@"follows"];
            NSMutableSet *followSet = [[NSMutableSet alloc] initWithCapacity:followIDs.count];
            for (NSNumber *followID in followIDs) {
                [followSet addObject:[self getHouseByID:[followID intValue]]];
            }
            newClient.follows = followSet;
            [followSet release];
                        
            NSArray* orderIDs = [client valueForKey:@"orders"];
            NSMutableSet *orderSet = [[NSMutableSet alloc] initWithCapacity:orderIDs.count];
            for (NSNumber *orderID in orderIDs) {
                [orderSet addObject:[self getHouseByID:[orderID intValue]]];
            }
            newClient.orders = orderSet;
            [orderSet release];
            
            NSArray* purchaseIDs = [client valueForKey:@"purchases"];
            NSMutableSet *purchaseSet = [[NSMutableSet alloc] initWithCapacity:purchaseIDs.count];
            for (NSNumber *purchaseID in purchaseIDs) {
                [purchaseSet addObject:[self getHouseByID:[purchaseID intValue]]];
            }
            newClient.purchases = purchaseSet;
            [purchaseSet release];
            
            NSArray* profileObjects = [client valueForKey:@"profiles"];
            NSMutableSet *profileSet = [[NSMutableSet alloc] initWithCapacity:profileObjects.count];
            for (NSDictionary *profileObject in profileObjects) {
                ClientProfile *clientProfile = [NSEntityDescription insertNewObjectForEntityForName:@"ClientProfile"
                                                                             inManagedObjectContext:moc];
                clientProfile.client = newClient;
                clientProfile.profile = [self getProfileByID:[[profileObject valueForKey:@"profileID"] intValue]];
                clientProfile.value = [profileObject valueForKey:@"value"];
                [profileSet addObject:clientProfile];
            }
            newClient.clientProfiles = profileSet;
            [profileSet release];
        }
        [clients release];
        
        // history data
        NSString *historyFile = [[NSBundle mainBundle] pathForResource:@"History.plist" ofType:nil];
        NSArray *histories = [[NSArray alloc] initWithContentsOfFile:historyFile];
        for (NSDictionary *history in histories) {
            History *newHistory = [NSEntityDescription insertNewObjectForEntityForName:@"History"
                                                                inManagedObjectContext:moc];
            newHistory.historyID = [history valueForKey:@"id"];
            newHistory.date = [history valueForKey:@"date"];
            newHistory.action = [history valueForKey:@"action"];
            newHistory.client = [self getClientByID:[[history valueForKey:@"client"] intValue]];
                        
            NSArray* houseIDs = [history valueForKey:@"houses"];
            NSMutableSet *houseSet = [[NSMutableSet alloc] initWithCapacity:houseIDs.count];
            for (NSNumber *houseID in houseIDs) {
                [houseSet addObject:[self getHouseByID:[houseID intValue]]];
            }
            newHistory.houses = houseSet;
            [houseSet release];
        }
        [histories release];
                
		NSLog(@"demo data loaded");
	}
    
    self.isDemo = NO;
}


#pragma mark - Consultant Data Provider

- (Boolean)authenticateConsultant:(NSString *)username withPassword:(NSString *)password
{
    return YES;
}

- (Consultant *)getConsultantByUsername:(NSString *)username
{
    NSManagedObjectContext *moc = [self managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Consultant"
                                                         inManagedObjectContext:moc];
    [request setEntity:entityDescription];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"username == %@", username];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:request error:&error];
    [request release];
    
    NSLog(@"data provider: getConsultantByUsername(%@); result: %i", username, [results count]);
    
    if (results == nil)
    {
        NSLog(@"data provider error: getConsultantByUsername(%@)", username);
        return nil;
    } else if ([results count] > 0) {
        return [results objectAtIndex:0];
    } else {
        return nil;
    }
}

- (Consultant *)getConsultantByID:(NSInteger)consultantID
{
    NSManagedObjectContext *moc = [self managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Consultant"
                                                         inManagedObjectContext:moc];
    [request setEntity:entityDescription];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"consultantID == %i", consultantID];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:request error:&error];
    [request release];
    
    NSLog(@"data provider: getConsultantByID(%i); result: %i", consultantID, [results count]);
    
    if (results == nil)
    {
        NSLog(@"data provider error: getConsultantByID(%i)", consultantID);
        return nil;
    } else if ([results count] > 0) {
        return [results objectAtIndex:0];
    } else {
        return nil;
    }
}


#pragma mark - Client Data Provider

- (Client *)getClientByID:(NSInteger)clientID
{
    NSManagedObjectContext *moc = [self managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Client"
                                                         inManagedObjectContext:moc];
    [request setEntity:entityDescription];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"clientID == %i", clientID];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:request error:&error];
    [request release];
    
    NSLog(@"data provider: getClientByID(%i); result: %i", clientID, [results count]);
    
    if (results == nil)
    {
        NSLog(@"data provider error: getClientByID(%i)", clientID);
        return nil;
    } else if ([results count] > 0) {
        return [results objectAtIndex:0];
    } else {
        return nil;
    }
}

- (NSArray *)getAllClients
{
    NSManagedObjectContext *moc = [self managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Client"
                                                         inManagedObjectContext:moc];
    [request setEntity:entityDescription];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"sequence" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    [sortDescriptor release];
    
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:request error:&error];
    [request release];
    
    NSLog(@"data provider: getAllClients; result: %i", [results count]);
    
    if (results == nil)
    {
        NSLog(@"data provider error: getAllClients");
        return nil;
    }
    
    return results;
}

- (NSArray *)getClientsByType:(NSInteger)clientType ofConsultant:(Consultant *)consultant
{
    NSArray *results = nil;
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"history.@max.date" ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];

    if (clientType == 0) {
        results = [consultant.clients sortedArrayUsingDescriptors:sortDescriptors];
    } else if (clientType == 1) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.starred.boolValue == YES"];
        NSSet *clients = [consultant.clients filteredSetUsingPredicate:predicate];
        results = [clients sortedArrayUsingDescriptors:sortDescriptors];
    } else if (clientType == 2) { 
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.orders.@count == 0 && SELF.purchases.@count == 0"];
        NSSet *clients = [consultant.clients filteredSetUsingPredicate:predicate];
        results = [clients sortedArrayUsingDescriptors:sortDescriptors];        
    } else if (clientType == 3) { 
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.orders.@count > 0"];
        NSSet *clients = [consultant.clients filteredSetUsingPredicate:predicate];
        results = [clients sortedArrayUsingDescriptors:sortDescriptors];        
    } else if (clientType == 4) { 
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.purchases.@count > 0"];
        NSSet *clients = [consultant.clients filteredSetUsingPredicate:predicate];
        results = [clients sortedArrayUsingDescriptors:sortDescriptors];        
    } else if (clientType == 5) { 
        NSArray *allClients = [self getAllClients];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.consultant.consultantID.intValue != %i", consultant.consultantID.intValue];
        NSArray *clients = [allClients filteredArrayUsingPredicate:predicate];
        results = [clients sortedArrayUsingDescriptors:sortDescriptors];
    }
    
    [sortDescriptors release];
    [sortDescriptor release];
    return results;
}

- (Client *)clientWithName:(NSString *)name andPhone:(NSString *)phone andSex:(NSInteger)sex ofConsultant:(Consultant *)consultant
{
    NSManagedObjectContext *moc = [self managedObjectContext];
    Client *newClient = [NSEntityDescription insertNewObjectForEntityForName:@"Client"
                                                      inManagedObjectContext:moc];
    newClient.phone = phone;
    newClient.name = name;
    newClient.sex = [NSNumber numberWithInt:sex];
    newClient.consultant = consultant;
    
    [self saveContext];
    
    return newClient;
}


#pragma mark - Profile Data Provider
- (Profile *)getProfileByID:(NSInteger)profileID
{
    NSManagedObjectContext *moc = [self managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Profile"
                                                         inManagedObjectContext:moc];
    [request setEntity:entityDescription];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"profileID == %i", profileID];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:request error:&error];
    [request release];
    
    NSLog(@"data provider: getProfileByID(%i); result: %i", profileID, [results count]);
    
    if (results == nil)
    {
        NSLog(@"data provider error: getProfileByID(%i)", profileID);
        return nil;
    } else if ([results count] > 0) {
        return [results objectAtIndex:0];
    } else {
        return nil;
    }

}

- (NSArray *)getAllProfiles
{
    NSManagedObjectContext *moc = [self managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Profile"
                                                         inManagedObjectContext:moc];
    [request setEntity:entityDescription];
    
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:request error:&error];
    [request release];
    
    NSLog(@"data provider: getAllProfiles; result: %i", [results count]);
    
    if (results == nil)
    {
        NSLog(@"data provider error: getAllProfiles");
        return nil;
    }
    
    return results;
}

- (ClientProfile *)getClientProfile:(Profile *)profile ofClient:(Client *)client
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.profile.profileID=%@", profile.profileID];
    NSSet *clientProfiles = [client.clientProfiles filteredSetUsingPredicate:predicate];
    return [clientProfiles anyObject];
}



#pragma mark - House Data Provider

- (House *)getHouseByID:(NSInteger)houseID
{
    NSManagedObjectContext *moc = [self managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"House"
                                                         inManagedObjectContext:moc];
    [request setEntity:entityDescription];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"houseID == %i", houseID];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:request error:&error];
    [request release];
    
    NSLog(@"data provider: getHouseByID(%i); result: %i", houseID, [results count]);
    
    if (results == nil)
    {
        NSLog(@"data provider error: getClientByID(%i)", houseID);
        return nil;
    } else if ([results count] > 0) {
        return [results objectAtIndex:0];
    } else {
        return nil;
    }
}

- (NSSet *)getOnSaleHousesOfLayout:(Layout *)layout
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"status == 1"];
    return [layout.houses filteredSetUsingPredicate:predicate];
}


#pragma mark - Layout Data Provider

- (Layout *)getLayoutByID:(NSInteger)layoutID
{
    NSManagedObjectContext *moc = [self managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Layout"
                                                         inManagedObjectContext:moc];
    [request setEntity:entityDescription];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"layoutID == %i", layoutID];
    [request setPredicate:predicate];
        
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:request error:&error];
    [request release];
    
    NSLog(@"data provider: getLayoutByID(%i); result: %i", layoutID, [results count]);
    
    if (results == nil)
    {
        NSLog(@"data provider error: getLayoutByID(%i)", layoutID);
        return nil;
    } else if ([results count] > 0) {
        return [results objectAtIndex:0];
    } else {
        return nil;
    }
}

- (NSArray *)getLayouts
{
    NSManagedObjectContext *moc = [self managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Layout"
                                                         inManagedObjectContext:moc];
    [request setEntity:entityDescription];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"layoutID" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    [sortDescriptor release];
        
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:request error:&error];
    [request release];
    
    NSLog(@"data provider: getLayouts; result: %i", [results count]);
    
    if (results == nil)
    {
        NSLog(@"data provider error: getLayouts");
        return nil;
    }else {
        return results;
    }
}


#pragma mark - Position Data Provider

- (Position *)getPositionByID:(NSInteger)positionID
{
    NSManagedObjectContext *moc = [self managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Position"
                                                         inManagedObjectContext:moc];
    [request setEntity:entityDescription];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"positionID == %i", positionID];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:request error:&error];
    [request release];
    
    NSLog(@"data provider: getPositionByID(%i); result: %i", positionID, [results count]);
    
    if (results == nil)
    {
        NSLog(@"data provider error: getPositionByID(%i)", positionID);
        return nil;
    } else if ([results count] > 0) {
        return [results objectAtIndex:0];
    } else {
        return nil;
    }

}


#pragma mark - History Data Provider

- (History *)getHistoryByID:(NSInteger)historyID
{
    NSManagedObjectContext *moc = [self managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"History"
                                                         inManagedObjectContext:moc];
    [request setEntity:entityDescription];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"historyID == %i", historyID];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:request error:&error];
    [request release];
    
    NSLog(@"data provider: getHistoryByID(%i); result: %i", historyID, [results count]);
    
    if (results == nil)
    {
        NSLog(@"data provider error: getHistoryByID(%i)", historyID);
        return nil;
    } else if ([results count] > 0) {
        return [results objectAtIndex:0];
    } else {
        return nil;
    }
}

- (History *)getHistoryByDate:(NSDate *)date
{
    NSManagedObjectContext *moc = [self managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"History"
                                                         inManagedObjectContext:moc];
    [request setEntity:entityDescription];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"date == %@", date];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:request error:&error];
    [request release];
    
    NSLog(@"data provider: getHistoryByDate(%@); result: %u", date, results.count);
    
    if (results == nil)
    {
        NSLog(@"data provider error: getHistoryByDate(%@)", date);
        return nil;
    } else if ([results count] > 0) {
        return [results objectAtIndex:0];
    } else {
        return nil;
    }
}

- (History *)historyOfClient:(Client *)client withAction:(NSInteger)action andTarget:(id)target
{
    NSDate *now = [NSDate date];
    NSUInteger theUnitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSTimeZone *timezone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [calendar setTimeZone:timezone];
    NSDateComponents* dateComps = [calendar components:theUnitFlags fromDate:now];
    [dateComps setHour:0];
    [dateComps setMinute:0];
    [dateComps setSecond:0];
    NSDate* date = [calendar dateFromComponents:dateComps];
    
    History *history = [self getHistoryByDate:date];
    
    if (history == nil) {
        NSManagedObjectContext *moc = [self managedObjectContext];
        history = [NSEntityDescription insertNewObjectForEntityForName:@"History"
                                                          inManagedObjectContext:moc];
        history.action = [NSNumber numberWithInteger:action];
        history.date = date;
        history.client = client;
    }
    
    if (history.action.intValue == action) {
        NSString *targetKey;
        if (action == 0) {
            targetKey = @"layouts";
        } else {
            targetKey = @"houses";
        }
        
        NSMutableSet *targets = [history mutableSetValueForKey:targetKey];
        [targets addObject:target];
    } else if (history.action.intValue < action) {
        history.action = [NSNumber numberWithInteger:action];
        
        NSMutableSet *layouts = [history mutableSetValueForKey:@"layouts"];
        [layouts removeAllObjects];
        NSMutableSet *houses = [history mutableSetValueForKey:@"houses"];
        [houses addObject:target];
    } else {
        return nil;
    }
    
    return history;
}


@end
