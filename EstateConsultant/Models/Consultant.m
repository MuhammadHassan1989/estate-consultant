//
//  Consultant.m
//  EstateConsultant
//
//  Created by farthinker on 4/10/11.
//  Copyright (c) 2011 mycolorway. All rights reserved.
//

#import "Consultant.h"
#import "Client.h"


@implementation Consultant
@dynamic username;
@dynamic password;
@dynamic consultantID;
@dynamic name;
@dynamic clients;

- (void)addClientsObject:(Client *)value {    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"clients" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"clients"] addObject:value];
    [self didChangeValueForKey:@"clients" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)removeClientsObject:(Client *)value {
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"clients" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"clients"] removeObject:value];
    [self didChangeValueForKey:@"clients" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)addClients:(NSSet *)value {    
    [self willChangeValueForKey:@"clients" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"clients"] unionSet:value];
    [self didChangeValueForKey:@"clients" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

- (void)removeClients:(NSSet *)value {
    [self willChangeValueForKey:@"clients" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"clients"] minusSet:value];
    [self didChangeValueForKey:@"clients" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}


@end
