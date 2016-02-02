//
//  DetailViewController.m
//  RottenMangoes
//
//  Created by Adam DesLauriers on 2016-02-02.
//  Copyright © 2016 Adam DesLauriers. All rights reserved.
//

#import "DetailViewController.h"
#import "Movies.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *detailVCImage;
@property (weak, nonatomic) IBOutlet UILabel *detailVCTitle;
@property (weak, nonatomic) IBOutlet UILabel *detailVCReviewOneLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailVCReviewTwoLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailVCReviewThreeLabel;

@property (nonatomic) NSURLSessionDataTask *task;



@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    NSURLSession *sharedSession = [NSURLSession sharedSession];
    
    
    self.detailVCImage.image = nil;
    
    [self.task cancel];
    
    self.task = [sharedSession dataTaskWithURL:self.movie.movieImage completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        UIImage *image = [UIImage imageWithData:data];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.detailVCImage.image = image;
            self.detailVCTitle.text = self.movie.movieName;
        });
        
    }];
    
    [self.task resume];
    
       
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
