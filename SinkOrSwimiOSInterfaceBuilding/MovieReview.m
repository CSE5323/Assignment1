//
//  MovieReview.m
//  SinkOrSwimiOSInterfaceBuilding
//
//  Created by Jenn Le on 9/3/16.
//  Copyright © 2016 Mobile Design Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MovieReview.h"

@interface MovieReview()



@end
@implementation MovieReview

-(MovieReview*)initWithEverything: (NSInteger)movieRating {
    self = [super init];
    if (self) {
        self.rating = movieRating;
    }
    return self;
}


@end