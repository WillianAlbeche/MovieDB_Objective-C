//
//  Api.h
//  MovieDB-ObjectiveC
//
//  Created by Willian Magnum Albeche on 24/03/22.
//

#ifndef Api_h
#define Api_h


@class Movie;

@interface Api : NSObject

typedef NS_ENUM(NSInteger, FetchOption){
    FetchPlaying,
    FetchPopular,
    FetchSearch,
};

@property(weak, nonatomic) id delegate;

-(void)fetchMovieList: (FetchOption) option;
-(void)fetchMovieDetails: (Movie*)movie;
//-(void)searchMovieWith: (NSString*)keywords;

@end

#endif /* Api_h */
