//
//  Profile.h
//  EstateConsultant
//
//  Created by farthinker on 6/9/11.
//  Copyright (c) 2011 mycolorway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ClientProfile, Estate;

@interface Profile : NSManagedObject {
@private
}
@property (nonatomic, retain) NSNumber * profileID;
@property (nonatomic, retain) NSString * defaultValue;
@property (nonatomic, retain) NSNumber * sequence;
@property (nonatomic, retain) NSString * meta;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Estate * estate;
@property (nonatomic, retain) NSSet* clientProfiles;

@end
