package c4.ext;

import java.awt.Color;
import c4.base.BoardPanel;
import c4.base.C4Dialog;
import c4.base.ColorPlayer;
import c4.model.Player;
import c4.model.*;

/*
public privileged aspect addOpponent {
	private BoardPanel C4Dialog.boardPanel;
	ColorPlayer Blue = new ColorPlayer("Blue", Color.BLUE);
	ColorPlayer Red = new ColorPlayer("Red", Color.RED);
	
	after(C4Dialog dialog): this(dialog) && 
	execution(void C4Dialog.makeMove(..)) {
		if(dialog.player.name().equals("Blue")) {
			dialog.player = Red;
			dialog.boardPanel.setDropColor(dialog.player.color());
			dialog.showMessage(dialog.player.name() + "s turn.");
		}
		
		else if(dialog.player.name().equals("Red")) {
			dialog.player = Blue;
			dialog.boardPanel.setDropColor(dialog.player.color());
			dialog.showMessage(dialog.player.color());
		}
	}
	
	after(C4Dialog dialog) returning(BoardPanel.panel): this(dialog)
	&& call(BoardPanel.new(..)) {
		dialog.boardPanel = panel;
	}
}
*/

public privileged aspect addOpponent {

	private BoardPanel C4Dialog.boardPanel;
	
	ColorPlayer Blue = new ColorPlayer("Blue", Color.BLUE);
	ColorPlayer Red = new ColorPlayer("Red", Color.RED);
	after(C4Dialog dialog): this(dialog) && execution(void C4Dialog.makeMove(..)) {
		if (dialog.player.name().equals("Blue")) {
			dialog.player = Red;
			dialog.boardPanel.setDropColor(dialog.player.color());
			dialog.showMessage(dialog.player.name() + "'s turn");

		} else if (dialog.player.name().equals("Red")) {

			dialog.player = Blue;
			dialog.boardPanel.setDropColor(dialog.player.color());
			dialog.showMessage(dialog.player.name() + "'s turn");

		}

	}
	after(C4Dialog dialog) returning (BoardPanel panel):
		this(dialog) && call(BoardPanel.new(..)){
		dialog.boardPanel= panel;
		
	}

}