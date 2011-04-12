//
//  LayoutItemView.h
//  EstateConsultant
//
//  Created by farthinker on 4/9/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataProvider.h"

@interface LayoutItemView : UIView {
}

@property (nonatomic, retain) Layout *layout;
@property (nonatomic, assign) Boolean selected;
@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UILabel *areaLabel;
@property (nonatomic, retain) IBOutlet UILabel *onSaleCountLabel;
@property (nonatomic, retain) IBOutlet UIImageView *arrowImage;


@end
