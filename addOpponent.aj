//Wan Koo
package c4.ext;

import java.awt.Color;
import c4.base.BoardPanel;
import c4.base.C4Dialog;
import c4.base.ColorPlayer;

//aspectJ file to swap between players between turns
public privileged aspect addOpponent {

	private BoardPanel C4Dialog.boardPanel;
	
	//makes new instances of players to swap between.
	ColorPlayer Blue = new ColorPlayer("Blue", Color.BLUE);
	ColorPlayer Red = new ColorPlayer("Red", Color.RED);
	
	//gets called after the execution of makeMove
	after(C4Dialog message): this(message) && execution(void C4Dialog.makeMove(..)) {
		
		//uses if  statements to differentiate between the 2 players
		if (message.player.name().equals("Red")) {
			message.player = Blue; //changes the player to red
			message.boardPanel.setDropColor(message.player.color());
			message.showMessage(message.player.name() + "'s turn");
		}
		
		
		else if (message.player.name().equals("Blue")) {
			message.player = Red; //changes the player to blue
			message.boardPanel.setDropColor(message.player.color());
			message.showMessage(message.player.name() + "'s turn");
		}

	}
	
	after(C4Dialog message) returning (BoardPanel panel):
		this(message) && call(BoardPanel.new(..)){
		message.boardPanel= panel;	
	}

}