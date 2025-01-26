package com.kuriakose.biju.topmovies

import androidx.compose.ui.window.ComposeUIViewController
import androidx.compose.runtime.remember
import io.ktor.client.engine.darwin.Darwin

fun MainViewController() = ComposeUIViewController { App(
    engine = remember {
        Darwin.create()
    }
) }