//
//  Profile.h
//  EstateConsultant
//
//  Created by farthinker on 5/17/11.
//  Copyright (c) 2011 mycolorway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ClientProfile;

@interface Profile : NSManagedObject {
@private
}
@property (nonatomic, retain) NSNumber * profileID;
@property (nonatomic, retain) NSString * defaultValue;
@property (nonatomic, retain) NSNumber * sequence;
@property (nonatomic, retain) NSString * meta;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet* clientProfiles;

@end
