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
    if (_isDemo) {
        if (_demoManagedObjectContext != nil)
        {
            return _demoManagedObjectContext;
        }
        
        NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
        if (coordinator != nil)
        {
            _demoManagedObjectContext = [[NSManagedObjectContext alloc] init];
            [_demoManagedObjectContext setPersistentStoreCoordinator:coordinator];
        }
        return _demoManagedObjectContext;
        
    } else {
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
    if (_isDemo) {
        if (_demoPersistentStoreCoordinator != nil)
        {
            return _demoPersistentStoreCoordinator;
        }
        
        NSURL *storeURL = [[[EstateConsultantUtils sharedUtils] documentsURL] URLByAppendingPathComponent:@"EstateConsultantDemo.sqlite"];
        
        NSError *error = nil;
        _demoPersistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
        if (![_demoPersistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
        {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }    
        
        return _demoPersistentStoreCoordinator;
        
    } else {
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
}

- (void)setIsDemo:(Boolean)isDemo
{
    if (isDemo == _isDemo) {
        return;
    }
    
    [self saveContext];
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
    }
}

- (void)loadDemoData
{
    NSURL *documentsURL = [[EstateConsultantUtils sharedUtils] documentsURL];
    NSURL *storeURL = [documentsURL URLByAppendingPathComponent:@"EstateConsultantDemo.sqlite"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:[storeURL path]]) {
		self.isDemo = YES;
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
        
        // position data
        NSString *positionFile = [[NSBundle mainBundle] pathForResource:@"Position.plist" ofType:nil];
        NSArray *positions = [[NSArray alloc] initWithContentsOfFile:positionFile];
        for (NSDictionary *position in positions) {
            Position *newPosition = [NSEntityDescription insertNewObjectForEntityForName:@"Position"
                                                            inManagedObjectContext:moc];
            newPosition.name = [position valueForKey:@"name"];
            newPosition.positionID = [position valueForKey:@"positionID"];
        }
        
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
        
        // history data
        NSString *historyFile = [[NSBundle mainBundle] pathForResource:@"History.plist" ofType:nil];
        NSArray *histories = [[NSArray alloc] initWithContentsOfFile:historyFile];
        for (NSDictionary *history in histories) {
            History *newHistory = [NSEntityDescription insertNewObjectForEntityForName:@"History"
                                                                inManagedObjectContext:moc];
            newHistory.historyID = [history valueForKey:@"id"];
            newHistory.clientID = [history valueForKey:@"client"];
            newHistory.date = [history valueForKey:@"date"];
            newHistory.action = [history valueForKey:@"action"];
            newHistory.target = [history valueForKey:@"target"];
        }
        
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
        
        // client data
        NSString *clientsFile = [[NSBundle mainBundle] pathForResource:@"Client.plist" ofType:nil];
        NSArray *clients = [[NSArray alloc] initWithContentsOfFile:clientsFile];
        for (NSDictionary *client in clients) {
            Client *newClient = [NSEntityDescription insertNewObjectForEntityForName:@"Client"
                                                              inManagedObjectContext:moc];
            newClient.clientID = [client valueForKey:@"id"];
            newClient.phone = [client valueForKey:@"phone"];
            newClient.estateType = [client valueForKey:@"estateType"];
            newClient.name = [client valueForKey:@"name"];
            newClient.sex = [client valueForKey:@"sex"];
            newClient.date = [client valueForKey:@"date"];
            newClient.consultant = [self getConsultantByID:[[client valueForKey:@"consultant"] intValue]];
            
            NSArray* followIDs = [client valueForKey:@"follows"];
            NSMutableSet *followSet = [[NSMutableSet alloc] initWithCapacity:followIDs.count];
            for (NSNumber *followID in followIDs) {
                [followSet addObject:[self getLayoutByID:[followID intValue]]];
            }
            newClient.follows = followSet;
            
            NSArray* wishIDs = [client valueForKey:@"wishes"];
            NSMutableSet *wishSet = [[NSMutableSet alloc] initWithCapacity:wishIDs.count];
            for (NSNumber *wishID in wishIDs) {
                [wishSet addObject:[self getHouseByID:[wishID intValue]]];
            }
            newClient.wishes = wishSet;
            
            NSArray* orderIDs = [client valueForKey:@"orders"];
            NSMutableSet *orderSet = [[NSMutableSet alloc] initWithCapacity:orderIDs.count];
            for (NSNumber *orderID in orderIDs) {
                [orderSet addObject:[self getHouseByID:[orderID intValue]]];
            }
            newClient.orders = orderSet;
            
            NSArray* purchaseIDs = [client valueForKey:@"purchases"];
            NSMutableSet *purchaseSet = [[NSMutableSet alloc] initWithCapacity:purchaseIDs.count];
            for (NSNumber *purchaseID in purchaseIDs) {
                [purchaseSet addObject:[self getHouseByID:[purchaseID intValue]]];
            }
            newClient.purchases = purchaseSet;
        }
                
        self.isDemo = NO;
		NSLog(@"demo data loaded");
	}

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


#pragma mark - Layout Data Provider

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


@end
