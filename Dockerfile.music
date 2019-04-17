FROM considerate/nak-learn:latest

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    libsndfile1 ffmpeg \
    && pip install --no-cache-dir \
    music21 librosa soundfile pretty_midi mido pychord essentia \
    && rm -rf /var/lib/apt/lists/*
