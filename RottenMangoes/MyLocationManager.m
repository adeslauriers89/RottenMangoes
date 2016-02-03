//
//  MyLocationManager.m
//  RottenMangoes
//
//  Created by Adam DesLauriers on 2016-02-02.
//  Copyright © 2016 Adam DesLauriers. All rights reserved.
//

#import "MyLocationManager.h"

@interface MyLocationManager () <CLLocationManagerDelegate>

@property (nonatomic) CLLocationManager *locationManager;


@end

@implementation MyLocationManager

+ (id)sharedManager {
    
    static MyLocationManager *sharedMyManager =nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
        
    });
    return sharedMyManager;
}

- (id)init {
    if (self =  [super init]) {
        
    }
    return self;
}


- (void)startLocationMonitoring{
    if ([CLLocationManager locationServicesEnabled]) {
        
        if ((!([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusRestricted)) || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
            [self setUpLocationManager];
            
        }else{
            
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Location services are disabled, Please go into Settings > Privacy > Location to enable them for Play" message:@"" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //
                
            }];
            
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //
            }];
            
            [alertController addAction:ok];
            [alertController addAction:cancel];
        }
    }
}

- (void)setUpLocationManager {
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc]init];
        _locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        _locationManager.distanceFilter =10;
        
        _locationManager.delegate = self;
        [_locationManager requestWhenInUseAuthorization];
        NSLog(@"New location manager in startLocationmanager");
    }
    
    [_locationManager startUpdatingLocation];
    NSLog(@"Start regular location manager");

}

-(void)stopLocationManager {
    if ([CLLocationManager locationServicesEnabled]) {
        if (_locationManager) {
            [_locationManager stopUpdatingLocation];
            NSLog(@"Stop Regular location manager");
        }
    }
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    CLLocation *loc = [locations lastObject];
    
    NSLog(@"Time %@, latitude %+.6f, longitude %+.6f currentLocation accuracy %1.2f loc accuracy %1.2f timeinterval %f",[NSDate date],loc.coordinate.latitude, loc.coordinate.longitude, loc.horizontalAccuracy, loc.verticalAccuracy, fabs([loc.timestamp timeIntervalSinceNow]));
    
    NSTimeInterval locationAge = -[loc.timestamp timeIntervalSinceNow];
    if (locationAge > 10.0) {
        NSLog(@"locationAge is %1.2f", locationAge);
    }
    
    if (loc.horizontalAccuracy < 0) {
        NSLog(@"loc.horizontalAccuracy is %1.2f", loc.horizontalAccuracy);
    }
    
    if (self.currentLocation == nil || self.currentLocation.horizontalAccuracy >= loc.horizontalAccuracy) {
        
        self.currentLocation = loc;
        
        if (loc.horizontalAccuracy <= self.locationManager.desiredAccuracy) {
            [self stopLocationManager];
        }
        
    }
}



@end
