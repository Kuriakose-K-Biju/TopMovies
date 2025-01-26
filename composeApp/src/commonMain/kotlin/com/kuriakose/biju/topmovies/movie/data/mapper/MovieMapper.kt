package com.kuriakose.biju.topmovies.movie.data.mapper

import com.kuriakose.biju.topmovies.movie.data.dataTransferObjects.TopMovieDTO
import com.kuriakose.biju.topmovies.movie.domain.Movie

fun TopMovieDTO.toBook(): Movie {
    return Movie(
        id = id,
        title = title,
        posterPath = if(posterPath != null) {
            "https://image.tmdb.org/t/p/w500${posterPath}"
        } else {
                ""
        },
        voteAverage = rating
    )
}