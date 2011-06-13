//
//  Position.h
//  EstateConsultant
//
//  Created by farthinker on 6/9/11.
//  Copyright (c) 2011 mycolorway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class House, Unit;

@interface Position : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * positionID;
@property (nonatomic, retain) NSSet* houses;
@property (nonatomic, retain) Unit * unit;

@end
