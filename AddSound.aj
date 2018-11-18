package c4.ext;
import java.awt.Color;
import java.io.IOException;
import javax.sound.sampled.AudioInputStream;
import javax.sound.sampled.AudioSystem;
import javax.sound.sampled.Clip;
import javax.sound.sampled.LineUnavailableException;
import javax.sound.sampled.UnsupportedAudioFileException;
import c4.base.C4Dialog;

//method for adding sound into the game.
public privileged aspect AddSound {
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

	//pointcut after the execution of makeMove
	pointcut discDropped(C4Dialog human): execution(void C4Dialog.makeMove(int))
	&& this(human);
	after(C4Dialog human): discDropped(human) {
		//plays audio 1 if blue player
		if(human.player.color() == Color.BLUE) {
			playAudio("futuresoundfx-1.wav");
		}
		//plays audio 2 if red player
		else if(human.player.color() == Color.RED) {
			playAudio("futuresoundfx-6.wav");
		}
	}
	
}
