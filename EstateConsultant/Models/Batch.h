//
//  Batch.h
//  EstateConsultant
//
//  Created by farthinker on 6/9/11.
//  Copyright (c) 2011 mycolorway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Building, Estate, Layout;

@interface Batch : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * active;
@property (nonatomic, retain) NSNumber * batchID;
@property (nonatomic, retain) NSSet* buildings;
@property (nonatomic, retain) NSSet* layouts;
@property (nonatomic, retain) Estate * estate;

@end
