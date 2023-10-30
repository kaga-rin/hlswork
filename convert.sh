# Change input and output details

output_path="za" # Output Path (Same will be pushed in main also)
input_url="https://video-downloads.googleusercontent.com/ADGPM2lwfuTt1RSDFoc1uaRpKDQ53d6cjRFbVLcNHgcex5FA1Z_P4CszgbzPlSfZbDZCY6njYWFnD424bRVmT6SdYChPGqq7lsHu6zHAjKjWQeBOEel-8GblfbmoGWzfBRSTQcXTaEk-Db5TRd8wM_WgXuYtk7YND8yXL9Okzk6nzwbkot5IAThjTjAKeqMXiNs6AwwwMCaLxw0wwJHnOCpq40ci9T5AhnldLfymNGy24z2VmywbMuskBM9NJlXmVM-D-8827lH4zLiCYT9sE9O-jHc5FfGxpiMjbrwyQoDp_ikStHEa8M90IJ5wrDLivfTC1jr8439URtGIzKQ2egFoA4Nw2mQ96mmXPq6gCZrgpFxmrmcwnt5kTLEDTKLNJUhx23VEg_wH_XbehChC16ACVT2Wz3mj7Sw3xVo8z7ohh2bL5FL5dXGtuYJr6MjWahbUbOkDNmjCETbWiRCEpyInbSHZJ8Mj3D-JNZju55NIF3cA4HWJx0m7W8N87_Pz1ka18IhI4RZYJ0qshYyTugpZhxDIRccHYnw5HeyRxZR6vHO9yaMPwtLtGsBXkBIlKvLHed4kj_FDaPDVcVwWFRSbjnIklkxJB-txUJuUQbQ0PUO5-dKLbletJVWZsDizZw3bB-qv4Zr_nnDS_voipo94UI-S4ckukOPNPBDUGC6pust9fdJpPixSepPHRDV1Xjf1nnUmSlMffhBd-26JqlCoFRD_K4KwNL1ul9JbWINz53cWxtVJjmTCDfryC01LUE35gosh6qNz42z-QAHT0LqzLZuNYJbmSS4iAS8c5o4-YFDDLgEmmJGYneCfOkPlwJcGQruF_Xa6V-DIOK0WOTaUocTVX7OwmSCHOYLlEGcQSWDOmPYtXFxZBnMNuuv6VcwEUL_rTCeiLlVsQi0IDWdIXx4NRnPFfwUqm237JQrEFgOmR6f2D_uannboSi01UbQNI1nfKeR-0_78MVGEr3xAqdPCUIdKCdsxoij-V0PFQiDs6gBBOaOSttFeGU6OykCZBcfZpLCsXx1n4Pz1UEXZYJIfszG_ZR6yUrCvUchyknIiekH8-BsCV6hih3eR5PXEBwiPXDLK" # Input direct file url
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
