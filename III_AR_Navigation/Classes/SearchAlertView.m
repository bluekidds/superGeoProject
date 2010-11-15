//
//  SearchAlertView.m
//  III_AR_Navigation
//
//  Created by Chun F.Hsu on 2010/11/12.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SearchAlertView.h"


@implementation SearchAlertView

@synthesize NumSlider, RangeSlider, NumLabel, RangeLabel;

//initialize
- (id) initWithFrame:(CGRect)frame
{
	if(self = [super initWithFrame:frame])
	{
		NumSlider = [[UISlider alloc] initWithFrame:CGRectZero];
		[NumSlider addTarget:self action:@selector(NumChanged:) forControlEvents:UIControlEventValueChanged];
		RangeSlider = [[UISlider alloc] initWithFrame:CGRectZero];
		[RangeSlider addTarget:self action:@selector(RangeChanged:) forControlEvents:UIControlEventValueChanged];
		
		NumLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		NumLabel.text = @"0 筆";
		NumLabel.textColor = [UIColor whiteColor];
		NumLabel.backgroundColor = [UIColor clearColor];
		RangeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		RangeLabel.text = @"0 公里";
		RangeLabel.textColor = [UIColor whiteColor];
		RangeLabel.backgroundColor = [UIColor clearColor];
		
		[self addSubview:NumSlider];
		[self addSubview:RangeSlider];
		[self addSubview:NumLabel];
		[self addSubview:RangeLabel];
	}
	return self;
}

- (void) setFrame:(CGRect)rect
{
	[super setFrame:CGRectMake(0, 0, rect.size.width, 300)];
}

- (void) layoutSubviews
{
	CGFloat buttonTop;
	for (UIView *view in self.subviews) {
		if ([[[view class] description] isEqualToString:@"UIThreePartButton"]) {
			view.frame = CGRectMake(view.frame.origin.x
									, self.bounds.size.height - view.frame.size.height - 15
									, view.frame.size.width
									, view.frame.size.height);
			buttonTop = view.frame.origin.y;
		}
	}	
	
	NumSlider.frame = CGRectMake(12, 50, 120, 20);
	NumLabel.frame = CGRectMake(150, 50, 60, 20);
}

- (void)NumChanged:(id)element
{
	NSString *TEMP;
	TEMP = [NSString stringWithFormat:@"%1.1f 筆", NumSlider.value];
	
	NumLabel.text = TEMP;
}

- (void)RangeChanged:(id)element
{}
@end
