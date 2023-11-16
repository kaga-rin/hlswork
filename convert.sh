# Change input and output details

output_path="sp" # Output Path (Same will be pushed in main also)
input_url="https://video-downloads.googleusercontent.com/ADGPM2kJ1W93-7cuHPRrHls3PhmeJzD-8cORXPkkWRsRfQiYs4I5Sw4Y6ak5iXO32IpNpHMZY4eA0EMmQbCw1YiJsI_Rg_cCbvIRJjA4mtr7S7VBEvjVebY5WaZrYi6o5R2AVUR5o1dMUEknQ9Tb_vAu_MQgWjJFktsT1yRnKVISyZ8QpybuSiMn1vHfdOoacPAjWQt1_DAJ5nUXrBHjJvkhNwuD72JG1pholLMGTHpN8qhx7_MqbYTztHacSdqrm-rCjpURciJSG1yQSpXAfRnB5PnTKT5wRire3V2qnbpanhs29Bz4sTlzzwbi6Hm4TClFKQFT5-vk9vxr27dWViQCb4lMaEdmJwM2QIsJQsoeb6Wu6Ihcmd_Lla3zFj32WkhI_bcKwpS68IKk0hh26zx1D9GQC_zAd4k19hvmSZp9-nhsVgAJOnN3wHteAnfdbVI16o5yTXtGWBjKU5_-ghmRQjIFqo8Khp8vQmslAxw8U1GJDDXgGpF6qKTMud9qSgDnv8tCRZ-_QUlspS8zildWGY9Gl46kF_3bv68iK4gV7zRT_sIgShjdj_vbc4td7eMRGlKG_Zz-MvPhz8MiBBhWJt1DF-pyuAuuxZlo7SL76PXlWBv38X7dMy4p5O--VKeznFHMtNN910CxQEtJofUGuD-VXGiWFqkp-MZKBs3CPwh56Zd7W7XHK2-5dEqvUy95FO3sCT8kMGF1eTV3cbH83pI-a5SM2u8m5F8H9i6NWteX1A3BlQi6BaKUEqd9RsWPGlVB7vqx7x_dUfj221MOg1pKkp3kNFq_qthucVl3ywuO3rZV2VfNfczT1hmGCuFPELCE4bTo0f8dtW__NGVc1snxThos-ShYd8QKC04FnzmEerRlj_JW6q_z_7DzOBybVQJVFuO2jFEGaC3VWPTvrIveaEEep8kENBWxd1Et8XbBw0Or0ajuqjIP5e4ZlomEz1Uoh5y27rWs7K5iT2CmhKigckZF21WrjmWm8A7ik4rOM7NRP7PTw5P_nv75MeXHhCZpHocsUALGHGeNCUuPjSlkExTx35IkBN1IS-UsGaV8G7HNiq0Zs2spCiuGQefV6l5fpiG5"
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
