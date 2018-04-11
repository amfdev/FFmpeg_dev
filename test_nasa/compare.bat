..\..\test_assets\tools\ffmpeg -y -i %1 -i %2 -filter_complex "blend=all_mode=difference" -c:v libx264 -crf 18 -c:a copy %1.compare.mkv



