//
//  Constants.swift
//  MyMovieApp
//
//  Created by Rubal Wanchoo on 6/30/16.
//  Copyright © 2016 wanchoo. All rights reserved.
//

import Foundation


struct Constants{
    
    //
    //  Constants.swift
    //  MyFavoriteMovies
    //
    //  Created by Jarrod Parkes on 11/5/15.
    //  Copyright © 2015 Udacity. All rights reserved.
    //


    // MARK: TMDB
        struct TMDB {
            static let ApiScheme = "https"
            static let ApiHost = "api.themoviedb.org"
            static let ApiPath = "/3"
            static let ApiPathTokenNew="/authentication/token/new"
            static let ApiPathValidateWithToken="/authentication/token/validate_with_login"
            static let ApiAuthenticateSessionNew="authentication/session/new"
            static let ApiAccount="/account"
        }
        
        // MARK: TMDB Parameter Keys
        struct TMDBParameterKeys {
            static let ApiKey = "api_key"
            static let RequestToken = "request_token"
            static let SessionID = "session_id"
            static let Username = "username"
            static let Password = "password"
        }
        
        // MARK: TMDB Parameter Values
        struct TMDBParameterValues {
            static let ApiKey = "286a627b92ed9226a1229a4bc096db2e"
        }
        
        // MARK: TMDB Response Keys
        struct TMDBResponseKeys {
            static let Title = "title"
            static let ID = "id"
            static let PosterPath = "poster_path"
            static let Status = "Status"
            static let StatusCode = "status_code"
            static let StatusMessage = "status_message"
            static let SessionID = "session_id"
            static let RequestToken = "request_token"
            static let Success = "success"
            static let UserID = "id"
            static let Results = "results"
        }

    
    
}