package com.kuriakose.biju.topmovies

import androidx.compose.ui.window.ComposeUIViewController
import androidx.compose.runtime.remember
import com.kuriakose.biju.topmovies.movie.presentation.SelectedMovieViewModel
import io.ktor.client.engine.darwin.Darwin

fun MainViewController(selectedMovieViewModel: SelectedMovieViewModel) = ComposeUIViewController { App(
    engine = remember {
        Darwin.create()
    },
    selectedMovieViewModel = selectedMovieViewModel
) }