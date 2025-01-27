package com.kuriakose.biju.topmovies.movie.presentation

import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow

class SelectedMovieViewModel {
    private val _value = MutableStateFlow("")
    val value: StateFlow<String> get() = _value

    fun valueAsCommonFlow() = value.asCommonFlow()

    fun updateValue(newValue: String) {
        _value.value = newValue
    }
}