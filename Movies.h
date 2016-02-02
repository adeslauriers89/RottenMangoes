//
//  Movies.h
//  RottenMangoes
//
//  Created by Adam DesLauriers on 2016-02-01.
//  Copyright © 2016 Adam DesLauriers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Movies : NSObject

@property (nonatomic) NSString *movieName;
@property (nonatomic) NSURL *movieImage;
@property (nonatomic) NSURL *reviewsUrl;

- (instancetype)initWithName:(NSString*)movieName image:(NSURL*)movieImage andURL:(NSURL*)reviewsURL;

@end
