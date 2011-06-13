//
//  Building.m
//  EstateConsultant
//
//  Created by farthinker on 6/9/11.
//  Copyright (c) 2011 mycolorway. All rights reserved.
//

#import "Building.h"
#import "Batch.h"
#import "Unit.h"


@implementation Building
@dynamic number;
@dynamic buildingID;
@dynamic batch;
@dynamic units;


- (void)addUnitsObject:(Unit *)value {    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"units" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"units"] addObject:value];
    [self didChangeValueForKey:@"units" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)removeUnitsObject:(Unit *)value {
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"units" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"units"] removeObject:value];
    [self didChangeValueForKey:@"units" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)addUnits:(NSSet *)value {    
    [self willChangeValueForKey:@"units" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"units"] unionSet:value];
    [self didChangeValueForKey:@"units" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

- (void)removeUnits:(NSSet *)value {
    [self willChangeValueForKey:@"units" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"units"] minusSet:value];
    [self didChangeValueForKey:@"units" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}


@end
