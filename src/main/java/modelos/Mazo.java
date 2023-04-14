package modelos;
import java.util.ArrayList;
import java.util.Collections;

public class Mazo {

    private ArrayList<Carta> mazo;

    public static Mazo Instance = null;

    public Mazo() {
        this.init();
        this.barajar();

    }

    private void init() {

        mazo = new ArrayList<Carta>();

        for(int i = 1; i <= 40;i++)
            mazo.add(new Carta(i));
        
    }

    public Carta getCarta() {
        return mazo.get(0);
    }

    public void barajar() {
        Collections.shuffle(mazo);
    }

    public Carta extrae() {
        return mazo.remove(0);
    }
    
}
