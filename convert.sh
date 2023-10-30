# Change input and output details

output_path="za" # Output Path (Same will be pushed in main also)
input_url="https://video-downloads.googleusercontent.com/ADGPM2m5R3EsHmquvGc_NFxzT3M82n6KG3iLVarLujXZzRJk4bFJLcJgYnUO0AMJrRfXqcAIg-odpqQo4NuyHbdYeRQZvD6LHo2LfTVz2C4R7rikL5e5vRB7JTTjFsAAsrq8nzoh2CpAaJPbDasEcNzHScDnx-h8E7OEk_ZYLjhVwZwM-gzXPj8EvCVNrEzyf00FkBdQQsHGdPZA3KPHDY9nlDg-sDE2enPGtbYX7ktn9zZn36wxTpJg0jWypBN8k-FVgluPER__vBXqpRFvDpOswy5RC9ijU3mcnFsaTP6QLG3zRJoAoTTi8m5M5z4Ozv_7UREkbLOeSyHgQoFVAAwA3ZBDdRo5OPnuupXnfbelIk7KhizF9ps8fAGrIkMYHiB7hrcxtSZJiIOWyu8kr4A2KRvIB1GnBD1KVMzaHnon1s1q1FSHlKxugHaW1goVLF9Sn69hKhSHq8amMD_4YhL2bfP_iXNYiyeDxjwC09uVngdknVrL6i18U6KPNq0ORZvnpsGDLnRc9CWLGGHJDVNPsqtDQTK8GyHgojV7guLI7BgGR2ZchZh5zY6N-zt3G95BDFxeGtA4OHnd7ce2WYx7kA5KY9wIZDydQkZ6Ezol9FPYbzNOJ0eXIfaGNBYLF39MWQ-BhlSe2O4iAdHishb-RezS1W1GLYIJRyU7V1fyRvckdV4xUHwibRKsk--KKMieA0PBCncT-W7V5qUbIoENAPLq-ui6rdWuGP8UzHsLIo80Nf-i7Yn6C7vGu62Uv91W-LwDIFkeeD64wophDG6faa_lSEQxTFOOp0k_G5obCoU_ie74lJ8ZFE_fnGKboWlG8WxK6T_2ghke45fnmn6opiVqYfHBflaiFbxB3sWIXE6Bf4pGXbspPV0QJc3PzXegXgq58CHpyf8T6ACgFs8r1nUnTQ18j49waIIMr5CY6AQze1JLxc-gG8oL0-k1kkOyb9DTbDYdRqYrFD0bp4l2mUhUPcrrNnefkI0HJaeAFbM77W5zv2Wvb-jYa7GravELvYNplH1lADyd34DEx3JLnCIyaqd5_-WJgzFNX5mAaZXIWcDqjqXn7MBq6EBzwwHj5gmwZAWM" # Input direct file url
input_extension="kkv" # Extension of file url



# Change ffmpeg configurations according to yur need (If you don't know, don't touch)

wget --quiet -O video.$input_extension $input_url
mkdir $output_path

ffmpeg -hide_banner -y -i video.$input_extension \
  -vf scale=w=640:h=360:force_original_aspect_ratio=decrease -c:a aac -ar 48000 -c:v h264 -profile:v main -crf 20 -sc_threshold 0 -g 48 -keyint_min 48 -hls_time 4 -hls_playlist_type vod  -b:v 800k -maxrate 856k -bufsize 1200k -b:a 96k -hls_segment_filename $output_path/360p_%03d.ts $output_path/360p.m3u8 \
  -vf scale=w=842:h=480:force_original_aspect_ratio=decrease -c:a aac -ar 48000 -c:v h264 -profile:v main -crf 20 -sc_threshold 0 -g 48 -keyint_min 48 -hls_time 4 -hls_playlist_type vod -b:v 1400k -maxrate 1498k -bufsize 2100k -b:a 128k -hls_segment_filename $output_path/480p_%03d.ts $output_path/480p.m3u8 \
  -vf scale=w=1280:h=720:force_original_aspect_ratio=decrease -c:a aac -ar 48000 -c:v h264 -profile:v main -crf 20 -sc_threshold 0 -g 48 -keyint_min 48 -hls_time 4 -hls_playlist_type vod -b:v 2800k -maxrate 2996k -bufsize 4200k -b:a 128k -hls_segment_filename $output_path/720p_%03d.ts $output_path/720p.m3u8 \
  -vf scale=w=1920:h=1080:force_original_aspect_ratio=decrease -c:a aac -ar 48000 -c:v h264 -profile:v main -crf 20 -sc_threshold 0 -g 48 -keyint_min 48 -hls_time 4 -hls_playlist_type vod -b:v 5000k -maxrate 5350k -bufsize 7500k -b:a 192k -hls_segment_filename $output_path/1080p_%03d.ts $output_path/1080p.m3u8

rm video.$input_extension
cd $output_path

echo '#EXTM3U
#EXT-X-VERSION:3
#EXT-X-STREAM-INF:BANDWIDTH=800000,RESOLUTION=640x360
360p.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=1400000,RESOLUTION=842x480
480p.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=2800000,RESOLUTION=1280x720
720p.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=5000000,RESOLUTION=1920x1080
1080p.m3u8' > master.m3u8
