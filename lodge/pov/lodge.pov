#include "colors.inc" 
#include "woods.inc"
#include "textures.inc"

#declare Hx = 3; // half width in x
#declare Hy = 8; // total height
#declare Hz = 9; // length in z 
 

//небо 
object { sphere{ <0, 0, 0>, 1 no_shadow
  texture { Blue_Sky scale .2 }}
  scale <300, 100, 300> 
}

//зима 
#declare snow_patch = object { blob {
 threshold 0.5
  component 1,.6,  <-2.5, .5,  0>   component 1,1    <2.5,  0,  -2>
  component 1,1,   <-2,   .4,  0>   component 1,1.3, <2,    0,  -2>
  component 1,1.2, <-1.5,  0,  0>   component 1,.8,  <1.2,  .3, -2>
  component 1,1.1, <0,     0,  0>   component 1,1.1, <0,    0,  -2>
  component 1,.8,  <1.2,  .3,  0>   component 1,1.2, <-1.5, 0,  -2>
  component 1,1.3, <2,     0,  0>   component 1,1,   <-2,   .4, -2>
  component 1,1    <2.5,   0,-.5>   component 1,2,   <-2.5, .5, -2>
  component 1,.8,  <1.,   .3, -1>   component 1,.8,  <1.2,  .3, .5>

 texture { pigment { White } finish { ambient .7 diffuse .3 }}}
 } 

//снег на участке
    difference{
    object { snow_patch scale <4,0.5,4> translate <-4,0,3>  }
    box{
     <-Hx,0,0> 
     <Hx,Hy,Hz>                
     }
     }
     difference{
    object { snow_patch scale <4,.5,4> translate <-2,0,5> }
    box{
     <-Hx,0,0> 
     <Hx,Hy,Hz>               
     }
     }
     difference{
    object { snow_patch scale <4,.5,4> translate <0,0,7> } 
    box{
     <-Hx,0,0> 
     <Hx,Hy,Hz>                
     }
     }
     
//снежный пол
object { plane {y,0} pigment {White}  finish { ambient .7 diffuse .3 }
         normal { bumps 0.2 }}
//Ель: 
#declare needle=sphere{<0,0,0>,1 scale<.75,.1,.1> pigment{rgb<.2,.5,.2>}}
#declare branch_text=texture{pigment{rgb<.5,.4,.2>} normal{bumps.9 turbulence .7 scale .025}}
#declare maxheight=30;
#declare r=seed(777);
#declare xtree=union{

  cone{<0,0,0>,maxheight/50,<0,maxheight,0>,maxheight/200 texture{branch_text}}
  sphere{<0,maxheight,0>,maxheight/175 texture{branch_text}} 
  #declare cc=maxheight/15;
  

  #while (cc<maxheight)

  union{
    #declare i=0;
    #declare dd=(maxheight*.95-cc)/2.5;
 
    #while (i<dd)
    union{
      sphere{<0,0,0>,.2 scale <1,2.5,1> texture{branch_text}}
      #declare j=60*rand(r);   
      #while (j<360)
        object{needle translate -x rotate z*-15-i*45/dd rotate y*j+30*rand(r)}
      #declare j=j+60;
      #end

      scale 1-.25*i/dd
      translate y*i 
  }

  #declare i=i+.4;
  
#end

rotate z*(-75+cc/2)
rotate y*360*rand(r)
translate y*cc
}

  #declare j=0;
  #while (j<360)
    object{needle translate -x rotate z*(-45-15*rand(r)) translate -x*maxheight/400 rotate y*j+30*rand(r) translate y*cc}
  #declare j=j+60;
  #end

#declare cc=cc+.25;
#end

}


#declare snowtree=union{
object{xtree pigment{rgb<.2,.5,.2>}}
object{xtree pigment{rgb<.95,.975,1>} finish{ambient .7} translate y*.5}
}


object{snowtree translate <-30,0,120> scale<0.1,0.1,0.1>}
object{snowtree translate <50,0,120> scale<0.1,0.1,0.1>}
object{snowtree translate <16,0,-40> scale<0.2,0.2,0.2>}
object{snowtree translate <100,0,0> scale<0.1,0.1,0.1>}
  
//положение камеры 
camera { 
         angle 60
         location  <27, 10,20>
         right     x*image_width/image_height
         look_at   <3 , 4, 4>
                           }
// стол и скамейки                           
  #declare Table =
