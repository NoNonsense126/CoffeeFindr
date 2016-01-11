//
//  DetailViewController.m
//  CoffeeFindr
//
//  Created by Wong You Jing on 10/01/2016.
//  Copyright © 2016 NoNonsense. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.coffeePlace.mapItem.name;
    [self getPathDirections:self.currentLocation.coordinate withDestination:self.coffeePlace.mapItem.placemark.location.coordinate];
}

- (void)getPathDirections:(CLLocationCoordinate2D)source withDestination:(CLLocationCoordinate2D)destination
{
    MKPlacemark *placemarkSC = [[MKPlacemark alloc] initWithCoordinate:source
                                                     addressDictionary:nil];
    MKMapItem *mapItemSrc = [[MKMapItem alloc]initWithPlacemark:placemarkSC];
    
    MKPlacemark *placemarkDest = [[MKPlacemark alloc] initWithCoordinate:destination
                                                     addressDictionary:nil];
    MKMapItem *mapItemDest = [[MKMapItem alloc]initWithPlacemark:placemarkDest];
    
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc]init];
    [request setSource:mapItemSrc];
    [request setDestination:mapItemDest];
    [request setTransportType:MKDirectionsTransportTypeWalking];
    request.requestsAlternateRoutes = nil;
    
    MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
    
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse * _Nullable response, NSError * _Nullable error)
    {
        MKRoute *route = response.routes.lastObject;
        NSString *allSteps = [NSString new];
        
        for(int i = 0; i < route.steps.count; i++)
        {
            MKRouteStep *step = [route.steps objectAtIndex:i];
            NSString *newStepsString = step.instructions;
            allSteps = [allSteps stringByAppendingString:newStepsString];
            allSteps = [allSteps stringByAppendingString:@"\n\n"];
        }
        self.textView.text = allSteps;
    }];
}
@end
