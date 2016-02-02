//
//  CustomCollectionViewCell.h
//  RottenMangoes
//
//  Created by Adam DesLauriers on 2016-02-01.
//  Copyright © 2016 Adam DesLauriers. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Movies;

@interface CustomCollectionViewCell : UICollectionViewCell

- (void)configureWithMovie:(Movies*)movie;

@end
