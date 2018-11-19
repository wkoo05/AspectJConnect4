package c4.ext;
import c4.model.*;
import javax.swing.JFrame;
import javax.swing.JOptionPane;
import c4.model.Player;
import c4.base.C4Dialog;



privileged public aspect EndGame {
	
	//pointcut to check if the game has ended.
	//Calls either dropInSlot or makeMove depending on the condition
	pointcut endGame (C4Dialog message): this(message)
	&& (call(int Board.dropInSlot(int, Player)) || call(void C4Dialog.makeMove(int)));
	
	after(C4Dialog message): endGame(message) {
		//checks to see if there is a winner by checking isWonBy
		if(message.board.isWonBy(message.player)) {
			AddSound.playAudio("AWESOME.wav");
			JOptionPane.showMessageDialog(new JFrame(), message.player.name()
					+ " has won", "Dialog", JOptionPane.INFORMATION_MESSAGE);
		}
		
		else {
			//checks the board if it is full
			if(message.board.isFull()) {
				JOptionPane.showMessageDialog(new JFrame(), "You have drawn", "Dialog",
						JOptionPane.INFORMATION_MESSAGE);
			}
		}
	}
	
	//pointcut to stop the game once they have drawn or won
	pointcut stopGame(C4Dialog stop): execution(* makeMove(int))
	&& target(stop);
	void around(C4Dialog stop): stopGame(stop) {
		if(!stop.board.isGameOver()) { //checks to see if isGameOver is true which the game has ended either by win or draw
			proceed(stop);
		}
	}
	
}
