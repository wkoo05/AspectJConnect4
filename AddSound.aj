package c4.ext;

import java.io.IOException;
import javax.sound.sampled.AudioInputStream;
import javax.sound.sampled.AudioSystem;
import javax.sound.sampled.Clip;
import javax.sound.sampled.LineUnavailableException;
import javax.sound.sampled.UnsupportedAudioFileException;

import org.aspectj.lang.annotation.After;

import c4.model.Board;
import c4.model.Player;

public aspect AddSound {
	private static final String SOUND_DIR = "/sound/";
	public static void playAudio(String filename) {
	     try {
	         AudioInputStream audioIn = AudioSystem.getAudioInputStream(
	         AddSound.class.getResource(SOUND_DIR + filename));
	         Clip clip = AudioSystem.getClip();
	         clip.open(audioIn);
	         clip.start();
	     } catch (UnsupportedAudioFileException 
	           | IOException | LineUnavailableException e) {
	         e.printStackTrace();
	     }
	   }

	
	pointcut discDropped(): execution(int Board.dropInSlot(int, Player));
	after(): discDropped() {
		playAudio("wowc.wav");
	}
	/*
	@After(execution(int Board.dropInSlot(int, Player))
			public static void playAudio(String filename) {
	     try {
	         AudioInputStream audioIn = AudioSystem.getAudioInputStream(
	         AddSound.class.getResource(SOUND_DIR + filename));
	         Clip clip = AudioSystem.getClip();
	         clip.open(audioIn);
	         clip.start();
	     } catch (UnsupportedAudioFileException 
	           | IOException | LineUnavailableException e) {
	         e.printStackTrace();
	     }
	   }
	   */
}
