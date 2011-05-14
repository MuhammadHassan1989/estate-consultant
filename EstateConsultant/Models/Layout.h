//
//  Layout.h
//  EstateConsultant
//
//  Created by farthinker on 5/12/11.
//  Copyright (c) 2011 mycolorway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class House;

@interface Layout : NSManagedObject {
@private
}
@property (nonatomic, retain) NSNumber * area;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSNumber * layoutID;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * pics;
@property (nonatomic, retain) NSSet* houses;

@end
