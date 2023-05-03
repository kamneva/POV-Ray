#include "textures.inc"
#include "shapes3.inc"
#include "colors.inc"
#include "skies.inc"
#include "glass.inc"
#include "maketree.pov"



//звезды 

   #declare galaxy_bgstars = 6;
   #declare galaxy_bgnebula = 3;
   #declare galaxy_nebula_sphere = false;
   #include "GALAXY.BG"

   #declare galaxy_nebula_sphere = 0;
   #declare galaxy_colour1 = <1, .5, .4> + <0, .5, .2> * (sin((clock - .25) * pi) + 1) / 2;
   #declare galaxy_colour2 = <0, .5, 1> + <1, -.3, -.3> * (sin((clock - .25) * pi) + 1) / 2;
   #declare galaxy_pattern_scale = 1 + .4 * sin(clock * 2 * pi);
   #declare galaxy_pattern_origin = <-10, 10, 10> + vrotate (z * .2, <45 * sin(clock * pi * 4), clock * 360, 0>);
   #include "GALAXY.BG"


//дерево

#declare dofile=false;   
#declare dotexture=true;  
#declare ffname="gtleaf2.inc"
#declare colBark=rgb <1,0.8,0.64>; 
#declare txtTree = texture{pigment{spiral1 8 turbulence 0.5 lambda 4 color_map{[0 color colBark*.3] [0.3 color colBark*0.5][0.9 color colBark][1 color colBark*.4] }} finish{ambient 0.1} scale <1,3,1>}                
texture{pigment{bozo turbulence 0.7 lambda 3 color_map{[0 color Clear][0.1 color colBark*.1] [0.4 color Clear][0.9 color Clear][1 color colBark*.4] }} finish{ambient 0.1}}   


#declare rsd=211;           
#declare rd=seed(rsd);  
#declare rdl=seed(rsd); 


#declare level0=4;        
#declare nseg0=10;      
#declare nb=7;          
#declare dotop=false;   

#declare lb0=35;       
#declare rb0=2;        
#declare ab0=95;     
#declare qlb=0.6;      
#declare qrb=0.4;      
#declare qab=0.7;      
#declare stdax=10;      
#declare stday=10;     

#declare branchproba=1; 
#declare jb=0.5;        

#declare fgnarl=0.4;    
#declare stdlseg=0;    

#declare twigproba=0.5; 

#declare v0=<0,1,0>;    
#declare pos0=<0,0,0>; 

#declare vpush=<0,0.2,0>;
#declare fpush=1;      
#declare aboveground=4;
#declare belowsky=140;  

#declare rootproba=1;   
#declare nroot=5;      
#declare vroot=<1,-0.1,0>;  
#declare yroot=<0,1.5,0>;   

#declare leafproba=1;   
#declare leaflevel=4;  
#declare alz0=40;      
#declare alx0=-20;      
#declare stdalx=40;     
#declare stdlsize=0.5;     

#declare colLeaf_1=rgb <0.4,1,0.3>*0.4; // green
#declare colLeaf_2=rgb <1,0.8,0.3>*0.8; // yellow
#declare colLeaf_3=rgb <1,0.2,0.1>*0.8; // red           
#declare txtLeaf=texture{
pigment{bozo turbulence 0.5        
        color_map{[0.0 color colLeaf_1][0.3 color colLeaf_2] [0.5 color colLeaf_3][0.7 color colLeaf_2][1.0 color colLeaf_1] }}       
        finish{ambient 0.1 specular 0.3 roughness 0.01}}
         
#declare lsize=0.4;     
#declare seg=10;        
#declare ll=5;          
#declare wl=1;          
#declare fl=0.5;       
#declare lpow=2;       
#declare al=100;       
#declare apow=1;        
#declare ndents=0;      
#declare nlobes=7;      
#declare alobes=280;    
#declare qlobes=0.6;                            
#declare ls=3;          
#declare ws=0.1;        
#declare as=10;         

//огоньки
#declare Ogon = union{
sphere { <0,0,0>, 0.25
     pigment {color rgbf<1.0, 0.6, 0.85,1>}    
   interior { 
         ior 1.4 
         } 
       }  
  
  light_source {
  <0,0,0>     // position
  color White
  spotlight    // specifies spotlight
  radius 3   // cone opening from its axis in degrees. Light start to dim outside of this.
}
}

//лопасти
#declare LM4 = merge{

