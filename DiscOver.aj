package c4.ext;

import java.awt.*;
import java.awt.event.*;

import c4.base.BoardPanel;

privileged aspect DiscOver {
	
	private int BoardPanel.mouseSlot = -1;
	private Color blueHighLighted = new Color(0x00BBD4);
	private Color redHighLighted = new Color(0xF7B83B);
	
	pointcut overDisc(BoardPanel b):
		execution(BoardPanel.new(..))&&this(b);
		after(BoardPanel b):overDisc(b){
			b.addMouseMotionListener (new MouseMotionAdapter () {
				
				public void mouseMoved(MouseEvent e) {
					if(!b.board.isGameOver()) {
						b.mouseSlot = b.locateSlot(e.getX(), e.getY());
						b.repaint();
					}
				}
				
				public void mousePressed(MouseEvent e) {
					if(!b.board.isGameOver()) {
						b.mouseSlot = b.locateSlot(e.getX(), e.getY());
						System.out.println(b.mouseSlot);
						b.repaint();
					}
				}
				
			});
		}
	
	pointcut changeColor(BoardPanel b, Graphics g):
		execution(void BoardPanel.drawDroppableCheckers(Graphics))&&this(b)&&args(g);
	after(BoardPanel b, Graphics g):changeColor(b,g){
			System.out.println("Pressed => " + b.mouseSlot + " Color => "+ b.dropColor);
			
		if(b.mouseSlot>=0 && b.board.isSlotOpen(b.mouseSlot)) {
			if(b.dropColor == Color.BLUE) {
				b.drawChecker(g, blueHighLighted, b.mouseSlot, -1, 1);
			}else {
				b.drawChecker(g, redHighLighted, b.mouseSlot, -1, 1);
			}
		}
	}
		

}
