//
//  Theatre.h
//  RottenMangoes
//
//  Created by Adam DesLauriers on 2016-02-02.
//  Copyright © 2016 Adam DesLauriers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>



@interface Theatre : NSObject <MKAnnotation>

- (instancetype)initWith:(NSString *)title address:(NSString*)subtitle location:(CLLocationCoordinate2D) coordinate;


@end