union {                 
        lathe {
                cubic_spline
                14
                <0,0> <1,0> <1,.25> <.5,.25> <.5,.75> 
                <.75,1> <.5,1.25> <.5,1.5> <.5,3> <1,3.25>  
                <2.5,3.5> <2.5,3.75> <0,3.75> <0,3.75>
        }

        #declare Cone =
        cone {
                <10,0,0>2 <0,0,0>1 
        } 
        
        
        #declare Benchtop =
        difference {
                cylinder {
                        <0,0,0> <0,.25,0> 4.5
                }
        
                cylinder {
                        <0,-1,0> <0,1,0> 3.25
                }                  
        
                #declare N = 3;
                #declare C = 0;
                #while ( C < N )
	                object { Cone rotate (360/N*C)*y } 
	                #declare C = C + 1;
                #end   
        } 
        
        object { Benchtop translate <0,1.5,0> }  

        #declare Leg =
        lathe {
                cubic_spline 
                6
                <0,0> <0.5,0> <0.5,1> <0.3,2> <0.5,4> <0.2,5>
        }          


        #declare N = 3;
        #declare C = 0;
        #while ( C < N )
                object {  Leg scale .4 translate <-3.5,0,1.5> rotate (360/N*C)*y } 
                object {  Leg scale .4 translate <-3.5,0,-1.5> rotate (360/N*C)*y } 
                #declare C = C + 1;
        #end   


} 

object { Table translate <40,0,20> scale<0.3,0.3,0.3>
texture { T_Wood12  scale 4 }  } 

//свет
light_source
{ <0,3.6,4.5>
  color rgb <2.18,1.6,0.32>
}

light_source
{ <20,20,20>
  color 1
}

//оси
 
//cylinder {
//    0, 100*x, 0.03                       
//    pigment {  Red }       
//}
//
//cylinder {
//    0, 100*y, 0.03                       
//    pigment {  Green }       
//}
//
//cylinder {
//    0, 100*z, 0.03                       
//    pigment {  Blue }       
//}

#declare Win1 =  box{
    <4,4.5,8> 
     <2,5.5,6.5>      
     }
//коробка

difference{
box{
     <-Hx,0,0> 
     <Hx,Hy,Hz>  
  texture{  
      pigment
          { brick rgb <0.82,0.71,0.55>, rgb <1.89,1.83,1.07>
            scale 0.2                                     
          }
          finish  { specular 0.9 }
          normal  { agate 1 scale 1/2 }
          }                 
     }
//окна     
 object {Win1}
 object { Win1 translate <0,0,-5.5>} 
 object { Win1 translate <0,-3,-5.5>}
 object { Win1 translate <0,-3,0>}
 object { Win1 translate <0,-3,-2.75>}
 object { Win1 translate <-6,-3,-5.5>}
 object { Win1 translate <-6,-3,0>}
 object { Win1 translate <-6,-3,-2.75>}
  object { Win1 translate <-6,0,-5.5>}
 object { Win1 translate <-6,0,0>}
 object { Win1 translate <-6,0,-2.75>}
 
 box{
    <-2,4.5,10> 
     <2,6,8>      
     }
 //дверь входная    
  box{
    <0.5+0.1,0.3-0.1,8.8> 
     <-0.5-0.1,2+0.1,9.2>      
     }
 //срез крыши
 plane{<0,-1,0>,0
     texture{ pigment{color rgb<1,1,1>}
              finish {diffuse 0.9}
            }
     rotate<0,0,35>
     translate<0,Hy,0>
    }
 plane{<0,-1,0>,0
     texture{ pigment{color rgb<1,1,1>}
              finish {diffuse 0.9}
            } 
     rotate<0,0,-35>
     translate<0,Hy,0>
    }
//формирование стен в доме    
 box{
     <-Hx+0.2,0.2,0.2> 
     <Hx-0.2,Hy+10,Hz-0.2>  
     texture {T_Wood23 scale 4}                  
    } 
 //дверь балкона    
  box {
       <Hx+1,3.9,4> 
       <Hx-1,5.7,5>
  }
 }
 
 box{
    <-Hx+0.1,3.6,0.1> 
     <Hx-0.1,3.8,Hz-0.1>  
     texture {T_Wood26 scale 4}     
     }
 //балкон    
 difference{
 
 lathe {
  linear_spline 
  4        
  <0, 0.2>, <1.5, 0.2>, <1.5,0>, <0, 0>    
  texture { pigment{ color White*1}
                normal { bumps 0.5 scale 0.005} 
                finish { phong 1}
              }     
  translate <3,3.6,4.5>
  
  }
  
  box{
    <3,8,2> 
     <0,0,7>  
     }
 }
 
 difference{
 
 lathe {
  linear_spline 
  4        
  <0, 0.7>, <1.5, 0.7>, <1.5,0>, <0, 0>    
  texture {pigment {LightBlue filter .99} finish {reflection .2}}
interior {ior 1.1}
  translate <3,3.8,4.5>
  
  }
  
  box{
    <3,8,2> 
     <0,0,7>  
     }
  lathe {
  linear_spline 
  4        
  <0, 2>, <1.4, 2>, <1.4,0>, <0, 0>    
  texture {pigment {LightBlue filter .99} finish {reflection .2}}
interior {ior 1.1}
  translate <3,3.4,4.5>
  
  }

 }
 

