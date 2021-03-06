//
//  Layout.h
//  EstateConsultant
//
//  Created by farthinker on 6/9/11.
//  Copyright (c) 2011 mycolorway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Batch, House;

@interface Layout : NSManagedObject {
@private
}
@property (nonatomic, retain) NSNumber * floorArea;
@property (nonatomic, retain) NSString * pics;
@property (nonatomic, retain) NSNumber * layoutID;
@property (nonatomic, retain) NSNumber * poolArea;
@property (nonatomic, retain) NSNumber * actualArea;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet* houses;
@property (nonatomic, retain) Batch * batch;

@end
