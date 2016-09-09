//
//  MoviesModel.h
//  SinkOrSwimiOSInterfaceBuilding
//
//  Created by Preston Tighe on 9/8/16.
//  Copyright © 2016 Mobile Design Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MoviesModel : NSObject

//Getters
-(NSString*)getMovieCategoryTitle;
-(NSInteger)getTotalNumOfMovies;
-(NSDictionary*)getMovieByIndex:(NSInteger)index;

//Setters
-(void)setCategory:(NSString*) category;

//Static instance
+(MoviesModel*) sharedInstance;

//Public properties
@property (copy, nonatomic) NSString *imagesBaseUrlString;
@property (nonatomic, assign) NSInteger maxNumberOfMovies;
@property (nonatomic, assign) NSInteger fontSize;

@end
