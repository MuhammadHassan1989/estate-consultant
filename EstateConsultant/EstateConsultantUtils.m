//
//  EstateConsultantUtils.m
//  EstateConsultant
//
//  Created by farthinker on 3/31/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import "EstateConsultantUtils.h"
#import "EstateConsultantAppDelegate.h"

static EstateConsultantUtils *sharedUtils = nil;

@implementation EstateConsultantUtils

+ (EstateConsultantUtils *)sharedUtils
{
    if (sharedUtils == nil) {
        sharedUtils = [[super allocWithZone:NULL] init];
    }
    return sharedUtils;
}


#pragma mark - Overrides for Singleton

+ (id)allocWithZone:(NSZone *)zone
{
    return [[self sharedUtils] retain];
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (id)retain
{
    return self;
}

- (NSUInteger)retainCount
{
    return NSUIntegerMax;  //denotes an object that cannot be released
}

- (void)release
{
    //do nothing
}

- (id)autorelease
{
    return self;
}


#pragma mark - Utilities

- (NSURL *)documentsURL
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


@end
