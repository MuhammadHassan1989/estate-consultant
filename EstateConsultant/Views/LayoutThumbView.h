//
//  LayoutThumbView.h
//  EstateConsultant
//
//  Created by farthinker on 4/7/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LayoutThumbView : UIView {
}

@property (nonatomic, retain) NSDictionary *layoutInfo;
@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UIImageView *thumbImage;
@property (nonatomic, retain) IBOutlet UIImageView *statusImage;

@end
