package c4.model;

/**
 * A player of the Connect Four game. Each player has a name.
 */
public class Player {

    /** Name of this player. */
    private final String name;

    /** Create a new player of the given name. */
    public Player(String name) {
        this.name = name;
    }

    /** Return the name of this player. */
    public String name() {
        return name;
    }
}