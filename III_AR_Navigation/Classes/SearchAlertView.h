//
//  SearchAlertView.h
//  III_AR_Navigation
//
//  Created by Chun F.Hsu on 2010/11/12.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchAlertView : UIAlertView {
	UISlider *NumSlider;
	UISlider *RangeSlider;
	
	UILabel *NumLabel;
	UILabel *RangeLabel;
}

@property (nonatomic, retain) UISlider *NumSlider;
@property (nonatomic, retain) UISlider *RangeSlider;
@property (nonatomic, retain) UILabel *NumLabel;
@property (nonatomic, retain) UILabel *RangeLabel;

- (id)initWithFrame:(CGRect)frame;
- (void)NumChanged:(id)element;
- (void)RangeChanged:(id)element;

@end
