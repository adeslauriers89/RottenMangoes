//
//  TheatreMapViewController.m
//  RottenMangoes
//
//  Created by Adam DesLauriers on 2016-02-02.
//  Copyright © 2016 Adam DesLauriers. All rights reserved.
//

#import "TheatreMapViewController.h"
#import <MapKit/MapKit.h>
#import "MyLocationManager.h"
#import "Theatre.h"
#import <Corelocation/CLGeocoder.h>
#import <Corelocation/CLPlacemark.h>
#import <AddressBookUI/AddressBookUI.h>
#import "Movies.h"
#import "MyLocationManager.h"


#define zoominMapArea 2100

@interface TheatreMapViewController () <MKMapViewDelegate>

@property (nonatomic, weak) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) NSMutableArray *theatres;
@property (nonatomic, strong) CLLocation *currentLocation;
@property (nonatomic, strong) MyLocationManager *locationManager;



@end

@implementation TheatreMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initiateMap];
    
    [self.locationManager startLocationMonitoring];
    self.mapView.showsUserLocation = true;
    
    
}



-(void)initiateMap {
    
    MyLocationManager *myLocationManager = [MyLocationManager sharedManager];
    NSLog(@"My location in TheatreMapVC is %@", myLocationManager.currentLocation);
    
    CLLocationCoordinate2D zoomLocation = CLLocationCoordinate2DMake(myLocationManager.currentLocation.coordinate.latitude, myLocationManager.currentLocation.coordinate.longitude);
    
    MKCoordinateRegion adjustedRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, zoominMapArea, zoominMapArea);
    
    [_mapView setRegion:adjustedRegion animated:YES];
    
    CLGeocoder *geocoder = [CLGeocoder new];
    [geocoder reverseGeocodeLocation: myLocationManager.currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"error %@ %@", error, [error userInfo]);
        } else {
            CLPlacemark *placemark = [placemarks firstObject];
            if (placemark) {
                NSString *zipCode = [placemark postalCode];
                [self downloadTheatreInfo:zipCode];
            }
        }
    }];
    
    
    
    
    
}

- (void)downloadTheatreInfo:(NSString*)zipCode {
    
    NSString *urlString = @"http://lighthouse-movie-showtimes.herokuapp.com/theatres.json?address=";
    urlString = [urlString stringByAppendingString:zipCode];
    urlString = [urlString stringByAppendingString:@"&movie="];
    urlString = [urlString stringByAppendingString:self.movie.movieName];
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!error) {
            NSError *jsonError = nil;
            NSDictionary *dictFromJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            NSArray *theatresFromJSON = [dictFromJSON objectForKey:@"theatres"];
            self.theatres = [NSMutableArray new];
            
            for (NSDictionary *theatre in theatresFromJSON) {
                NSString *name = [theatre objectForKey:@"name"];
                NSString *address = [theatre objectForKey:@"address"];
                NSNumber *lat = [theatre objectForKey:@"lat"];
                NSNumber *lng = [theatre objectForKey:@"lng"];
                
                CLLocationCoordinate2D theatreLocation = CLLocationCoordinate2DMake([lat doubleValue], [lng doubleValue]);
                
                Theatre *newTheatre = [[Theatre alloc] initWith:name address:address location:theatreLocation];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self.mapView addAnnotation:newTheatre];
                });
            }
        }
        
    }];
    [dataTask resume];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    
    [view setCanShowCallout:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/





















@end
