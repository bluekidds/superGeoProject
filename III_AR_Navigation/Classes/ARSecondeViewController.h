//
//  ARSecondeViewController.h
//  III_AR_Navigation
//
//  Created by Chun F.Hsu on 2010/4/9.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "SFAnnotation.h"
#import "Detail1.h"
#import "ARDataSingleton.h"

#import "panoWebView.h"

#import "Information.h"


@interface ARSecondeViewController : UIViewController<CLLocationManagerDelegate, MKMapViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate> {
	MKMapView *myMap2;
	CLLocationManager *locManager;
	CLLocationCoordinate2D updatedLocation;
	MKCoordinateRegion region2;
	NSMutableArray *myPointArray;
	//SFAnnotation *place1;
	double northRotateAngle;
	Detail1 *detailViewController;
	
	NSMutableArray *annoArray ;
	CLLocation *locationCurrent;
	
	
	//text 0722
	NSString *text;
	NSArray *textarray;
	
	panoWebView *panoViewController;
	
	
	//test 1020
	UIButton *InfoButton;
	Information *InfoViewController;
}
@property (nonatomic, retain) IBOutlet MKMapView *myMap2;
@property (nonatomic, retain) CLLocationManager *locManager;
//@property (nonatomic, retain) SFAnnotation *place1;
@property (nonatomic, retain) NSMutableArray *myPointArray;
//@property (nonatomic, retain) NSArray *mylocationtest;
@property (nonatomic, retain) IBOutlet Detail1 *detailViewController;

@property (nonatomic, retain) NSMutableArray *annoArray;
@property (nonatomic, retain) CLLocation *locationCurrent;

@property (nonatomic, retain) NSString *text;
@property (nonatomic, retain) NSArray *textarray;

@property (nonatomic, retain) panoWebView *panoViewController;

@property (nonatomic, retain) UIButton *InfoButton;
@property (nonatomic, retain) Information *InfoViewController;

-(double) computeRelativeDistance : (CLLocation *)myLocation Destination: (CLLocationCoordinate2D)destCoordinate;
-(void) setMyPoint;
- (void) action;
-(void)setMyMap;
@end
