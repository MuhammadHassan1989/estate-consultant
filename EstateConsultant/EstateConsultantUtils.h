//
//  EstateConsultantUtils.h
//  EstateConsultant
//
//  Created by farthinker on 3/31/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface EstateConsultantUtils : NSObject {
    
}

@property (nonatomic, assign, readonly) NSURL *documentsURL;

+ (EstateConsultantUtils *)sharedUtils;

@end
