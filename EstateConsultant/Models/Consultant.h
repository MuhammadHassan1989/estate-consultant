//
//  Consultant.h
//  EstateConsultant
//
//  Created by farthinker on 6/9/11.
//  Copyright (c) 2011 mycolorway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Client, Estate;

@interface Consultant : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSNumber * consultantID;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet* clients;
@property (nonatomic, retain) Estate * estate;

@end
