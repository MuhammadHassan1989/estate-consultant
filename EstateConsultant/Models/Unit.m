//
//  Unit.m
//  EstateConsultant
//
//  Created by farthinker on 6/9/11.
//  Copyright (c) 2011 mycolorway. All rights reserved.
//

#import "Unit.h"
#import "Building.h"
#import "Position.h"


@implementation Unit
@dynamic number;
@dynamic unitID;
@dynamic building;
@dynamic positions;


- (void)addPositionsObject:(Position *)value {    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"positions" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"positions"] addObject:value];
    [self didChangeValueForKey:@"positions" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)removePositionsObject:(Position *)value {
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"positions" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"positions"] removeObject:value];
    [self didChangeValueForKey:@"positions" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)addPositions:(NSSet *)value {    
    [self willChangeValueForKey:@"positions" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"positions"] unionSet:value];
    [self didChangeValueForKey:@"positions" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

- (void)removePositions:(NSSet *)value {
    [self willChangeValueForKey:@"positions" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"positions"] minusSet:value];
    [self didChangeValueForKey:@"positions" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}


@end
