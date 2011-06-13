//
//  Estate.h
//  EstateConsultant
//
//  Created by farthinker on 6/9/11.
//  Copyright (c) 2011 mycolorway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Batch, Consultant, Profile;

@interface Estate : NSManagedObject {
@private
}
@property (nonatomic, retain) NSNumber * estateID;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet* consultants;
@property (nonatomic, retain) NSSet* profiles;
@property (nonatomic, retain) NSSet* batches;

@end
