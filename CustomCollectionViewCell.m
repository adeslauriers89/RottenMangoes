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


@end

@implementation CustomCollectionViewCell

- (void)configureWithMovie:(Movies*)movie{
    
    self.movieImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:movie.movieImage]];
    
}


@end
