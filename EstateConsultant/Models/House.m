//
//  House.m
//  EstateConsultant
//
//  Created by farthinker on 4/5/11.
//  Copyright (c) 2011 mycolorway. All rights reserved.
//

#import "House.h"
#import "Client.h"
#import "Layout.h"
#import "Position.h"


@implementation House
@dynamic status;
@dynamic houseID;
@dynamic floor;
@dynamic price;
@dynamic num;
@dynamic position;
@dynamic wishers;
@dynamic orderer;
@dynamic layout;
@dynamic purchaser;


- (void)addWishersObject:(Client *)value {    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"wishers" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"wishers"] addObject:value];
    [self didChangeValueForKey:@"wishers" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)removeWishersObject:(Client *)value {
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"wishers" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"wishers"] removeObject:value];
    [self didChangeValueForKey:@"wishers" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)addWishers:(NSSet *)value {    
    [self willChangeValueForKey:@"wishers" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"wishers"] unionSet:value];
    [self didChangeValueForKey:@"wishers" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

- (void)removeWishers:(NSSet *)value {
    [self willChangeValueForKey:@"wishers" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"wishers"] minusSet:value];
    [self didChangeValueForKey:@"wishers" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}





@end
