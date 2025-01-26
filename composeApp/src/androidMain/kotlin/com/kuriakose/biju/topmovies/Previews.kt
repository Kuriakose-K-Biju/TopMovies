package com.kuriakose.biju.topmovies

import androidx.compose.runtime.Composable
import androidx.compose.ui.tooling.preview.Preview
import com.kuriakose.biju.topmovies.movie.domain.Movie
import com.kuriakose.biju.topmovies.movie.domain.MovieList
import com.kuriakose.biju.topmovies.movie.presentation.movie_list.MovieListScreen
import com.kuriakose.biju.topmovies.movie.presentation.movie_list.MovieListState

private val movies = (1..100).map {
    Movie(
        id = it.toInt(),
        title = "Book $it",
        posterPath = "https://image.tmdb.org/t/p/w500/9cqNxx0GxF0bflZmeSMuL5tnGzr.jpg",
        voteAverage = 9.55
    )
}

@Preview
@Composable
private fun MovieListPreview() {
    MovieListScreen(
        state = MovieListState(
            result = MovieList(
                page = 1,
                movies = movies,
                totalPages = 3
            )
        ),
        onAction = {}
    )
}