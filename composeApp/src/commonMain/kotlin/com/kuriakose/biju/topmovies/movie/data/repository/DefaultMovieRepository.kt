package com.kuriakose.biju.topmovies.movie.data.repository

import com.kuriakose.biju.topmovies.movie.data.network.RemoteMovieDataSource
import com.kuriakose.biju.topmovies.core.domain.Result
import com.kuriakose.biju.topmovies.core.domain.DataError
import com.kuriakose.biju.topmovies.core.domain.map
import com.kuriakose.biju.topmovies.movie.data.mapper.toBook
import com.kuriakose.biju.topmovies.movie.domain.Movie
import com.kuriakose.biju.topmovies.movie.domain.MovieRepository

class DefaultMovieRepository(
    private val remoteMovieDataSource: RemoteMovieDataSource
): MovieRepository {
    override suspend fun getMovies(): Result<List<Movie>, DataError.Remote> {
        return remoteMovieDataSource
            .getMovies()
            .map { dto ->
                dto.results.map { it.toBook() }
            }
    }
}