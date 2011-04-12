//
//  History.m
//  EstateConsultant
//
//  Created by farthinker on 4/10/11.
//  Copyright (c) 2011 mycolorway. All rights reserved.
//

#import "History.h"
#import "Client.h"
#import "House.h"
#import "Layout.h"


@implementation History
@dynamic historyID;
@dynamic date;
@dynamic action;
@dynamic houses;
@dynamic layouts;
@dynamic client;

- (void)addHousesObject:(House *)value {    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"houses" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"houses"] addObject:value];
    [self didChangeValueForKey:@"houses" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)removeHousesObject:(House *)value {
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"houses" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"houses"] removeObject:value];
    [self didChangeValueForKey:@"houses" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)addHouses:(NSSet *)value {    
    [self willChangeValueForKey:@"houses" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"houses"] unionSet:value];
    [self didChangeValueForKey:@"houses" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

- (void)removeHouses:(NSSet *)value {
    [self willChangeValueForKey:@"houses" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"houses"] minusSet:value];
    [self didChangeValueForKey:@"houses" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}


- (void)addLayoutsObject:(Layout *)value {    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"layouts" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"layouts"] addObject:value];
    [self didChangeValueForKey:@"layouts" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)removeLayoutsObject:(Layout *)value {
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"layouts" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"layouts"] removeObject:value];
    [self didChangeValueForKey:@"layouts" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)addLayouts:(NSSet *)value {    
    [self willChangeValueForKey:@"layouts" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"layouts"] unionSet:value];
    [self didChangeValueForKey:@"layouts" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

- (void)removeLayouts:(NSSet *)value {
    [self willChangeValueForKey:@"layouts" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"layouts"] minusSet:value];
    [self didChangeValueForKey:@"layouts" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}



@end
