package c4.ext;
import c4.model.*;
import c4.base.*;


privileged public aspect EndGame {
	
	
	pointcut gameWon(): execution(boolean Board.isWonBy(Player))
	&& call(int Board.dropInSlot(int, Player));
	after() returning(boolean t): gameWon() {
		if(t)
			System.out.println("Game won");
	}
	
	/*
	pointcut gameWon(): execution(boolean Board.isWonBy(Player))
	&& execution(int Board.dropInSlot(int, Player));
	boolean around(): gameWon() {
		boolean result = proceed();
		if (result = true)
			System.out.println("Game Won");
		return result;
	}
	*/
	/*
	pointcut gameFull(): execution(boolean Board.isGameOver());
	after() returning(boolean t): gameFull() {
		if (t)
			System.out.println("Result is draw.");
	}
	*/
}
