package com.kuriakose.biju.topmovies.movie.presentation
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.collect
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.launch

class CommonFlow<T>(private val flow: Flow<T>) {
    fun collect(callback: (T) -> Unit) {
        CoroutineScope(Dispatchers.Main).launch {
            flow.collect { value ->
                callback(value)
            }
        }
    }
}

fun <T> StateFlow<T>.asCommonFlow(): CommonFlow<T> = CommonFlow(this)