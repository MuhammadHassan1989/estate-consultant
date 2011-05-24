//
//  Client.m
//  EstateConsultant
//
//  Created by farthinker on 5/17/11.
//  Copyright (c) 2011 mycolorway. All rights reserved.
//

#import "Client.h"
#import "ClientProfile.h"
#import "Consultant.h"
#import "History.h"
#import "House.h"


@implementation Client
@dynamic phone;
@dynamic sex;
@dynamic starred;
@dynamic comment;
@dynamic clientID;
@dynamic name;
@dynamic follows;
@dynamic clientProfiles;
@dynamic purchases;
@dynamic consultant;
@dynamic history;
@dynamic orders;

- (void)addFollowsObject:(House *)value {    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"follows" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"follows"] addObject:value];
    [self didChangeValueForKey:@"follows" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)removeFollowsObject:(House *)value {
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"follows" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"follows"] removeObject:value];
    [self didChangeValueForKey:@"follows" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)addFollows:(NSSet *)value {    
    [self willChangeValueForKey:@"follows" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"follows"] unionSet:value];
    [self didChangeValueForKey:@"follows" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

- (void)removeFollows:(NSSet *)value {
    [self willChangeValueForKey:@"follows" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"follows"] minusSet:value];
    [self didChangeValueForKey:@"follows" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}


- (void)addClientProfilesObject:(ClientProfile *)value {    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"clientProfiles" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"clientProfiles"] addObject:value];
    [self didChangeValueForKey:@"clientProfiles" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)removeClientProfilesObject:(ClientProfile *)value {
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"clientProfiles" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"clientProfiles"] removeObject:value];
    [self didChangeValueForKey:@"clientProfiles" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)addClientProfiles:(NSSet *)value {    
    [self willChangeValueForKey:@"clientProfiles" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"clientProfiles"] unionSet:value];
    [self didChangeValueForKey:@"clientProfiles" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

- (void)removeClientProfiles:(NSSet *)value {
    [self willChangeValueForKey:@"clientProfiles" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"clientProfiles"] minusSet:value];
    [self didChangeValueForKey:@"clientProfiles" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}


- (void)addPurchasesObject:(House *)value {    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"purchases" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"purchases"] addObject:value];
    [self didChangeValueForKey:@"purchases" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)removePurchasesObject:(House *)value {
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"purchases" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"purchases"] removeObject:value];
    [self didChangeValueForKey:@"purchases" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)addPurchases:(NSSet *)value {    
    [self willChangeValueForKey:@"purchases" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"purchases"] unionSet:value];
    [self didChangeValueForKey:@"purchases" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

- (void)removePurchases:(NSSet *)value {
    [self willChangeValueForKey:@"purchases" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"purchases"] minusSet:value];
    [self didChangeValueForKey:@"purchases" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}



- (void)addHistoryObject:(History *)value {    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"history" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"history"] addObject:value];
    [self didChangeValueForKey:@"history" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)removeHistoryObject:(History *)value {
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"history" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"history"] removeObject:value];
    [self didChangeValueForKey:@"history" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)addHistory:(NSSet *)value {    
    [self willChangeValueForKey:@"history" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"history"] unionSet:value];
    [self didChangeValueForKey:@"history" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

- (void)removeHistory:(NSSet *)value {
    [self willChangeValueForKey:@"history" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"history"] minusSet:value];
    [self didChangeValueForKey:@"history" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}


- (void)addOrdersObject:(House *)value {    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"orders" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"orders"] addObject:value];
    [self didChangeValueForKey:@"orders" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)removeOrdersObject:(House *)value {
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"orders" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"orders"] removeObject:value];
    [self didChangeValueForKey:@"orders" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)addOrders:(NSSet *)value {    
    [self willChangeValueForKey:@"orders" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"orders"] unionSet:value];
    [self didChangeValueForKey:@"orders" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

- (void)removeOrders:(NSSet *)value {
    [self willChangeValueForKey:@"orders" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"orders"] minusSet:value];
    [self didChangeValueForKey:@"orders" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}


@end
