package com.kuriakose.biju.topmovies.movie.presentation.movie_list.Components
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.widthIn
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.LazyListState
import androidx.compose.foundation.lazy.rememberLazyListState
import androidx.compose.foundation.lazy.items
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import com.kuriakose.biju.topmovies.movie.domain.Movie

@Composable
fun MovieListView(
    movies: List<Movie>,
    onMovieClick: (Movie) -> Unit,
    modifier: Modifier,
    scrollState: LazyListState = rememberLazyListState()
) {
    LazyColumn(
        modifier = modifier,
        state = scrollState,
        verticalArrangement = Arrangement.spacedBy(12.dp),
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        items(
            items = movies,
            key = { it.id }
        ) { movie ->
            MovieListItem(
                movie = movie,
                modifier = Modifier
                    .widthIn(max = 700.dp)
                    .fillMaxWidth()
                    .padding(horizontal = 16.dp),
                onClick = {
                    onMovieClick(movie)
                }
            )
        }
    }
}