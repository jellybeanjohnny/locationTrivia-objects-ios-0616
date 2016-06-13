//
//  FISLocation.m
//  locationTrivia-Objects
//
//  Created by Matt Amerige on 6/13/16.
//  Copyright © 2016 Joe Burgess. All rights reserved.
//

#import "FISLocation.h"

@implementation FISLocation

- (instancetype)init
{
	return [self initWithName:@"" latitude:0 longitude:0];
}

- (instancetype)initWithName:(NSString *)name latitude:(CGFloat)latitude longitude:(CGFloat)longitude
{
	self = [super init];
	if (self) {
		_name = name;
		_latitude = latitude;
		_longitude = longitude;
		_trivia = [[NSMutableArray alloc] init];
	}
	return self;
}

- (NSString *)stringByTruncatingNameToLength:(NSUInteger)length
{
	// IF the length exceeds the name of the location just return the full name
	if (length > self.name.length) {
		return self.name;
	}
	
	return [self.name substringToIndex:length];
}

- (BOOL)hasValidData
{
	if (self.name.length == 0 ||
			self.latitude > 90.0 ||
			self.latitude < -90.0 ||
			self.longitude > 180.0 ||
			self.longitude <= -180.0) {
		
		return NO;
		
	}
	return YES;
}

- (FISTrivium *)triviumWithMostLikes
{
	if (self.trivia.count == 0) {
		return nil; // Why are we returning nil here??
	}
	
	NSSortDescriptor *sortLikes = [NSSortDescriptor sortDescriptorWithKey:@"likes" ascending:NO];
	
	NSArray *sortedLikes = [self.trivia sortedArrayUsingDescriptors:@[sortLikes]];
	
	return [sortedLikes firstObject];
}

@end
