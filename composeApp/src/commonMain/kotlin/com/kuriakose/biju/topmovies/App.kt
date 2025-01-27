package com.kuriakose.biju.topmovies

import androidx.compose.runtime.*
import com.kuriakose.biju.topmovies.core.data.HttpClientFactory
import com.kuriakose.biju.topmovies.movie.data.network.KtorRemoteMovieDataSource
import com.kuriakose.biju.topmovies.movie.data.repository.DefaultMovieRepository
import com.kuriakose.biju.topmovies.movie.presentation.SelectedMovieViewModel
import com.kuriakose.biju.topmovies.movie.presentation.movie_list.MovieListScreenRoot
import com.kuriakose.biju.topmovies.movie.presentation.movie_list.MovieListViewModel
import io.ktor.client.engine.HttpClientEngine
import org.jetbrains.compose.ui.tooling.preview.Preview

@Composable
@Preview
fun App(engine: HttpClientEngine, selectedMovieViewModel: SelectedMovieViewModel) {
    MovieListScreenRoot(
        viewModel = remember {
            MovieListViewModel(
                movieRepository = DefaultMovieRepository(
                    remoteMovieDataSource = KtorRemoteMovieDataSource(
                        httpClient = HttpClientFactory.create(engine)
                    )
                )
            )
        },
        onMovieClick = { movie ->
            selectedMovieViewModel.updateValue(movie.id.toString())
        },
    )
}