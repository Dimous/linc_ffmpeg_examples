package io.github.dimous.demo;

import openfl.utils.Timer;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.events.MouseEvent;
import openfl.events.TimerEvent;
import openfl.display.BitmapData;

import io.github.dimous.ffmpeg.IOException;
import io.github.dimous.ffmpeg.EInputFormat;
import io.github.dimous.ffmpeg.log.Appender as LogAppender;
import io.github.dimous.ffmpeg.log.Transmitter as LogTransmitter;

import io.github.dimous.media.OpenALOutput as MediaIO;

class Main extends Sprite {
	public function new() {
		super();

		LogTransmitter.setActive(true);

		LogTransmitter.onMessage = LogAppender.accept;		

		final mediaio = new MediaIO(), timer = new Timer(1000 / 60), bitmap = new Bitmap(), format = mediaio.listInputFormats().filter(format -> DSHOW == format.getName()).pop();

		bitmap.x = 50;
		bitmap.y = 50;

		this.addChild(bitmap);

		mediaio.onStreamEnd = function () trace("stream ended", timer.currentCount);
		mediaio.onBitmapData = function (bitmapdata) bitmap.bitmapData = bitmapdata;

		timer.addEventListener(TimerEvent.TIMER, function (_) mediaio.read());

		try {
			// test 1
			mediaio.open(196, 312, null, null, "./assets/video/sample.webm"/* you can even pass url here, for example -- http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4 */);
			timer.delay = 1000 / mediaio.getFrameRate();

			// test 2: stream webcam output (DSHOW/VFWCAP on Windows, AVFOUNDATION on iOS, VIDEO4LINUX2 on Linux, ANDROID_CAMERA on Android)
			// mediaio.open(640, 480, null, format, "video=" + mediaio.listInputDevices(format).pop().getId());
			// timer.delay = 1000 / mediaio.getFrameRate();

			// test 3
			// mediaio.open(1, 1, null, null, "./assets/sound/sample.mp3");
			// timer.delay = 1000 / mediaio.getFrameRate(AUDIO);

			timer.start();
		} catch (exception: IOException) mediaio.close();
	}
}
