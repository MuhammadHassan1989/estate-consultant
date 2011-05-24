//
//  Client.h
//  EstateConsultant
//
//  Created by farthinker on 5/17/11.
//  Copyright (c) 2011 mycolorway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ClientProfile, Consultant, History, House;

@interface Client : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSNumber * sex;
@property (nonatomic, retain) NSNumber * starred;
@property (nonatomic, retain) NSString * comment;
@property (nonatomic, retain) NSNumber * clientID;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet* follows;
@property (nonatomic, retain) NSSet* clientProfiles;
@property (nonatomic, retain) NSSet* purchases;
@property (nonatomic, retain) Consultant * consultant;
@property (nonatomic, retain) NSSet* history;
@property (nonatomic, retain) NSSet* orders;

@end
