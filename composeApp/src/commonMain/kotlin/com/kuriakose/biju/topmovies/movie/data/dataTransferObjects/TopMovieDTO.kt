package com.kuriakose.biju.topmovies.movie.data.dataTransferObjects

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
data class TopMovieDTO(
    @SerialName("id") val id: Int,
    @SerialName("title") val title: String? = null,
    @SerialName("poster_path") val posterPath: String? = null,
    @SerialName("vote_average") val rating: Double? = null
)
