# remove fisheye via fragment shader


## Building

```sh
sudo apt-get install git gcc nasm make libglew-dev libglfw3-dev libx264-dev

mkdir ~/dev
cd ~/dev
git clone https://git.ffmpeg.org/ffmpeg.git ffmpeg
git clone https://github.com/nervous-systems/ffmpeg-opengl.git ffmpeg-opengl

cd ffmpeg
ln -s ~/dev/ffmpeg-opengl/vf_genericshader.c ./libavfilter/
ln -s ~/dev/ffmpeg-opengl/genericshader.glsl ./
git apply ~/dev/ffmpeg-opengl/FFmpeg.diff
./configure --enable-libx264 --enable-filter=genericshader --enable-gpl --enable-opengl --extra-libs='-lGLEW -lglfw'
```

## Running

```sh
./ffmpeg -i input.mp4 -vf genericshader -y output.mp4
```

## License

ffmpeg-opengl is free and unencumbered public domain software. For more
information, see http://unlicense.org/ or the accompanying UNLICENSE
file.
