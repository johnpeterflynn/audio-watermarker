# Audio Watermarker

This repository contains a MATLAB script that embeds (or "hides") data into the low frequency, inaudible components of audio waveforms. Using Hamming error-correcting codes, data can often be recovered even if the waveform is resampled. See the tutorial for an example.

## Instructions

### Run
1. Unzip all files into the same directory.
2. Run Main.m and follow prompts in the command window.
3. Enter 'y' or 'n' for yes and no.
4. When asked, type the name of your wav file. it MUST be in the same directory.

### Tutorial
The program will run the following sequence of prompts:

1. Asks if you would like to run an example.
2. Inputs a file of your choice.
3. Allows you to customize certain settings.
4. Saves and plays the watermarked file. Also opens a Spectrogram.
5. Asks you to input a watermarked file for decoding.
6. Asks you to enter decode parameters. Make sure these are identical to your encoding parameters.
7. Asks you which kind of attack you would like to simulate.
8. Extracts and displays the watermark.