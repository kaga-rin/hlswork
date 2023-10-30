# Change input and output details

output_path="ww" # Output Path (Same will be pushed in main also)
input_url="https://video-downloads.googleusercontent.com/ADGPM2lanbKPQ1_a5Pb0PigcfdyFGZp4ruvh4Ew8uygEHs6nNJ0tFzUQbu-AXJ1IMwRfR-DR0EhkFl1Mtf7bwoX7Ij3GMXGl3iEAe9UkkFOZ2sOHCtWOCwT9b9DYX7032ueDfvrlo0eP4LOPkXDiCaj8SeXM65Nq84IdMMmbqYQiZtRhh19YOiHIqpntU-39zV0t-i0_072MRIIulrq-hkl3sx1X3FX3l87lTunX5UAxHUZx2g4GnwwHix8zgCjxjMavJ1XMmpW-tWbSaH3P0PhVx1FGeR2YPHSOioD2fFnqhhHfI7kQ9cV4CyJnIvsxObFRQs3XqC7OnRnuXZ04Izx8ktn1eiIzALUH5Y-RoB5SzYVaL1sEp4fqE_dXo_KWjdrcOZM1NhHL4U56CKljzw-DACiOngYPI6Ob1gKMQWXnweHVmQO0RTi9ZnvgwxPT549qkrbrGzn0edRNP9mUv3THh4nMSV_Nhs-9dV70JimV__tv4mKLb1r_8paokoZktLAnOyqYdcJ32muY7vmi_zxxGUaigftIHU8sEkb0EZcmxMwkg1QsM7W5w0-a1XaKF0W4nB0ciy6jsVTwUJmQs5K9hJ701NA7NOCwmGZ0pwg3S4fRp1xBaPX6abVLW31dqiBzsV3dy2aoWL2wOe8Ob63ywEKUdqGOcS-qTm0i4hiorpytU286bY_pc_botWjocw_0OUSk_7KHiXxCImHLPLZb8ZO4qGBBuyVXzw777eMX-3UfIjuIqE4h8771l8IxFRUR7JjlWOLXEqjYGx7dPnqzmRZurA-qyhNRKpT3_lwkSLvH9jwwA4y25DWsyeS2U6Cv-eljmCdlCS5FUjkGS5hRtg_1mLmxMMIHWcVFKgCtt3WqpK7Z-fTgYp0y1a7r0pFjlbxZ81jQISNNOi9pAXL6OikvxzTWN4vyzhKb1c3kdmpveMPx4lJdsXSmjxLsbT-QR8OhfNbWkL6kfYVS0LLjINUDgXg3ELrOLd_T0XlaCaCiOZKlEKgOyW0hmO9hYqqfX81t5vWuJ6bEdpO1cp0YZ0fyShHePPzQVaL3d3wOKlVCvpb_ANwylcVcoWJ7QrfP3uFrAZMf" # Input direct file url
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
