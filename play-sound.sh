#!/bin/bash

# Cross-platform sound notification script for Claude Code
# Usage: play-sound.sh [type]
# Types: tool, notify, stop (default: tool)

SOUND_TYPE="${1:-tool}"

# Detect the operating system
detect_os() {
    if [[ "$(uname -r)" == *"microsoft"* ]] || [[ "$(uname -r)" == *"WSL"* ]]; then
        echo "wsl"
    elif [[ "$(uname)" == "Darwin" ]]; then
        echo "macos"
    elif [[ "$(uname)" == "Linux" ]]; then
        echo "linux"
    else
        echo "unknown"
    fi
}

OS=$(detect_os)

play_sound_wsl() {
    local sound_type="$1"
    case "$sound_type" in
        tool)
            # Quick ding sound for tool use
            powershell.exe -Command "(New-Object Media.SoundPlayer 'C:\Windows\Media\ding.wav').PlaySync()" 2>/dev/null &
            ;;
        notify)
            # Notification sound
            powershell.exe -Command "(New-Object Media.SoundPlayer 'C:\Windows\Media\Windows Notify.wav').PlaySync()" 2>/dev/null &
            ;;
        stop)
            # Completion sound
            powershell.exe -Command "(New-Object Media.SoundPlayer 'C:\Windows\Media\chimes.wav').PlaySync()" 2>/dev/null &
            ;;
        *)
            # Default to ding
            powershell.exe -Command "(New-Object Media.SoundPlayer 'C:\Windows\Media\ding.wav').PlaySync()" 2>/dev/null &
            ;;
    esac
}

play_sound_macos() {
    local sound_type="$1"
    case "$sound_type" in
        tool)
            afplay /System/Library/Sounds/Pop.aiff 2>/dev/null &
            ;;
        notify)
            afplay /System/Library/Sounds/Glass.aiff 2>/dev/null &
            ;;
        stop)
            afplay /System/Library/Sounds/Purr.aiff 2>/dev/null &
            ;;
        *)
            afplay /System/Library/Sounds/Pop.aiff 2>/dev/null &
            ;;
    esac
}

play_sound_linux() {
    local sound_type="$1"
    # Check for available sound players
    if command -v paplay &> /dev/null; then
        # PulseAudio
        case "$sound_type" in
            tool)
                paplay /usr/share/sounds/freedesktop/stereo/message.oga 2>/dev/null &
                ;;
            notify)
                paplay /usr/share/sounds/freedesktop/stereo/complete.oga 2>/dev/null &
                ;;
            stop)
                paplay /usr/share/sounds/freedesktop/stereo/bell.oga 2>/dev/null &
                ;;
            *)
                paplay /usr/share/sounds/freedesktop/stereo/message.oga 2>/dev/null &
                ;;
        esac
    elif command -v aplay &> /dev/null; then
        # ALSA
        # Generate a simple beep using sox if available, otherwise skip
        if command -v play &> /dev/null; then
            case "$sound_type" in
                tool)
                    play -n synth 0.1 sine 880 2>/dev/null &
                    ;;
                notify)
                    play -n synth 0.2 sine 660 2>/dev/null &
                    ;;
                stop)
                    play -n synth 0.3 sine 440 2>/dev/null &
                    ;;
                *)
                    play -n synth 0.1 sine 880 2>/dev/null &
                    ;;
            esac
        fi
    fi
}

# Play the appropriate sound based on OS
case "$OS" in
    wsl)
        play_sound_wsl "$SOUND_TYPE"
        ;;
    macos)
        play_sound_macos "$SOUND_TYPE"
        ;;
    linux)
        play_sound_linux "$SOUND_TYPE"
        ;;
    *)
        # Unknown OS, try to beep if possible
        if command -v printf &> /dev/null; then
            printf '\a'
        fi
        ;;
esac

exit 0