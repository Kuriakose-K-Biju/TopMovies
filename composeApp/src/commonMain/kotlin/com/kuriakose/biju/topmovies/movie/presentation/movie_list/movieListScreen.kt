package com.kuriakose.biju.topmovies.movie.presentation.movie_list

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.statusBarsPadding
import androidx.compose.foundation.lazy.rememberLazyListState
import androidx.compose.material.Text
import androidx.compose.material.Scaffold
import androidx.compose.material.TopAppBar
import androidx.compose.material3.CircularProgressIndicator
import androidx.compose.material3.MaterialTheme
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.lifecycle.compose.collectAsStateWithLifecycle
import com.kuriakose.biju.topmovies.movie.domain.Movie
import com.kuriakose.biju.topmovies.movie.presentation.SelectedMovieViewModel
import com.kuriakose.biju.topmovies.movie.presentation.movie_list.Components.MovieListView
import org.koin.compose.viewmodel.koinViewModel

@Composable
fun MovieListScreenRoot(
    viewModel: MovieListViewModel = koinViewModel(),
    onMovieClick: (Movie) -> Unit,
    modifier: Modifier = Modifier
) {
    val state by viewModel.state.collectAsStateWithLifecycle()

    MovieListScreen(
        state = state,
        onAction = { action ->
            when(action) {
                is MovieListAction.OnMovieClick -> onMovieClick(action.movie)
                else -> Unit
            }
            viewModel.onAction(action)
        }
    )
}


@Composable
fun MovieListScreen(
    state: MovieListState,
    onAction: (MovieListAction) -> Unit,
) {

    val movieResultsListState = rememberLazyListState()

    LaunchedEffect(state.result?.movies) {
        movieResultsListState.animateScrollToItem(0)
    }

    Column(
        modifier = Modifier
            .fillMaxSize()
            .background(Color.White)
            .statusBarsPadding(),
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        Scaffold(
            topBar = {
                TopAppBar(
                    title = {
                        Text("Top Movies")
                    },
                    backgroundColor = Color(0xFF9AD9FF)
                )
            },
        ) {
            Column(
                modifier = Modifier
                    .fillMaxSize()
                    .padding(vertical = 12.dp)
                    .padding(horizontal = 10.dp),
                horizontalAlignment = Alignment.CenterHorizontally

            ) {
                if(state.isLoading) {
                    CircularProgressIndicator()
                } else {
                    when {
                        state.errorMessage != null -> {
                            Text(
                                text = state.errorMessage,
                                textAlign = TextAlign.Center,
                                style = MaterialTheme.typography.headlineSmall,
                                color = MaterialTheme.colorScheme.error
                            )
                        }
                        state.result?.movies?.isEmpty() == true -> {
                            androidx.compose.material3.Text(
                                text = "No Data Available",
                                textAlign = TextAlign.Center,
                                style = MaterialTheme.typography.headlineSmall,
                                color = MaterialTheme.colorScheme.error
                            )
                        }
                        else -> {
                            state.result?.let { it1 ->
                                MovieListView(
                                    movies = it1.movies,
                                    onMovieClick = {
                                        onAction(MovieListAction.OnMovieClick(it))
                                    },
                                    modifier = Modifier.fillMaxSize(),
                                    scrollState = movieResultsListState
                                )
                            }
                        }
                    }
                }
            }
        }
    }
}