//крыша     
#declare Roof_D = 0.10;
#declare Roof_O = 0.20; 
#declare Roof_L = Hx+0.80;
#declare Roof_Texture = 
      texture { pigment{ color Scarlet*1.3}
                normal { gradient z scallop_wave scale<1,1,0.15>} 
                finish { phong 1}
              }

 box { < -Roof_L, 0.00, -Roof_O>,< Roof_D/2, Roof_D, Hz+Roof_O>  
      texture {Roof_Texture translate<-0.05,0,0>}  
      rotate<0,0, 35>
      translate<0,Hy,0>
     }
box { < -Roof_L, 0.00, -Roof_O>,< Roof_D/2, Roof_D, Hz+Roof_O>  
      texture {Roof_Texture translate<-0.05,0,0>}  
      rotate<0,0, 35>
      translate<0,Hy,0> scale<-1,1,1>
     }
     
//дверь входная     
 box{
    <0.5+0.1,0.3,8.8> 
     <0.5,2.1,9>
     pigment{color rgb<0.26,0.25,0.25>}      
     }
 box{
    <0.5,2,8.8> 
     <-0.6,2.1,9>
     pigment{color rgb<0.26,0.25,0.25>}      
     }
  box{
    <-0.5,2,8.8> 
     <-0.6,0.2,9>
     pigment{color rgb<0.26,0.25,0.25>}      
     }
  box{
    <-0.5,0.3,8.8> 
     <0.6,0.2,9>
     pigment{color rgb<0.26,0.25,0.25>}      
     }
     
  box{
    <-0.5,0.3,8.85> 
     <0.5,2,8.95>
     texture { pigment{ color White*0.6}
                normal { bumps 0.5 scale 0.005} 
                finish { phong 1}
              }      
     }
   
  box{
    <0.02,0.3,8.83> 
     <-0.02,2,8.97>
     pigment{color rgb<0.26,0.25,0.25>}      
     }
     
  box{
    <0.5,0.9-0.02,8.83> 
     <-0.5,0.9+0.02,8.97>
     pigment{color rgb<0.26,0.25,0.25>}      
     }
     
   box{
    <0.5,1.5-0.02,8.83> 
     <-0.5,1.5+0.02,8.97>
     pigment{color rgb<0.26,0.25,0.25>}      
     }
   //ручка входной двери
   cylinder{
        <-0.4,1.2,8.8>, <-0.4, 1.2, 9.05>, 0.04
         pigment{color rgb<0.21,0.13,0.13>}}
         
    //ступенька
                 
   box{
    <-1.1,0,9> 
     <1.1,0.1,9.8>
     pigment{color rgb<0.26,0.25,0.25>}      
     }
   box{
    <-0.8,0.1,9> 
     <.8,0.2,9.5>
     pigment{color rgb<0.26,0.25,0.25>}      
     }
 
   //снеговик
   sphere {
    <6, 0.5, 8>, 0.5 //координаты центра и радиус

    pigment {White}  finish { ambient .7 diffuse .3 }
         normal { bumps 0.2 }
    }
    sphere {
    <6, 1, 8>, 0.35 //координаты центра и радиус

    pigment {White}  finish { ambient .7 diffuse .3 }
         normal { bumps 0.2 }
    }
    sphere {
    <6, 1.4, 8>, 0.25 //координаты центра и радиус

    pigment {White}  finish { ambient .7 diffuse .3 }
         normal { bumps 0.2 }
    }
    
    sphere {
    <6.23, 1.5, 8>, 0.03 
    }
    
    sphere {
    <6.15, 1.5, 8.2>, 0.03 
    }
    
    cone {
    <6.2, 1.45, 8.1>, 0.03    // Центр и радиус основания
    <6.35, 1.45, 8.2>, 0    // Центр и радиус вершины
    pigment{color rgb < 1,0.32,0>}
    }
    
    cylinder{
        <6,1,8>, <6.1, 1.2, 8.7>, 0.005
         pigment{color rgb<0.21,0.13,0.13>}}
     
     cylinder{
        <6,1,8>, <6.3, 0.8, 7.2>, 0.005
         pigment{color rgb<0.21,0.13,0.13>}}
         
     //дверь балкона
     
     box{
    <3,3.9,4> 
     <3-0.2,5.7-0.05,4.05 >
     pigment{color rgb<0.26,0.25,0.25>}      
     }
     
     box{
    <3,5.7-0.05,4> 
     <3-0.2,5.7,4.95>
     pigment{color rgb<0.26,0.25,0.25>}      
     }
     
     box{
    <3,5.7,5> 
     <3-0.2,3.95,4.95>
     pigment{color rgb<0.26,0.25,0.25>}      
     }
      box{
    <3,3.95,5> 
     <3-0.2,3.9,3.95>
     pigment{color rgb<0.26,0.25,0.25>}      
     }
    
    box{
    <2.85,3.95,4+0.05> 
     <2.95,5.65,5-0.05>
    texture {pigment {LightBlue filter .99} finish {reflection .2}}
interior {ior 1.1}
    }
    
    box {
      <2.95,5,4.75> 
     <2.98,5.02,4.85>
     pigment{color rgb<1,1,1>}
    }
    
    box {
      <2.85,5,4.75> 
     <2.82,5.02,4.85>
     pigment{color rgb<1,1,1>}
    }
    
   //окна
  #declare window = union {
   box {
      <3,4.5,6.5> 
     <3-0.2,5.5-0.05,6.5+0.05>
     pigment{color rgb<1,1,1>}
    }
    box {
      <3,5.5-0.05,6.5> 
     <3-0.2,5.5,8-0.05>
     pigment{color rgb<1,1,1>}
    }
    box {
      <3,5.5,8> 
     <3-0.2,4.5+0.05,8-0.05>
     pigment{color rgb<1,1,1>}
    }
    box {
      <3,4.5+0.05,8> 
     <3-0.2,4.5,6.5+0.05>
     pigment{color rgb<1,1,1>}
    }
    box {
      <3,4.5,7.22> 
     <3-0.2,5.5,7.27>
     pigment{color rgb<1,1,1>}
    }
    box
    {
        <2.95,4.5+0.05,6.5+0.05> 
     <2.85,5.5-0.05,8-0.05>
     texture {pigment {LightBlue filter .99} finish {reflection .2}}
interior {ior 1.1}
    }
    }
 object { window} 
 object { window translate <0,0,-5.5>}
 object { window translate <0,-3,-5.5>}
 object { window translate <0,-3,0>}
 object { window translate <0,-3,-2.75>}
 object { window translate <-5.8,-3,-5.5>}
 object { window translate <-5.8,-3,0>}
 object { window translate <-5.8,-3,-2.75>}
 object { window translate <-5.8,0,-5.5>}
 object { window translate <-5.8,0,0>}
 object { window translate <-5.8,0,-2.75>}
 
 //окно спереди 
 #declare win2 = union{
    box {
      <-2,4.5,9> 
     <-2+0.05,6-0.05,8.8>
     pigment{color rgb<1,1,1>}
    }
  box {
      <-2,6-0.05,9> 
     <2-0.05,6,8.8>
     pigment{color rgb<1,1,1>}
    }
  box {
      <2,6,9> 
     <2-0.05,4.5+0.05,8.8>
     pigment{color rgb<1,1,1>}
    }
  box {
      <2,4.5,9> 
     <-2+0.05,4.5+0.05,8.8>
     pigment{color rgb<1,1,1>}
     }
     
  box {
      <-2+0.05,5.275,9> 
     <2-0.05,5.325,8.8>
     pigment{color rgb<1,1,1>}
    }
    
  box {
      <-0.975,4.5+0.05,9> 
     <-0.925,6-0.05,8.8>
     pigment{color rgb<1,1,1>}
    }
  box {
      <-0.975+1,4.5+0.05,9> 
     <-0.925+1,6-0.05,8.8>
     pigment{color rgb<1,1,1>}
    }
  box {
      <-0.975+2,4.5+0.05,9> 
     <-0.925+2,6-0.05,8.8>
     pigment{color rgb<1,1,1>}
    }

    box{
    <-2+0.05,4.5+0.05,8.95> 
     <2-0.05,6-0.05,8.85>
    texture {pigment {LightBlue filter .99} finish {reflection .2}}
    interior {ior 1.1}
    } 
    }
    
    object {win2}