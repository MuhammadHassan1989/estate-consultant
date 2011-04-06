//
//  Layout.m
//  EstateConsultant
//
//  Created by farthinker on 4/5/11.
//  Copyright (c) 2011 mycolorway. All rights reserved.
//

#import "Layout.h"
#import "Client.h"
#import "House.h"


@implementation Layout
@dynamic area;
@dynamic pics;
@dynamic layoutID;
@dynamic name;
@dynamic desc;
@dynamic houses;
@dynamic followers;

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
