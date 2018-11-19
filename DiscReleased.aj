package c4.ext;

import java.awt.*;
import java.awt.event.*;

import c4.base.BoardPanel;

privileged aspect DiscReleased {
	
	private int BoardPanel.mouseSlot = -1;
	private Color at = new Color(0x00BBD4);
	
	pointcut overDisc(BoardPanel b):
		execution(BoardPanel.new(..))&&this(b);
		after(BoardPanel b):overDisc(b){
			b.addMouseListener (new MouseAdapter () {
				
				public void mouseReleased(MouseEvent e) {
				if(!b.board.isGameOver()) {
					b.mouseSlot = b.locateSlot(e.getX(), e.getY());
					b.repaint();
				}
			}
				
			});
		}
	
	pointcut returnForm(BoardPanel b, Graphics g):
		execution(void BoardPanel.drawDroppableCheckers(Graphics))&&this(b)&&args(g);
	after(BoardPanel b, Graphics g):returnForm(b,g){
			System.out.println("Pressed => " + b.mouseSlot + " Color => ");
		if(b.mouseSlot>=0 && b.board.isSlotOpen(b.mouseSlot)) {
				b.drawChecker(g, b.dropColor, b.mouseSlot, -1, 0);
//				b.mouseSlot = -1;
//				b.repaint();
		}
	}
		
}

