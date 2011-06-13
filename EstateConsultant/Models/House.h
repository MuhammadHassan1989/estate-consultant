//
//  House.h
//  EstateConsultant
//
//  Created by farthinker on 6/9/11.
//  Copyright (c) 2011 mycolorway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Client, History, Layout, Position;

@interface House : NSManagedObject {
@private
}
@property (nonatomic, retain) NSNumber * status;
@property (nonatomic, retain) NSNumber * houseID;
@property (nonatomic, retain) NSNumber * floor;
@property (nonatomic, retain) NSNumber * price;
@property (nonatomic, retain) NSString * num;
@property (nonatomic, retain) NSSet* history;
@property (nonatomic, retain) Layout * layout;
@property (nonatomic, retain) NSSet* followers;
@property (nonatomic, retain) Position * position;

@end
