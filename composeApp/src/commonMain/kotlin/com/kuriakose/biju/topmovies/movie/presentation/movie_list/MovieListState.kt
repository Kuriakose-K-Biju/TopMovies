package com.kuriakose.biju.topmovies.movie.presentation.movie_list

import com.kuriakose.biju.topmovies.movie.domain.MovieList

data class MovieListState(
    val result: MovieList? = null,
    val isLoading: Boolean = false,
    val errorMessage: String? = null
)