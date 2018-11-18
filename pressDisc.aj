package c4.ext;

public aspect pressDisc {
	
	pointcut slotChosen(): call(void BoardPanel.addMouseListener(MouseListener)*)
	
	before(): slotChosen() {
		System.out.println("Slot located");
	}
	
}

