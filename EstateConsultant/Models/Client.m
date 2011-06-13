//
//  Client.m
//  EstateConsultant
//
//  Created by farthinker on 6/9/11.
//  Copyright (c) 2011 mycolorway. All rights reserved.
//

#import "Client.h"
#import "ClientProfile.h"
#import "Consultant.h"
#import "History.h"
#import "House.h"


@implementation Client
@dynamic phone;
@dynamic comment;
@dynamic starred;
@dynamic clientID;
@dynamic sex;
@dynamic name;
@dynamic history;
@dynamic consultant;
@dynamic clientProfiles;
@dynamic follows;

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


@end
