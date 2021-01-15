void setup()
{
 size(600, 600); // définit la taille de la fenêtre
 background(100); // définit la couleur du fond de la fenêtre, ici 100 veut dire gris
 fill(255, 0, 0); // remplit le cercle en rouge
 ellipse(width/2, height/2, 50, 50);
}
void draw()
{
 fill(0, 0, 255); // remplit le cercle en bleu
 ellipse(width/2, height/2, 50, 50);
}
