//
//  ReminderRegion.m
//  method-of-loci
//
//  Created by Brian Ledbetter on 2/4/15.
//  Copyright (c) 2015 Brian Ledbetter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface ReminderRegion : NSObject
//an array of reminders associated with the region
@property (strong, nonatomic) NSMutableArray* reminders;
//a region
@property (strong, nonatomic) CLCircularRegion* region;
//a name
@property (strong, nonatomic) NSString* name;

@end

@implementation ReminderRegion

//MARK: INITIALIZER
-(instancetype) initWith:(NSString*)name andRegion:(CLCircularRegion*)region {
    if (self = [super init]){
        self.name = name;
        self.region = region;
    }
    return self;
}

-(void)addReminder:(NSString*)reminder {
    [_reminders addObject:reminder];
}



@end;