//
//  Batch.m
//  EstateConsultant
//
//  Created by farthinker on 6/9/11.
//  Copyright (c) 2011 mycolorway. All rights reserved.
//

#import "Batch.h"
#import "Building.h"
#import "Estate.h"
#import "Layout.h"


@implementation Batch
@dynamic name;
@dynamic active;
@dynamic batchID;
@dynamic buildings;
@dynamic layouts;
@dynamic estate;

- (void)addBuildingsObject:(Building *)value {    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"buildings" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"buildings"] addObject:value];
    [self didChangeValueForKey:@"buildings" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)removeBuildingsObject:(Building *)value {
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"buildings" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"buildings"] removeObject:value];
    [self didChangeValueForKey:@"buildings" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)addBuildings:(NSSet *)value {    
    [self willChangeValueForKey:@"buildings" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"buildings"] unionSet:value];
    [self didChangeValueForKey:@"buildings" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

- (void)removeBuildings:(NSSet *)value {
    [self willChangeValueForKey:@"buildings" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"buildings"] minusSet:value];
    [self didChangeValueForKey:@"buildings" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
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
