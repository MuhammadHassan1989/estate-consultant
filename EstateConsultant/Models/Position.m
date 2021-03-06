//
//  Position.m
//  EstateConsultant
//
//  Created by farthinker on 6/9/11.
//  Copyright (c) 2011 mycolorway. All rights reserved.
//

#import "Position.h"
#import "House.h"
#import "Unit.h"


@implementation Position
@dynamic name;
@dynamic positionID;
@dynamic houses;
@dynamic unit;

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



@end
