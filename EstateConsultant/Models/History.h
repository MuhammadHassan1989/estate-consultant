//
//  History.h
//  EstateConsultant
//
//  Created by farthinker on 5/17/11.
//  Copyright (c) 2011 mycolorway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Client, House;

@interface History : NSManagedObject {
@private
}
@property (nonatomic, retain) NSNumber * historyID;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * action;
@property (nonatomic, retain) NSSet* houses;
@property (nonatomic, retain) Client * client;

@end
