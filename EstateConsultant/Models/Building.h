//
//  Building.h
//  EstateConsultant
//
//  Created by farthinker on 6/9/11.
//  Copyright (c) 2011 mycolorway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Batch, Unit;

@interface Building : NSManagedObject {
@private
}
@property (nonatomic, retain) NSNumber * number;
@property (nonatomic, retain) NSNumber * buildingID;
@property (nonatomic, retain) Batch * batch;
@property (nonatomic, retain) NSSet* units;

@end
