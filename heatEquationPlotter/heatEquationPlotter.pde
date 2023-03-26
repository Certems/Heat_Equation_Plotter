                       circularProblem p1 = new circularProblem();

void setup(){
    size(800,800);
}
void draw(){
    background(0,0,0);

    p1.progress();
    p1.display( new PVector(width/2.0, height/2.0) );

    overlay();
}
void overlay(){
    pushStyle();
    fill(255);
    textAlign(CENTER,CENTER);
    textSize(20);
    text(frameRate, 30,30);
    popStyle();
}


class circularProblem{
    //On UNIT disc
    float iRes = PI/150.0;  //Interval to evaluate pixels at for THETA
    float rRes = 3.0;       //Interval to evaluate pixels at for RADIUS
    float rSize = 150;  //Radial size of overall circle

    float t = 0;
    float tInterval = 1.0;

    circularProblem(){
        //pass
    }

    void progress(){
        t += tInterval;
    }
    void display(PVector cPos){
        for(float i=0; i<2.0*PI; i+=iRes){
            for(float r=0; r<rSize; r+=rRes){
                float solution = evaluateSolution( new PVector(r,i) );
                PVector col = valueToColour(solution);
                pushStyle();
                fill(col.x, col.y, col.z);
                noStroke();
                ellipse(cPos.x +r*cos(i), cPos.y +r*sin(i), rRes, rRes);
                popStyle();
            }
        }
    }
    float evaluateSolution(PVector polar){
        /*
        polar(r, theta)
        t + intervals already known by function
        */
        return ( polar.x/rSize )*exp(-0.005*t); //## NOTE IS NOT ACTUAL SOLVED SOLUTION, THIS IS JUST A COMPLETE BOLLOCKS EXAMPLE ##
    }
}

PVector valueToColour(float value){
    //Maps value between 0.0 and 1.0 -> red and green
    PVector col = new PVector(255, 0, 0);
    if(value < 0.5){
        col.y += 255*sin(PI*value);
    }
    if(value >= 0.5){
        col.y = 255;
        col.x -= 255*sin(PI*(value-0.5));
    }
    return col;
}
