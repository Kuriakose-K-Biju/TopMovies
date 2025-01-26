package com.kuriakose.biju.topmovies.movie.data.dataTransferObjects

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
data class TopMovieResponseDTO(
    @SerialName("results") val results: List<TopMovieDTO>,
)
