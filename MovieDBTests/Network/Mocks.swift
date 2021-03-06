//
//  APIClientTests.swift
//  MovieDBTests
//
//  Created by Fábio Salata on 06/03/21.
//  Copyright © 2021 Fabio Salata. All rights reserved.
//

import Foundation

func mockMovies() -> Data {
    return """
            {
                "dates": {
                    "maximum": "2021-03-29",
                    "minimum": "2021-03-12"
                },
                "results": [
                    {
                        "genre_ids": [
                                        14,
                                        28,
                                        12
                                    ],
                        "adult": false,
                        "backdrop_path": "\\/8tNX8s3j1O0eqilOQkuroRLyOZA.jpg",
                        "id": 458576,
                        "original_title": "Monster Hunter",
                        "vote_average": 7.2999999999999998,
                        "popularity": 2829.5740000000001,
                        "poster_path": "\\/1UCOF11QCw8kcqvce8LKOO6pimh.jpg",
                        "overview": "A portal transports Cpt. Artemis and an elite unit of soldiers to a strange world where powerful monsters rule with deadly ferocity. Faced with relentless danger, the team encounters a mysterious hunter who may be their only hope to find a way home.",
                        "title": "Monster Hunter",
                        "original_language": "en",
                        "vote_count": 964,
                        "release_date": "2020-12-03",
                        "video": false
                    },
                    {
                        "genre_ids" : [
                                        16,
                                        12,
                                        14,
                                        10751
                                    ],
                        "adult" : false,
                        "backdrop_path" : "\\/7prYzufdIOy1KCTZKVWpjBFqqNr.jpg",
                        "id" : 527774,
                        "original_title" : "Raya and the Last Dragon",
                        "vote_average" : 8.5,
                        "popularity" : 889.42399999999998,
                        "poster_path" : "\\/lPsD10PP4rgUGiGR4CCXA6iY0QQ.jpg",
                        "overview" : "Long ago, in the fantasy world of Kumandra, humans and dragons lived together in harmony. But when an evil force threatened the land, the dragons sacrificed themselves to save humanity. Now, 500 years later, that same evil has returned and it’s up to a lone warrior, Raya, to track down the legendary last dragon to restore the fractured land and its divided people.",
                        "title" : "Raya and the Last Dragon",
                        "original_language" : "en",
                        "vote_count" : 141,
                        "release_date" : "2021-03-03",
                        "video" : false
                    }
                ],
                "total_pages": 9,
                "total_results": 175,
                "page": 1
            }
           """.data(using: .utf8)!
}

func mockGenres() -> Data? {
    return  """
            {
                "genres" : [
                    {
                        "id" : 28,
                        "name" : "Action"
                    },
                    {
                        "id" : 12,
                        "name" : "Adventure"
                    },
                    {
                        "id" : 16,
                        "name" : "Animation"
                    },
                    {
                        "id" : 35,
                        "name" : "Comedy"
                    },
                    {
                        "id" : 80,
                        "name" : "Crime"
                    },
                    {
                        "id" : 99,
                        "name" : "Documentary"
                    },
                    {
                        "id" : 18,
                        "name" : "Drama"
                    },
                    {
                        "id" : 10751,
                        "name" : "Family"
                    },
                    {
                        "id" : 14,
                        "name" : "Fantasy"
                    },
                    {
                        "id" : 36,
                        "name" : "History"
                    },
                    {
                        "id" : 27,
                        "name" : "Horror"
                    },
                    {
                        "id" : 10402,
                        "name" : "Music"
                    },
                    {
                        "id" : 9648,
                        "name" : "Mystery"
                    },
                    {
                        "id" : 10749,
                        "name" : "Romance"
                    },
                    {
                        "id" : 878,
                        "name" : "Science Fiction"
                    },
                    {
                        "id" : 10770,
                        "name" : "TV Movie"
                    },
                    {
                        "id" : 53,
                        "name" : "Thriller"
                    },
                    {
                        "id" : 10752,
                        "name" : "War"
                    },
                    {
                        "id" : 37,
                        "name" : "Western"
                    }
                ]
            }
            """.data(using: .utf8)!
}



