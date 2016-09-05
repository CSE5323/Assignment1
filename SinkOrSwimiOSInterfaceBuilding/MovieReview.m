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

@property (strong,nonatomic) NSString* title;
@property (nonatomic) NSInteger rating;
@property (strong,nonatomic) NSString* descrip;

@end
@implementation MovieReview

-(MovieReview*)initWithEverything: (NSString*)reviewTitle: (NSInteger) movieRating: (NSString*)description {
    self = [super init];
    if (self) {
        self.title = reviewTitle;
        self.rating = movieRating;
        self.descrip = description;
    }
    return self;
}

-(NSString*) title {
    if(!_title)
        _title = @"";
    return _title;
}

-(NSInteger) rating {
    if(!_rating)
        _rating = 0;
    return _rating;
}

-(NSString*) descrip {
    if(!_descrip)
        _descrip = @"";
    return _descrip;
}

-(NSString*) getTitle {
    return self.title;
}

-(NSInteger) getRating {
    return self.rating;
}

-(NSString*) getDescription {
    return self.descrip;
}

@end