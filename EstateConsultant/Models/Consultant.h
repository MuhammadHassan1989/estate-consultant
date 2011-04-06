//
//  Consultant.h
//  EstateConsultant
//
//  Created by farthinker on 4/5/11.
//  Copyright (c) 2011 mycolorway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Client;

@interface Consultant : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSNumber * consultantID;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet* clients;

@end
