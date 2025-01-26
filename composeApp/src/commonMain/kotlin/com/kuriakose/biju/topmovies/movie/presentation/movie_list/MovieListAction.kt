package com.kuriakose.biju.topmovies.movie.presentation.movie_list

import com.kuriakose.biju.topmovies.movie.domain.Movie

sealed interface MovieListAction {
    data class OnMovieClick(val movie: Movie): MovieListAction
}