package com.kuriakose.biju.topmovies.movie.domain

import com.kuriakose.biju.topmovies.core.domain.DataError
import com.kuriakose.biju.topmovies.core.domain.Result

interface MovieRepository {
    suspend fun getMovies(): Result<List<Movie>, DataError.Remote>
}