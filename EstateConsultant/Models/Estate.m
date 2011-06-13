//
//  Estate.m
//  EstateConsultant
//
//  Created by farthinker on 6/9/11.
//  Copyright (c) 2011 mycolorway. All rights reserved.
//

#import "Estate.h"
#import "Batch.h"
#import "Consultant.h"
#import "Profile.h"


@implementation Estate
@dynamic estateID;
@dynamic name;
@dynamic consultants;
@dynamic profiles;
@dynamic batches;

- (void)addConsultantsObject:(Consultant *)value {    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"consultants" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"consultants"] addObject:value];
    [self didChangeValueForKey:@"consultants" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)removeConsultantsObject:(Consultant *)value {
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"consultants" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"consultants"] removeObject:value];
    [self didChangeValueForKey:@"consultants" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)addConsultants:(NSSet *)value {    
    [self willChangeValueForKey:@"consultants" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"consultants"] unionSet:value];
    [self didChangeValueForKey:@"consultants" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

- (void)removeConsultants:(NSSet *)value {
    [self willChangeValueForKey:@"consultants" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"consultants"] minusSet:value];
    [self didChangeValueForKey:@"consultants" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}


- (void)addProfilesObject:(Profile *)value {    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"profiles" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"profiles"] addObject:value];
    [self didChangeValueForKey:@"profiles" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)removeProfilesObject:(Profile *)value {
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"profiles" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"profiles"] removeObject:value];
    [self didChangeValueForKey:@"profiles" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)addProfiles:(NSSet *)value {    
    [self willChangeValueForKey:@"profiles" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"profiles"] unionSet:value];
    [self didChangeValueForKey:@"profiles" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

- (void)removeProfiles:(NSSet *)value {
    [self willChangeValueForKey:@"profiles" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"profiles"] minusSet:value];
    [self didChangeValueForKey:@"profiles" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}


- (void)addBatchesObject:(Batch *)value {    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"batches" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"batches"] addObject:value];
    [self didChangeValueForKey:@"batches" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)removeBatchesObject:(Batch *)value {
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"batches" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"batches"] removeObject:value];
    [self didChangeValueForKey:@"batches" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)addBatches:(NSSet *)value {    
    [self willChangeValueForKey:@"batches" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"batches"] unionSet:value];
    [self didChangeValueForKey:@"batches" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

- (void)removeBatches:(NSSet *)value {
    [self willChangeValueForKey:@"batches" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"batches"] minusSet:value];
    [self didChangeValueForKey:@"batches" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}


@end
