//
//  Parser.h
//  MovieDB-ObjectiveC
//
//  Created by Willian Magnum Albeche on 24/03/22.
//

#ifndef Parser_h
#define Parser_h
@class Movie;

@interface Parser : NSObject

+(NSArray*)movieListFromJSON:(NSData*) json error:(NSError**) error;
+(void)detailsForMovie:(Movie*) movie from:(NSData*) json error:(NSError**) error;

@end


#endif /* Parser_h */
