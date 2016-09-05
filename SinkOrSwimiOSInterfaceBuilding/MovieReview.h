//
//  MovieReview.h
//  SinkOrSwimiOSInterfaceBuilding
//
//  Created by Jenn Le on 9/3/16.
//  Copyright © 2016 Mobile Design Group. All rights reserved.
//

#ifndef MovieReview_h
#define MovieReview_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MovieReview : NSObject

-(MovieReview*)initWithEverything: (NSString*)reviewTitle: (NSInteger) movieRating: (NSString*)description;

-(NSString*)getTitle;
-(NSInteger)getRating;
-(NSString*)getDescription;

@end

#endif /* MovieReview_h */
