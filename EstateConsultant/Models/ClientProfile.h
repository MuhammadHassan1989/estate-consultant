//
//  ClientProfile.h
//  EstateConsultant
//
//  Created by farthinker on 5/12/11.
//  Copyright (c) 2011 mycolorway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Client, Profile;

@interface ClientProfile : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * value;
@property (nonatomic, retain) Client * client;
@property (nonatomic, retain) Profile * profile;

@end
