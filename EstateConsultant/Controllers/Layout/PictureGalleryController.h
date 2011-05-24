//
//  PictureGalleryController.h
//  EstateConsultant
//
//  Created by farthinker on 5/22/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PictureGalleryController : UIViewController <UIScrollViewDelegate> {
    UIScrollView *_scrollView;
    NSArray *_pictures;
    NSMutableArray *_pictureViews;
}

@property (nonatomic, retain) NSArray *pictures;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;

- (IBAction)closeGallery:(id)sender;
- (void)loadPicture:(NSInteger)page;

@end
