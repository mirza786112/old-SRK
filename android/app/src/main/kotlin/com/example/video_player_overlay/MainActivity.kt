package com.example.video_player_overlay

import android.app.PendingIntent
import io.flutter.embedding.android.FlutterActivity


import android.app.PictureInPictureParams
import android.app.RemoteAction
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.content.res.Configuration
import android.graphics.Point
import android.graphics.drawable.Icon
import android.health.connect.datatypes.units.Length
import android.media.AudioManager
import android.os.Build
import android.os.Bundle
import android.util.Rational
import android.view.WindowManager
import android.widget.Toast
import androidx.annotation.RequiresApi
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val CHANNEL = "pip.channel"
    private val pipReceiver = object : BroadcastReceiver() {
        override fun onReceive(context: Context, intent: Intent) {
            when (intent.action) {
                "com.srktvplus.VOLUME_ACTION" -> {
                    toggleVolume()
                }
            }
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Block screenshots and video recordings
        window.setFlags(WindowManager.LayoutParams.FLAG_SECURE, WindowManager.LayoutParams.FLAG_SECURE)
    }

    @RequiresApi(Build.VERSION_CODES.O)
    override fun onStart() {
        super.onStart()
        registerReceiver(pipReceiver, IntentFilter("com.srktvplus.VOLUME_ACTION"),
            RECEIVER_NOT_EXPORTED
        )
    }

    override fun onStop() {
        super.onStop()
        unregisterReceiver(pipReceiver)
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "enterPiPMode" -> {
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                        enterPiPMode()
                    }
                    result.success(null)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    @RequiresApi(api = Build.VERSION_CODES.O)
    private fun enterPiPMode() {
        Toast.makeText(this, "Entering PiP Mode", Toast.LENGTH_SHORT).show()
        val aspectRatio = Rational(16, 9) // Adjust aspect ratio as needed
        val pipBuilder = PictureInPictureParams.Builder()
            .setAspectRatio(aspectRatio)

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            pipBuilder.setSeamlessResizeEnabled(true)
            pipBuilder.setAutoEnterEnabled(false) // Disable built-in controls
        }

        // Adding custom controls
        updatePiPActionIcon(isMuted = false)

        // Enter PiP mode
        enterPictureInPictureMode(pipBuilder.build())
    }

    private fun toggleVolume() {
        val audioManager = getSystemService(Context.AUDIO_SERVICE) as AudioManager
        val isMuted = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            audioManager.isStreamMute(AudioManager.STREAM_MUSIC)
        } else {
            false
        }

        if (isMuted) {
            audioManager.adjustStreamVolume(AudioManager.STREAM_MUSIC, AudioManager.ADJUST_UNMUTE, 0)
        } else {
            audioManager.adjustStreamVolume(AudioManager.STREAM_MUSIC, AudioManager.ADJUST_MUTE, 0)
        }

        // Update the PiP actions to reflect the new icon
        updatePiPActionIcon(isMuted = isMuted)
    }

    private fun updatePiPActionIcon(isMuted: Boolean) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val volumeIcon = if (isMuted) {
                Icon.createWithResource(this, android.R.drawable.ic_lock_silent_mode)
            } else {
                Icon.createWithResource(this, android.R.drawable.ic_lock_silent_mode_off)
            }
            val volumeIntent = PendingIntent.getBroadcast(
                this,
                0,
                Intent("com.srktvplus.VOLUME_ACTION"),
                PendingIntent.FLAG_IMMUTABLE
            )
            val volumeAction = RemoteAction(
                volumeIcon, "Volume", "Toggle Volume", volumeIntent
            )

            val pipBuilder = PictureInPictureParams.Builder()
                .setActions(listOf(volumeAction))
                .setAspectRatio(Rational(16, 9))

            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
                pipBuilder.setSeamlessResizeEnabled(true)
                pipBuilder.setAutoEnterEnabled(false)
            }

            // Re-enter PiP mode with updated actions
            enterPictureInPictureMode(pipBuilder.build())
        }
    }

    override fun onPictureInPictureModeChanged(isInPictureInPictureMode: Boolean, newConfig: Configuration?) {
        super.onPictureInPictureModeChanged(isInPictureInPictureMode, newConfig)
        if (isInPictureInPictureMode) {
            // Hide UI controls or make adjustments for PiP mode
            Toast.makeText(this, "In PiP Mode", Toast.LENGTH_SHORT).show()
        } else {
            // Restore the full UI
            Toast.makeText(this, "Exited PiP Mode", Toast.LENGTH_SHORT).show()
        }
    }
}