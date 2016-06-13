//  FISAppDelegate.m

#import "FISAppDelegate.h"
#import "FISLocation.h"

@implementation FISAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

- (NSArray *)allLocationNames
{
	NSMutableArray *nameArray = [[NSMutableArray alloc] init];
	for (FISLocation *location in self.locations) {
		[nameArray addObject:location.name];
	}
	return nameArray;
}

- (FISLocation *)locationNamed:(NSString *)name
{
	NSPredicate *namePredicate = [NSPredicate predicateWithFormat:@"name = %@", name];
	NSArray *filteredArray = [self.locations filteredArrayUsingPredicate:namePredicate];
	if (filteredArray.count == 0) {
		return nil; // why are we returning nil?
	}
	return [filteredArray firstObject];
}

- (NSArray *)locationsNearLatitude:(CGFloat)latitude
												 longitude:(CGFloat)longtiude
														margin:(CGFloat)margin
{
	NSPredicate *latitudePredicate = [NSPredicate predicateWithFormat:@"latitude BETWEEN %@", @[@(latitude - margin), @(latitude + margin)]];
	NSPredicate *longitudePredicate = [NSPredicate predicateWithFormat:@"longitude BETWEEN %@", @[@(longtiude - margin), @(longtiude + margin)]];

	NSCompoundPredicate *latitudeLongitudePredicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[latitudePredicate, longitudePredicate]];
  NSArray *filteredArray = [self.locations filteredArrayUsingPredicate:latitudeLongitudePredicate];
	return filteredArray;
}

@end
