package com.kuriakose.biju.topmovies.movie.data.network

import com.kuriakose.biju.topmovies.core.domain.DataError
import com.kuriakose.biju.topmovies.core.domain.Result
import com.kuriakose.biju.topmovies.movie.data.dataTransferObjects.TopMovieResponseDTO


interface RemoteMovieDataSource {
        suspend fun getMovies(): Result<TopMovieResponseDTO, DataError.Remote>
}