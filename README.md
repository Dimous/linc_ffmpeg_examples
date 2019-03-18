linc_ffmpeg_examples
=============

OpenFL demo of using linc_ffmpeg.

Even though this demo compiled in static mode you still need to copy dlls from `shared` ffmpeg build (https://ffmpeg.zeranoe.com/builds/) next to `bin/demo.exe`

## Issues & drawbacks

* tested only on Windows (but should work on all major platforms)
* FPS drops on big resolutions (as we can't drill down to the SDL layer for _texture streaming_, we are passing video frames pixel by pixel)
* frequent setPixels/setPixel32 calls result in `version` variable overflow -- https://github.com/openfl/lime/blob/develop/src/lime/_internal/graphics/ImageDataUtil.hx#L1268 😥

## To do

* workaround for bitmap drawing issue (WIP [will encode frames to PNGs and use BitmapData.fromBytes to read them])
