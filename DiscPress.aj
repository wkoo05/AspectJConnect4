package c4.ext;

import java.awt.*;
import java.awt.event.*;

import c4.base.BoardPanel;

privileged aspect DiscPress {
	
	private int BoardPanel.mouseSlot = -1;
//	private Listener 
//	private Color at = new Color(0);
	
	pointcut overDisc(BoardPanel b):
		execution(BoardPanel.new(..))&&this(b);
		after(BoardPanel b):overDisc(b){
			b.addMouseListener(new MouseAdapter() {
				
				public void mousePressed(MouseEvent e) {
					if(!b.board.isGameOver()) {
						b.mouseSlot = b.locateSlot(e.getX(), e.getY());
						System.out.println(b.mouseSlot);
						b.repaint();
					}
				}
				
			});
		}
	
	pointcut colorClicked(BoardPanel b, Graphics g):
		execution(void BoardPanel.drawDroppableCheckers(Graphics))&&this(b)&&args(g);
	after(BoardPanel b, Graphics g):colorClicked(b,g){
			System.out.println("Pressed => " + b.mouseSlot + " Color => ");
		if(b.mouseSlot>=0 && b.board.isSlotOpen(b.mouseSlot)) {
				b.drawChecker(g, Color.BLACK, b.mouseSlot, -1, 1);
		}
	}
		

}