package com.kuriakose.biju.topmovies.movie.domain

data class Movie(
    val id: Int,
    val title: String?,
    val posterPath: String?,
    val voteAverage: Double?
)

data class MovieList(
    val page: Int,
    val movies: List<Movie>,
    val totalPages: Int
)
