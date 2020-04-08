//
//  ComingMoviesController.m
//  glns-movie
//
//  Created by muyun on 2020/4/1.
//  Copyright © 2020 glns-movie. All rights reserved.
//

#import "ComingMoviesController.h"
#import "AnticipatedMovie.h"
#import "ComingMovie.h"
#import "AFHTTPSessionManager.h"
#import "Trailer.h"


@implementation ComingMoviesController {
    NSMutableArray<NSString *> *dates;
    NSMutableArray<ComingMovie *> *movies;
    NSMutableArray<Trailer *> *trailers;
    NSMutableArray<AnticipatedMovie *> *anticipatedMovies;
    AFHTTPSessionManager *manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[[NSURL alloc] initWithString:@"https://douban.uieee.com"]];
        manager.securityPolicy.validatesDomainName = NO;
        manager.securityPolicy.allowInvalidCertificates = YES;
        [self initTrailer];
    }
    return self;
}

- (void)initTrailer {
    trailers = [NSMutableArray arrayWithCapacity:5];

    [trailers addObject:[Trailer trailerWithName:@"野性的呼唤"
                                           title:@"人工的灵魂千篇一律，真实的勇气万里挑一"
                                           image:@"https://img1.doubanio.com/img/trailer/small/2574759488.jpg"
                                            link:@"http://vt1.doubanio.com/202004031224/4b0ada513a5cbc8d871286da23959694/view/movie/M/302550802.mp4"]];
    [trailers addObject:[Trailer trailerWithName:@"饥饿站台"
                                           title:@"《饥饿站台》的10层隐喻，每一层都细思极恐"
                                           image:@"https://img9.doubanio.com/img/trailer/small/2590780014.jpg"
                                            link:@"http://vt1.doubanio.com/202004031437/63da792a92490aed9cab6db77c8d3537/view/movie/M/302600022.mp4"]];
    [trailers addObject:[Trailer trailerWithName:@"隐身人"
                                           title:@"今年北美的惊悚片，会以雷沃纳尔开始，温子仁收尾嘛？"
                                           image:@"https://img3.doubanio.com/img/trailer/small/2586515832.jpg"
                                            link:@"http://vt1.doubanio.com/202004031441/c30bf43a8835e20baa20049d146f8f3f/view/movie/M/302590030.mp4"]];
    [trailers addObject:[Trailer trailerWithName:@"绅士们"
                                           title:@"看《绅士们》笑出猪叫！又蠢又爽又神经哈哈哈哈哈"
                                           image:@"https://img3.doubanio.com/img/trailer/small/2580117530.jpg"
                                            link:@"http://vt1.doubanio.com/202004031445/6f1701b6a9fb3b3c54498efc1d1dc7a3/view/movie/M/302570520.mp4"]];
    [trailers addObject:[Trailer trailerWithName:@"狩猎"
                                           title:@"让川建国跳脚的“禁片”终于来了"
                                           image:@"https://img9.doubanio.com/img/trailer/small/2591886734.jpg"
                                            link:@"http://vt1.doubanio.com/202004031447/f93a0de233bed7508663a720c3d21fc3/view/movie/M/302600207.mp4"]];
}

- (void)loadMovie:(NSInteger)page completion:(void (^)(NSInteger page))completion {
    [self requestWithUrl:@"v2/movie/coming_soon" success:^(NSURLSessionDataTask *task, NSDictionary *response) {
        NSLog(@"%@", response);
        NSDictionary *dataDictionary = response;

        NSString *date = @"";
        NSArray *movieDataArray = [dataDictionary objectForKey:@"subjects"];
        self->dates = [[NSMutableArray alloc] init];
        self->movies = [NSMutableArray arrayWithCapacity:movieDataArray.count];
        for (NSDictionary *movieDictionary in movieDataArray) {
            NSArray *castDataArray = [movieDictionary objectForKey:@"casts"];
            NSMutableArray<NSString *> *casts = [NSMutableArray arrayWithCapacity:castDataArray.count];
            for (NSDictionary *castDictionary in castDataArray) {
                [casts addObject:[castDictionary objectForKey:@"name"]];
            }
            ComingMovie *movie = [ComingMovie movieWithImage:[[movieDictionary objectForKey:@"images"] objectForKey:@"small"]
                                                        name:[movieDictionary objectForKey:@"title"]
                                                       types:[movieDictionary objectForKey:@"genres"]
                                                      actors:casts
                                                        date:[movieDictionary objectForKey:@"mainland_pubdate"]
                                                       likes:[movieDictionary objectForKey:@"collect_count"]
                                                        like:NO];
            if ([movie.date isEqualToString:@""]) {
                movie.date = @"近期上映";
            }

            if (![date isEqualToString:movie.date]) {
                date = movie.date;
                [self->dates addObject:date];
            }
            [self->movies addObject:movie];
        }
        completion(page);
    }];
}

- (void)loadAnticipatedMovie:(NSInteger)page completion:(void (^)(NSInteger page))completion {
    [self requestWithUrl:@"v2/movie/new_movies" success:^(NSURLSessionDataTask *task, NSDictionary *response) {
        NSLog(@"%@", response);
        NSDictionary *dataDictionary = response;
        NSArray *movieDataArray = [dataDictionary objectForKey:@"subjects"];
        self->anticipatedMovies = [NSMutableArray arrayWithCapacity:movieDataArray.count];
        for (NSDictionary *movieDictionary in movieDataArray) {
            AnticipatedMovie *anticipatedMovie = [AnticipatedMovie movieWithImage:[[movieDictionary objectForKey:@"images"] objectForKey:@"small"]
                                                                             name:[movieDictionary objectForKey:@"title"]
                                                                             date:[movieDictionary objectForKey:@"mainland_pubdate"]
                                                                            likes:[movieDictionary objectForKey:@"collect_count"]
                                                                             like:NO];
            if ([anticipatedMovie.date isEqualToString:@""]) {
                anticipatedMovie.date = @"2020-04-01";
            }
            [self->anticipatedMovies addObject:anticipatedMovie];
        }
        completion(page);
    }];
}

- (void)requestWithUrl:(NSString *)url success:(void (^)(NSURLSessionDataTask *_Nonnull, id _Nullable))success {
    [manager GET:url parameters:nil progress:nil
         success:success
         failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
             NSLog(@"%@", error);
         }];
}

- (NSArray<AnticipatedMovie *> *)getAnticipatedMovie:(NSInteger)page {
    return anticipatedMovies;
}

- (NSArray<ComingMovie *> *)getMovie:(NSInteger)page {
    return movies;
}

- (NSArray<NSString *> *)getDate:(NSInteger)page {
    return dates;
}

- (NSArray<Trailer *> *)getTrailer:(NSInteger)page {
    return trailers;
}


@end
