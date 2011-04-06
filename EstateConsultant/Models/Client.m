//
//  Client.m
//  EstateConsultant
//
//  Created by farthinker on 4/5/11.
//  Copyright (c) 2011 mycolorway. All rights reserved.
//

#import "Client.h"
#import "Consultant.h"
#import "House.h"
#import "Layout.h"


@implementation Client
@dynamic phone;
@dynamic name;
@dynamic estateType;
@dynamic sex;
@dynamic clientID;
@dynamic date;
@dynamic wishes;
@dynamic purchases;
@dynamic consultant;
@dynamic orders;
@dynamic follows;

- (void)addWishesObject:(House *)value {    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"wishes" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"wishes"] addObject:value];
    [self didChangeValueForKey:@"wishes" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)removeWishesObject:(House *)value {
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"wishes" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"wishes"] removeObject:value];
    [self didChangeValueForKey:@"wishes" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)addWishes:(NSSet *)value {    
    [self willChangeValueForKey:@"wishes" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"wishes"] unionSet:value];
    [self didChangeValueForKey:@"wishes" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

- (void)removeWishes:(NSSet *)value {
    [self willChangeValueForKey:@"wishes" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"wishes"] minusSet:value];
    [self didChangeValueForKey:@"wishes" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
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


- (void)addFollowsObject:(Layout *)value {    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"follows" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"follows"] addObject:value];
    [self didChangeValueForKey:@"follows" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)removeFollowsObject:(Layout *)value {
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


@end
