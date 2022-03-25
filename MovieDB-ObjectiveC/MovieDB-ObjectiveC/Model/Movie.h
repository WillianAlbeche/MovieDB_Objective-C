//
//  Movie.h
//  MovieDB-ObjectiveC
//
//  Created by Willian Magnum Albeche on 22/03/22.
//

#ifndef Movie_h
#define Movie_h

@interface Movie : NSObject

@property NSNumber* id;
@property NSString* title;
@property NSString* overview;
@property NSString* genre;
@property NSNumber* rating;
@property NSURL* poster_path;
@property NSData* poster;

@end


#endif /* Movie_h */
