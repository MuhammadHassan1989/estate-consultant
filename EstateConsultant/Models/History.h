//
//  History.h
//  EstateConsultant
//
//  Created by farthinker on 4/5/11.
//  Copyright (c) 2011 mycolorway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface History : NSManagedObject {
@private
}
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * historyID;
@property (nonatomic, retain) NSNumber * clientID;
@property (nonatomic, retain) NSNumber * target;
@property (nonatomic, retain) NSNumber * action;

@end
