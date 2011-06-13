//
//  Unit.h
//  EstateConsultant
//
//  Created by farthinker on 6/9/11.
//  Copyright (c) 2011 mycolorway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Building, Position;

@interface Unit : NSManagedObject {
@private
}
@property (nonatomic, retain) NSNumber * number;
@property (nonatomic, retain) NSNumber * unitID;
@property (nonatomic, retain) Building * building;
@property (nonatomic, retain) NSSet* positions;

@end
