//
//  Movies.m
//  RottenMangoes
//
//  Created by Adam DesLauriers on 2016-02-01.
//  Copyright © 2016 Adam DesLauriers. All rights reserved.
//

#import "Movies.h"

@implementation Movies

- (instancetype)initWithName:(NSString*)movieName image:(NSURL*)movieImage andURL:(NSURL*)reviewsURL
{
    self = [super init];
    if (self) {
        self.movieName = movieName;
        self.movieImage = movieImage;
        self.reviewsUrl = reviewsURL;
    }
    return self;
}

@end
