package modelos;

public class Carta {
    public static final String[] palos={"Oros, Copas, Espadas, Bastos"};
    public static final String[] numerosYFiguras={"Uno, Dos, Tres, Cuatro, Cinco, Seis, Siete, Sota, Caballo, Rey"};
    private int codigo;
    public Carta(int cod){
        this.codigo = cod;
    }

    int getCodigo(){
        return this.codigo;
    }

    String getPalo(){
        return Carta.palos[(int)(this.codigo/10)];
    }

    String getNumeroAsString(){
        return Carta.numerosYFiguras[(int)(this.codigo%10)];
    }

    public int getNumeroAsInt(){
        return (int)(this.codigo%10);
    }
}
