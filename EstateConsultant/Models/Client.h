//
//  Client.h
//  EstateConsultant
//
//  Created by farthinker on 4/10/11.
//  Copyright (c) 2011 mycolorway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Consultant, History, House, Layout;

@interface Client : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * estateType;
@property (nonatomic, retain) NSNumber * sex;
@property (nonatomic, retain) NSNumber * clientID;
@property (nonatomic, retain) NSSet* wishes;
@property (nonatomic, retain) NSSet* purchases;
@property (nonatomic, retain) Consultant * consultant;
@property (nonatomic, retain) NSSet* orders;
@property (nonatomic, retain) NSSet* follows;
@property (nonatomic, retain) NSSet* history;

@end
