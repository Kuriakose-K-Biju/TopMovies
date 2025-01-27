package com.kuriakose.biju.topmovies

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.runtime.remember
import com.kuriakose.biju.topmovies.movie.presentation.SelectedMovieViewModel
import io.ktor.client.engine.okhttp.OkHttp

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        setContent {
            App(
                engine = remember { OkHttp.create() },
                selectedMovieViewModel = SelectedMovieViewModel()
            )
        }
    }
}
