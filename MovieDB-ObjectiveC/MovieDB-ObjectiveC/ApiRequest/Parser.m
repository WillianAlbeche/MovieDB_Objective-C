//
//  Parser.m
//  MovieDB-ObjectiveC
//
//  Created by Willian Magnum Albeche on 24/03/22.
//

#import <Foundation/Foundation.h>
#import "Parser.h"
#import "Movie.h"

#define BASE_IMG_URL @"https://image.tmdb.org/t/p/w500"

@implementation Parser

+(NSArray*)movieListFromJSON:(NSData*) json error:(NSError**) error {
    NSError *error_buffer = nil;
    NSDictionary *parsed_object = [NSJSONSerialization JSONObjectWithData:json options:0 error:&error_buffer];
    
    if (error_buffer != nil) {
        *error = error_buffer;
        return nil;
    }
    
    NSMutableArray *movies = [[NSMutableArray alloc] init];
    
    NSArray *results = [parsed_object valueForKey:@"results"];
    NSLog(@"Count %d", (int)results.count);
    
    for (NSDictionary *movie_dict in results) {
        Movie *movie = [[Movie alloc] init];
        
        for (NSString *key in movie_dict) {
            if ([movie respondsToSelector:NSSelectorFromString(key)]) {
                if ([key isEqualToString:@"poster_path"]) {
                    if ([[movie_dict valueForKey:key] isKindOfClass:[NSString class]]) {
                        NSString* pictureURL = [BASE_IMG_URL stringByAppendingString:[movie_dict valueForKey:key]];
                        NSLog(@"--!-- PICTURE URL: %@", pictureURL);
                        [movie setValue:[NSURL URLWithString:pictureURL] forKey:key];
                    } else {
                        NSLog(@"--!-- PICTURE URL EMPTY");
                        [movie setValue:[NSURL URLWithString:@""] forKey:key];
                    }
                } else {
                    [movie setValue:[movie_dict valueForKey:key] forKey:key];
                }
            }
        }
        
        [movies addObject:movie];
    }
    
    return movies;
}

+(void)detailsForMovie:(Movie*) movie from:(NSData*) json error:(NSError**) error {
    NSError *error_buffer = nil;
    NSDictionary *parsed_object = [NSJSONSerialization JSONObjectWithData:json options:0 error:&error_buffer];
    
    if (error_buffer != nil) {
        *error = error_buffer;
        return;
    }
    
    NSArray* results = [parsed_object valueForKey:@"genres"];
    NSString* genre_string = [NSString string];
    
    for (NSDictionary *genre_dict in results) {
        genre_string = [genre_string stringByAppendingFormat:@"%@, ", [genre_dict valueForKey:@"name"]];
    }
    
    // Remove trailing ", " separator from string
    genre_string = [genre_string substringToIndex:[genre_string length] - 2];
    NSLog(@"%@", genre_string);
    
    movie.genre = genre_string;
}

@end
