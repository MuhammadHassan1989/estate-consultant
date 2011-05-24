//
//  House.m
//  EstateConsultant
//
//  Created by farthinker on 5/17/11.
//  Copyright (c) 2011 mycolorway. All rights reserved.
//

#import "House.h"
#import "Client.h"
#import "History.h"
#import "Layout.h"
#import "Position.h"


@implementation House
@dynamic status;
@dynamic houseID;
@dynamic floor;
@dynamic price;
@dynamic num;
@dynamic history;
@dynamic layout;
@dynamic followers;
@dynamic orderer;
@dynamic position;
@dynamic purchaser;

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



- (void)addFollowersObject:(Client *)value {    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"followers" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"followers"] addObject:value];
    [self didChangeValueForKey:@"followers" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)removeFollowersObject:(Client *)value {
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"followers" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"followers"] removeObject:value];
    [self didChangeValueForKey:@"followers" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)addFollowers:(NSSet *)value {    
    [self willChangeValueForKey:@"followers" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"followers"] unionSet:value];
    [self didChangeValueForKey:@"followers" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

- (void)removeFollowers:(NSSet *)value {
    [self willChangeValueForKey:@"followers" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"followers"] minusSet:value];
    [self didChangeValueForKey:@"followers" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}





@end