box{<0.05,0,0> <0.2,4.5,0.1>}
box{<0.8,4.5,0.025> <0.75,1,0.075>}
box{<0.6,4.5,0.025> <0.55,1,0.075>}
box{<0.2,4.5,0.025> <0.8,4.4,0.075>}
box{<0.2,1,0.025> <0.8,1.05,0.075>}
#for (i,1, 24, 1)
box{<0.2,4.5-i*0.14,0.025> <0.8,4.5-i*0.14-0.025,0.075>}
#end

 texture{ DMFWood4    
                normal { wood 5 scale 2 rotate<0,0,0> }
                finish { phong 1 } 
                rotate<90,0,90> scale 25  translate<0,2,0>
              } // end of texture
}
//мельница
#include "shapes3.inc"
#declare Meln = union{ 
        object{ Pyramid_N( 8,    1.5,    0.9,   3.5 ) 
                texture{ pigment{ color rgb<1,1,1> }
                normal { pigment_pattern{
                            average pigment_map{[1, gradient z sine_wave]
                                                [1, gradient y scallop_wave]
                                                [3, bumps  ]}
                                         translate 0.02 scale 0.5}
                                         2 
                         rotate< 0,0,0> scale 0.3 } // end normal
                finish { phong 1 }
              } // end of texture ------------------------------------------

        translate <0,1,0> 
      }
      
          

      object{ Pyramid_N( 8,    1.5,    0.7,   5 )    
             texture{ DMFWood3    
                normal { wood 5 scale 2 rotate<0,0,0> }
                finish { phong 1 } 
                rotate<90,0,90> scale 13  translate<0,2,0>
                    } // end of texture  
            }           
           
  
  cone { <0,4.8,0>,1.1,<0,5.3,0>,0.9 

       texture{ DMFWood3    
                normal { wood 5 scale 2 rotate<0,0,0> }
                finish { phong 1 } 
                rotate<90,0,90> scale 25  translate<0,2,0>
              } // end of texture
     }
  cone { <0,5.3,0>,0.9,<0,5.92,0>,0
       texture{ DMFWood3    
                normal { wood 5 scale 2 rotate<0,0,0> }
                finish { phong 1 } 
                rotate<90,0,90> scale 25  translate<0,2,0>
              } // end of texture
      }
   
    
   object {LM4 rotate<0,0,45> translate<-0.2,5.15,-1.15>}
   object {LM4 rotate<0,0,135> translate<0,5.23,-1.15>}
   object {LM4 rotate<0,0,225> translate<-0.05,5.3,-1.15>}
   object {LM4 rotate<0,0,315> translate<-0.25,5.35,-1.15>}
   cylinder{<-0.12,5.3,-1.155>, <-0.12,5.3,-0.5>,0.12
              
       
   texture{ DMFWood4    
                normal { wood 5 scale 2 rotate<0,0,0> }
                finish { phong 1 } 
                rotate<90,0,90> scale 25  translate<0,2,0>
              } // end of texture
       }
        
}


//водопад

#declare falling_water = 
      media {
      emission 2.5 
      density {
       cylindrical
       turbulence <1,1,1>  
       octaves 10  
       omega .9
       lambda 1.5
        color_map {
          [0.0 color rgb <0,0,0>]
          [0.4 color rgb <0,0,0>]
          [0.5 color rgb <.6,1,1>]
          [0.6 color rgb <0,0,0>]
          [0.9 color rgb <0,0,0>]
          [0.9 color rgb <1,1,1>]
          [1.0 color rgb <1,1,1>]
          } 
          } 
           scale <.2,3,1>  
          }           

//пруд
#declare Prud = merge
{
         cylinder { <0.3,0,-7>, <0.3,0.01,-7>, 1}
         cylinder { <1,0,-5>,<1,0.01,-5>, 1.2}
         cylinder { <-0.5,0,-5.5>,<-0.5,0.01,-5.5>, 1.5}
         cylinder { <1,0,-6>, <1,0.01,-6>, 1}
             texture{ Polished_Chrome
                normal{ bumps 0.25 scale <0.25,0.25,0.25>*0.5 turbulence 0.5 } 
                finish{ reflection 0.60 }}

}          
	                     
//лодка
#declare Post = difference{
cylinder{z*-0.05,z*0.05,2.1}
cylinder{z*-0.2,z*0.2,1.95}
pigment {color Yellow}
scale<2.5,1.25,1>
clipped_by{sphere{0,20 inverse translate<1,19.1,0>}}
}


#declare Prow = union{

#declare Count = 0;
#declare Radius = 1;
#declare Angle = 0;
#declare SphRad = .01;


#while(Count<140)

        
#declare Count = Count +1;
#declare Angle = Angle + 5;
#declare SphRad = SphRad + 0.03;
#declare Radius =  Radius +Radius;

#end        
rotate x*180
}


#declare Prow2 = union{

#declare Count = 0;
#declare Radius = 100;
#declare Angle = 280;
#declare SphRad = 4.2;

#while(Count<40)


        
#declare Count = Count +1;
#declare Angle = Angle + 1;
#declare SphRad = SphRad + 0.03;


#end        
rotate x*180
}


#declare FProw = union{
        object{Prow
                pigment {color White}
                scale 0.025
                rotate z*35 
                
        }

        object{Prow2
                pigment {color White}
                scale 0.025 
                translate<-1.8495,0.15,0>        
        }
        
        
        translate <4.85,1,0>       
}
                

 
#declare Bsphere = difference{
        sphere{0,2}
        sphere{0,1.95}
        }
