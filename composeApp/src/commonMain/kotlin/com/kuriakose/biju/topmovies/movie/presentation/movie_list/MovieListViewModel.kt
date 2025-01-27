package com.kuriakose.biju.topmovies.movie.presentation.movie_list
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.kuriakose.biju.topmovies.core.domain.onError
import com.kuriakose.biju.topmovies.core.domain.onSuccess
import com.kuriakose.biju.topmovies.movie.domain.MovieList
import com.kuriakose.biju.topmovies.movie.domain.MovieRepository
import com.kuriakose.biju.topmovies.movie.presentation.asCommonFlow
import kotlinx.coroutines.Job
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.SharingStarted
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.onStart
import kotlinx.coroutines.flow.stateIn
import kotlinx.coroutines.flow.update
import kotlinx.coroutines.launch

class MovieListViewModel(
    private val movieRepository: MovieRepository
): ViewModel() {

    private var observeTopMovieJob: Job? = null

    private val _state = MutableStateFlow(MovieListState())
    val state = _state
        .onStart {
            getTopMovies()
        }
        .stateIn(
            viewModelScope,
            SharingStarted.WhileSubscribed(5000L),
            _state.value
        )

    fun onAction(action: MovieListAction) {
        when(action) {
            is MovieListAction.OnMovieClick -> {

            }
        }
    }

    private fun getTopMovies() {
        observeTopMovieJob?.cancel()
        observeTopMovieJob = viewModelScope.launch {
            _state.update {
                it.copy(
                    isLoading = true
                )
            }
            movieRepository
                .getMovies()
                .onSuccess { topMovies ->
                    _state.update {
                        it.copy(
                            isLoading = false,
                            errorMessage = null,
                            result = MovieList(
                                page = 1,
                                movies = topMovies,
                                totalPages = 1
                            )
                        )
                    }
                }
                .onError { error ->
                    _state.update {
                        it.copy(
                            result = null,
                            isLoading = false,
                            errorMessage = "Unable to process the request!"
                        )
                    }
                }
        }
    }
}