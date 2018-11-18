package c4.ext;
import c4.model.*;

import javax.swing.JFrame;
import javax.swing.JOptionPane;

import c4.base.*;
import c4.model.Player;
import c4.base.C4Dialog;



privileged public aspect EndGame {
	
	
	pointcut endGame (C4Dialog dialog): this(dialog)
	&& (call(int Board.dropInSlot(int, Player))
	|| call(void C4Dialog.makeMove(int)));
	
	after(C4Dialog dialog): endGame(dialog) {
		if(dialog.board.isWonBy(dialog.player)) {
			AddSound.playAudio("That Was Legitness Sound Effect.wav");
			JOptionPane.showMessageDialog(new JFrame(), dialog.player.name()
					+ " has won", "Dialog", JOptionPane.INFORMATION_MESSAGE);
		}
		
		else {
			if(dialog.board.isFull()) {
				JOptionPane.showMessageDialog(new JFrame(), "You have drawn", "Dialog",
						JOptionPane.INFORMATION_MESSAGE);
			}
		}
	}
	
	pointcut stopGame(C4Dialog stop): execution(* makeMove(int))
	&& target(stop);
	void around(C4Dialog stop): stopGame(stop) {
		if(!stop.board.isGameOver()) {
			proceed(stop);
		}
		else {
			
		}
	}
	
}