#declare BtShape = union{
 object{Bsphere
        pigment {color White}
        scale <2.5,1.25,1>
        clipped_by{sphere{0,20 inverse translate<1,18,0>}}
        }
        
   object{Bsphere
        scale <2.5,1.25,1>
        clipped_by{sphere{0,20 inverse translate<1,18.2,0>}}
        clipped_by{sphere{0,20 translate<1,18,0>}}
        pigment {color rgb< 0.75, 0.5, 0.30>*0.25}
        scale 1.01
        }       
       
   object{Bsphere
        scale <2.5,1.25,1>
        clipped_by{sphere{0,20 inverse translate<1,18.4,0>}}
        clipped_by{sphere{0,20 translate<1,18.2,0>}}
        pigment {color rgb< 0.75, 0.5, 0.30>*0.25}
        scale 1.02
        }
        
              
   object{Bsphere
        scale <2.5,1.25,1>
        clipped_by{sphere{0,20 inverse translate<1,18.6,0>}}
        clipped_by{sphere{0,20 translate<1,18.4,0>}}
        pigment {color White}
        scale 1.03
        }       
         
   object{Bsphere
        scale <2.5,1.25,1>
        clipped_by{sphere{0,20 inverse translate<1,18.8,0>}}
        clipped_by{sphere{0,20 translate<1,18.6,0>}} 
        pigment {color White}
        scale 1.04
        }
      
  object{Bsphere
        scale <2.5,1.25,1>
        clipped_by{sphere{0,20 inverse translate<1,19,0>}}
        clipped_by{sphere{0,20 translate<1,18.8,0>}}
        pigment {color White}
        scale 1.05
        }                    
 }          

 
#declare boat = union{        
object{BtShape clipped_by{plane{z,-0.4 }}translate<0,0,.4>}
object{BtShape clipped_by{plane{z,0.4 inverse }}translate<0,0,-.4>}
object{FProw scale 0.75 rotate z*18 translate <1.4,-1.25,0>}
object{Post pigment {color White} }
rotate z*10
}

//√ора дл€ отсрова
#declare Gora =  height_field{ png "Mount2.png" smooth double_illuminate
             
              translate<-0.5,-0.0,-0.5>
              scale<9, 7, 9>*2                                               
                texture{ pigment{ color rgb< 1, 0.80, 0.55>*0.8}
                normal { pigment_pattern{ crackle turbulence 0.2
                                    colour_map {[0.00, rgb 0]
                                                [0.25, rgb 1]
                                                [0.95, rgb 1]
                                                [1.00, rgb 0]}
                                    scale 0.7} 1}

           finish  { phong 1 reflection 0.05 }
         }
           
         clipped_by { cylinder{<0,0,0>, <0,40,0>, 20}}
            }

//остров 
#declare Ostrov = difference{
             object {Gora}
             object{Prud scale <1.5,0,1.5> translate<0.7,0,3.5>}  
            cylinder{
                <0,-10,0>, <0, 0.001, 0>, 20
                 texture{ pigment { color rgb <0.82,0.6,0.4>}
                               normal  { bumps 0.75 scale 0.025  }
                         }
                      }
                      
                     }
                        
            
      

 //оси
/* 
cylinder {
    0, 100*x, 0.03                       
    pigment {  Red }       
}

cylinder {
    0, 100*y, 0.03                       
    pigment {  Green }       
}

cylinder {
    0, 100*z, 0.03                       
    pigment {  Blue }       
}
*/
//камера
camera {
	location <-25,7,4>
	look_at <-1, 3, 10>}
	
//свет
//light_source
//{ <-5,20,-30>
//  color 0.4
//} 
 
//отображение объектов

object{boat
scale 0.4
rotate 120*y
translate<-4,1,10> 
}


object{Ostrov rotate<180,-110,0>
              translate<1,0,11>} 


object{
        #if (leafproba>0)
        #declare Leaf=object{MakeLeaf(lsize,seg,ll,wl,fl,lpow,al,apow,
                 ndents,nlobes,alobes,qlobes,ls,ws,as,dofile,ffname)
                 #if (dotexture=false)  
                        texture{txtLeaf}
                 #end
        } 
        
        #end              
        MakeTree()
        #if (dotexture = true) 
                texture {txtLeaf}
        #else
                texture {txtTree} 
        #end 
        
scale 0.13
rotate y
translate<-6,0,14> 
}
 

object{sphere { <0,0,0> 1 scale <2,6,2> 
         pigment {color rgbt<1, 1, 1, .99>} 
         interior {media {falling_water }}
       hollow} scale <2,0,2> 
       translate<-5,-6,8>
        }
         
object{Meln scale 2.2 translate<4,0,12>}  


#include "rand.inc"
#declare Random_1 = seed (12433);
//---------------------------------------------------------


#declare MyObject =
cone { <-2,-4,10>,20,<-2,20,10>,6
     } 
union{
 #local Nr = 0;     // start
 #local EndNr = 100; // end
 #while (Nr< EndNr)
   object{Ogon
           translate VRand_In_Obj( MyObject, Random_1)*1
         }

 #local Nr = Nr + 1;  // next Nr
 #end // --------------- end of loop

rotate<0, 0,0>
translate<0,0,0>} // end of union
//---------------------------------------------------------
//---------------------------------------------------------
