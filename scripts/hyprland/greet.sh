#!/usr/bin/env bash
sleep 1
pico2wave -w /tmp/greet.wav "Good morning, $USER" && mpv /tmp/greet.wav