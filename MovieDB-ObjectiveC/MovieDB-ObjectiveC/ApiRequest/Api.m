//
//  Api.m
//  MovieDB-ObjectiveC
//
//  Created by Willian Magnum Albeche on 24/03/22.
//

#import <Foundation/Foundation.h>
#import "Api.h"
#import "ApiDelegate.h"
#import "Movie.h"

//Minha chave
#define API_KEY @"3b17afb177fb98038d00b9d1ac87f866"
//MARK: Remover antes de deixar o repo publico!
#define NOW_PLAYING_URL @"https://api.themoviedb.org/3/movie/now_playing?api_key=%@"
#define POPULAR_URL @"https://api.themoviedb.org/3/movie/popular?api_key=%@"
#define GENRE_URL @"https://api.themoviedb.org/3/genre/movie/list?api_key=%@"
#define DETAILS_URL @"https://api.themoviedb.org/3/movie/%@?api_key=%@"
#define SEARCH_URL @"https://api.themoviedb.org/3/search/movie?api_key=%@&query=%@"

@implementation Api

-(void)fetchMovieDetails:(Movie *)movie {
    NSString *url_string = [NSString stringWithFormat:DETAILS_URL, movie.id, API_KEY];
    NSURL *url = [[NSURL alloc] initWithString:url_string];
    NSLog(@"%@", url_string);
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
        ^(NSData *data, NSURLResponse *response, NSError *error) {
            if (error) {
                NSLog(@"FETCH MOVIE ERROR");
                NSLog(@"%@", error.localizedDescription);
            } else {
                NSLog(@"FETCH MOVIE SUCCESS");
                [self.delegate receivedMovieDetails:data for:movie];
            }
        }];
    
    [task resume];
}

-(void)fetchMovieList:(FetchOption)option {
    NSString *url_string;
    
    switch (option) {
        case FetchPopular:
            url_string = [NSString stringWithFormat:POPULAR_URL, API_KEY];
            break;
            
        default:
            url_string = [NSString stringWithFormat:NOW_PLAYING_URL, API_KEY];
            break;
    }

    NSURL *url = [[NSURL alloc] initWithString:url_string];
    NSLog(@"%@", url_string);
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
        ^(NSData *data, NSURLResponse *response, NSError *error) {
            if (error) {
                NSLog(@" FETCH ERROR");
                [self.delegate fetchFailedWithError:error];
            } else {
                NSLog(@"FETCH SUCCESS");
                [self.delegate receivedMovieList:data from:option];
            }
        }];

    [task resume];
}

//-(void)searchMoviesWith:(NSString *)keywords {
//    [[NSURLSession sharedSession] invalidateAndCancel];
//
//    keywords = [keywords stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLPathAllowedCharacterSet];
//    NSString *url_string = [NSString stringWithFormat:SEARCH_URL, API_KEY, keywords];
//    NSURL *url = [[NSURL alloc] initWithString:url_string];
//    NSLog(@"%@", url_string);
//
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    NSURLSession *session = [NSURLSession sharedSession];
//    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
//                                            completionHandler:
//        ^(NSData *data, NSURLResponse *response, NSError *error) {
//            if (error) {
//                NSLog(@"--X-- SEARCH ERROR");
//                [self.delegate fetchFailedWithError:error];
//            } else {
//                NSLog(@"--V-- SEARCH SUCCESS");
//                [self.delegate receivedMovieList:data from:FetchSearch];
//            }
//        }];
//
//    [task resume];
//}

@end
