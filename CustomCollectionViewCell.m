//
//  CustomCollectionViewCell.m
//  RottenMangoes
//
//  Created by Adam DesLauriers on 2016-02-01.
//  Copyright © 2016 Adam DesLauriers. All rights reserved.
//

#import "CustomCollectionViewCell.h"
#import "Movies.h"

@interface CustomCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *movieImageView;
@property (nonatomic) NSURLSessionDataTask *task;


@end

@implementation CustomCollectionViewCell

- (void)configureWithMovie:(Movies*)movie{
    
    
    NSURLSession *sharedSession = [NSURLSession sharedSession];
    
    
    self.movieImageView.image = nil;
    
    [self.task cancel];
    
    self.task = [sharedSession dataTaskWithURL:movie.movieImage completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        UIImage *image = [UIImage imageWithData:data];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.movieImageView.image = image;
        });
        
    }];
    
    [self.task resume];
    
    //self.movieImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:movie.movieImage]];
    
}


@end
