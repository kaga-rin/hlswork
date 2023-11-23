# Change input and output details

output_path="yaya" # Output Path (Same will be pushed in main also)
input_url="<video controls width="300">
    <source src="https://video-downloads.googleusercontent.com/ADGPM2lHgtLtRBze_sQ2IwRlBOUtCezOt8gDwp2TunXDE9GnNiun44BprEfSqE3wI0gFjx2o-C9xayRE9_AlDNmeV3sqfRO_t8UbUVzydkwAKXjSNa1CZj5A0GiEa5dmA8wCmCTKpos4b6hqZcIRUl7Wtg7vPd4A9w_PAcp3Uh783NS9D4HWK6fhNUKcSujzRG5iiTIjUac5JPt9DftPKse9d5O-5DGDlXWdlXKob4o59rJFFmUr3lfUm_XZToBgBVL5X8gZ9Eya_t_tQjFK-HKOlj0e5Zk2nd8E2ycIHMRhVhuAxcTj9_pK715_j01h-LQa4V7U8W8AiXRloHE2qjp2_D2JaCEb047rdbp8dAmSoQyEs8LdC6ySzU9-yLv7S3z8fCF_a5xizc8Hvl721SDVRIlJMqjhkdLLa8S7Dx8j4VEPQFbTgbmB1h2CEEL3bfEKErnybUutL_gdclmmdPf9WrZp0uY39Bg-c8uIOYziB5l4RfOHyQ-F6l1dkKG6mLEb2-up7Vv-d_JLV841Y7mamiflGXL5sbWiFjKvmes1cuJ2Wfogysd86H5TGl3dQeBLZiy5ufyTY-kaoPHQoelFxitGxeepLFBFQ3COdzPb9jHwXUb1ozsWkeLcViNj7I7bkzUp3OzPkyFUTxg7CjjUqEqCdWSuiC1D4qOCeHKcO7FuWG4eUuN3CyfXM7DuvxSXUx-9v0Ug0NSw5IOGBsdcWcvlUexDQWRwXUVitK-j153n3BqPPK8_kheasxXQenj1CxDEYGSWm7FCKsZR-8eg73XtMU3bmlXY0Y8n59RGK99Mwg0H69K583UnsrfQIj9XuOozvDOV04b-gHyQTFu9I3oOFpPGAqbQKAX0nQ29tjtEG6vKeAOqXZuHJnVytJ6igZHo0KsPDVNINp1LFUwLuLslQGOglmyFlaS8VYk2EfS3P5Tm-fGYc32T2QoWYqLfDicPObiZ3rXv2yhPI27O7gYwNLH0S3oaKQ-qaG2ujuPvsW2dudSECXn740zwEOT5BQkZsIqau_4zolvmSl1aLVQMsH-uavNGksikJJ7L0NUpUuiEVfelm_yCIXY32pvwVB4VXV5xuQSzm44LdlB8UToGUxuqJdh8B3FwInGERGbbcVD0z8Lv79oz49psZcuNEl2b8cdl0vl-stRtazvLl_KmPwUi7sjTzVwgbjnCZLtcZY_odTrMkCxngr1Yat2uXmos5HJX" >

    Sorry, your browser doesn't support embedded videos.
</video>"
input_extension="mkv" # Extension of file url



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
