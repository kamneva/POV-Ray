
#version 3.7;
global_settings{ assumed_gamma 1.0 }
#default{ finish{ ambient 0.1 diffuse 0.9 }} 
//--------------------------------------------------------------------------
#include "colors.inc"
#include "textures.inc"
#include "glass.inc"
#include "metals.inc"
#include "golds.inc"
#include "stones.inc"
#include "woods.inc"
#include "shapes.inc"
#include "shapes2.inc"
#include "functions.inc"
#include "math.inc"
#include "transforms.inc"
//--------------------------------------------------------------------------
// camera ------------------------------------------------------------------
#declare Camera_0 = camera {/*ultra_wide_angle*/ angle 75      // front view
                            location  <0.0 , 1.0 ,-3.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
#declare Camera_1 = camera {/*ultra_wide_angle*/ angle 90   // diagonal view
                            location  <5.0 , 1 ,3>
                            right     x*image_width/image_height
                            look_at   <-1 , 1 , 14.0>}

// sun ---------------------------------------------------------------------
light_source{<1500,2500,-2500> color White}
// sky ---------------------------------------------------------------------
plane{<0,1,0>,1 hollow  
       texture{ pigment{ bozo turbulence 0.92
                         color_map { [0.00 rgb <0.20, 0.20, 1.0>*0.9]
                                     [0.50 rgb <0.20, 0.20, 1.0>*0.9]
                                     [0.70 rgb <1,1,1>]
                                     [0.85 rgb <0.25,0.25,0.25>]
                                     [1.0 rgb <0.5,0.5,0.5>]}
                        scale<1,1,1.5>*2.5  translate< 0,0,0>
                       }
                finish {ambient 1 diffuse 0} }      
       scale 10000}
// fog on the ground -------------------------------------------------
fog { fog_type   2
      distance   40
      color      White 
      fog_offset 0.1
      fog_alt    3
      turbulence 1.8
    }
// sea ---------------------------------------------------------------------
#declare sea = isosurface{ // ------------------------------------------------------------

      function {  y
               }

  threshold 0
  accuracy 0.0001
  max_gradient 5
  contained_by { box{<-100,-100,-100>, <1000,0,1000>}}
   
       texture{Polished_Chrome
               normal { crackle 0.8 scale <2,2,2> turbulence 0.9 } 
               finish { reflection 0.9}
               }
          }
 //камни
 #declare cam1 = isosurface { //--------------------------------------

  function{
   f_rounded_box( x, y, z,
                  0.3, //  radius of curvature
                  1.4,0.9,0.9) // scale<x,y,z>
     -(f_agate(x/2,y/4,z/4)*0.35)
                               
   }

  threshold 0
  contained_by {box {<-3,-3,-3>*1.2,<2,3,3>*1.5}}
  max_gradient 3.2
  accuracy 0.0001

  texture { pigment{ color rgb <0.82,0.6,0.4>}
            normal { bumps 0.5 scale 0.05}
            finish { phong 0.3}
	  }
  scale 0.800
  rotate <0,0,0>
  rotate <-20,0,0>  
  translate < 0, 1.2, 0>
} // end of isosurface ------------------------------

 
#declare cam2 = isosurface { 

  function{ f_rounded_box( x, y, z,
                           0.3, // radius of curvature
                           0.7,0.7,0.7)// scale<x,y,z>
            -(f_agate( x, y, z)*0.4)
            
          }
  threshold 0
  contained_by { box {<-3,-0.5,-3>*1.1,<3,3,3>*1.2}   }
  max_gradient 6

  texture {
            pigment{ color rgb <0.82,0.6,0.4>}     
            finish { phong 0.3}
	  }
  scale 0.900
  rotate <0,-40,0>
  rotate <-30,0,0>  
  translate < 0, 1.3, 0>
} 

#declare cam3 = union 
{
  object{cam1}
  object {cam2 translate<0,1,0>}


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
                pigment { color rgb< 1, 1, 1>*0.5}
                scale 0.025
                rotate z*35 
                
        }

        object{Prow2
                pigment { color rgb< 1, 1, 1>*0.5}
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
        pigment {color rgb< 1, 1, 1>*0.5}
        scale <2.5,1.25,1>
        clipped_by{sphere{0,20 inverse translate<1,18,0>}}
        }
  //      
   object{Bsphere
        scale <2.5,1.25,1>
        clipped_by{sphere{0,20 inverse translate<1,18.2,0>}}
        clipped_by{sphere{0,20 translate<1,18,0>}}
        pigment {color rgb< 0.75, 0.5, 0.30>*0.5 }
        scale 1.01
        }       
       
   object{Bsphere
        scale <2.5,1.25,1>
        clipped_by{sphere{0,20 inverse translate<1,18.4,0>}}
        clipped_by{sphere{0,20 translate<1,18.2,0>}}
        pigment {color rgb< 0.75, 0.5, 0.30>*0.5 }
        scale 1.02
        }
        
   //           
   object{Bsphere
        scale <2.5,1.25,1>
        clipped_by{sphere{0,20 inverse translate<1,18.6,0>}}
        clipped_by{sphere{0,20 translate<1,18.4,0>}}
        pigment {color rgb< 1, 1, 1>*0.5}
        scale 1.03
        }       
         
   object{Bsphere
        scale <2.5,1.25,1>
        clipped_by{sphere{0,20 inverse translate<1,18.8,0>}}
        clipped_by{sphere{0,20 translate<1,18.6,0>}} 
        pigment {color rgb< 1, 1, 1>*0.5}
        scale 1.04
        }
      
  object{Bsphere
        scale <2.5,1.25,1>
        clipped_by{sphere{0,20 inverse translate<1,19,0>}}
        clipped_by{sphere{0,20 translate<1,18.8,0>}}
        pigment {color rgb< 1, 1, 1>*0.5}
        scale 1.05
        }                    
 }          

 
#declare boat = union{        
object{BtShape clipped_by{plane{z,-0.4 }}translate<0,0,.4>}
object{BtShape clipped_by{plane{z,0.4 inverse }}translate<0,0,-.4>}
object{FProw scale 0.75 rotate z*18 translate <1.4,-1.25,0>}
object{Post pigment {color rgb< 1, 1, 1>*0.5} }
rotate z*10
}


//---------------------------------------------------------------------
#declare Ostrov = height_field{ png "Mount2.png" smooth double_illuminate

              translate<-0.5,-0.0,-0.5>
              scale<9, 1.5, 9>*2 
              texture{ pigment { color rgb <0.82,0.6,0.4>}
                       normal  { bumps 0.75 scale 0.025  }
                     } 
              scale<1,0.5,2>
              rotate<0,-29,0>
              translate<1,-0.1,19>
            }
            
//кустик
#include "maketree.pov"
#declare PdV=<0, 4 , -110>;
#declare PdA=<0,25,0>;
camera {location  PdV  direction <0.0 , 0.0 , 1.7 >  up y right 4*x/3  look_at PdA}

#declare dofile=true;    
#declare dotexture=true;  
#declare ftname="gttree4.inc"
#declare fvname="gtfoliage4.inc"
#declare ffname="gtleaf4.inc"
#declare colBark=rgb <1,0.8,0.64>;                 
#declare txtTree=texture{pigment{gradient y turbulence 0.7 lambda 4 color_map{[0 color colBark*.3] [0.1 color colBark][0.9 color colBark][1 color colBark*.4]}} finish{ambient 0.1}}
texture{pigment{bozo turbulence 0.7 lambda 4 color_map{[0 color colBark*.2][0.1 color colBark*.3] [0.3 color colBark*.4][0.4 color Clear][0.9 color Clear][1 color colBark*.4] }}finish{ambient 0.1}} 


#declare rsd=211;         
#declare rd=seed(rsd);  
#declare rdl=seed(rsd);

#declare level0=4;      
#declare nseg0=12;      
#declare nb=4;          
#declare dotop=false;   

#declare lb0=3;       
#declare rb0=1;         
#declare ab0=95;        
#declare qlb=1.6;       
#declare qrb=0.6;       
#declare qab=0.6;       
#declare stdax=10;     
#declare stday=10;  

#declare branchproba=0.8; 
#declare jb=0.1;        
#declare fgnarl=0.4;   
#declare stdlseg=0.1;     
#declare twigproba=0; 
#declare v0=<0,1,0>;   
#declare pos0=<0,0,0>;  

#declare vpush=<0,1,0>;
#declare fpush=1;       
#declare aboveground=0.5; 
#declare belowsky=1000;   


#declare rootproba=1;   
#declare nroot=5;      
#declare vroot=<1,-0.1,0>; 
#declare yroot=<0,0.5,0>;   


#declare leafproba=1;   
#declare leaflevel=4; 
#declare alz0=180;       
#declare alx0=90;      
#declare stdalx=60;     
#declare stdlsize=1;  

#declare colLeaf=rgb <0.65,1,0.3>*0.3; 
#declare txtLeaf=texture{pigment{colLeaf} finish{ambient 0.1 specular 0.3 roughness 0.01}} 
#declare lsize=0.4;     
#declare seg=10;       
#declare ll=3;         
#declare wl=0.6;           
#declare fl=0.1;        
#declare lpow=0.3;        
#declare al=100;       
#declare apow=1;        
#declare ndents=0;      
#declare nlobes=5;     
#declare alobes=288;   
#declare qlobes=1;                              
#declare ls=0;          
#declare ws=0.1;      
#declare as=10;         

 #declare Tree = union{
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
        scale 0.07
}

//жучок

#declare Mitecolor1 = color rgb< 1.0, 0.15, 0.0> ;
#declare Mitecolor2 = color rgb< 1, 1, 1>*0.00; 

#declare Member = blob {
  threshold 0.56
  cylinder {0,0.094*x,0.02,1}
  sphere {0,0.016,1}
  sphere {0.093*x,0.02,1}
  sphere {0,1,-2
    scale 0.016
    translate<0.094,-0.001,0>
    }
  
  texture {
    pigment { Mitecolor2 }
    finish { phong 0.4 phong_size 10 } 
    normal { bumps 0.4 scale 0.01 turbulence 0.5}
    }
  }   

#declare Foot = blob {
  threshold 0.56
  sphere {0,0.018,1}
  cylinder {<0.005,0,0>,<0.03,0.01,0>,0.018,1}
  cylinder {<0.04,0.01,0>,<0.062,0.01,0>,0.015,1}
  cylinder {<0.072,0.01,0>,<0.089,0.008,0>,0.012,1}
  cylinder {<0.092,0.007,0>,<0.115,0,0>,0.01,1}
  texture {
    pigment { Mitecolor2 }
    finish { phong 0.4 phong_size 10 } 
    normal { bumps 0.4 scale 0.01 turbulence 0.5}
    }
  }  

#macro Leg (AAy, AA1, KK) 
#declare K = KK;
#while (K>1)   
  #declare K = K-1;
  #end
  
#declare H = 0.103;  
#declare R = 0.094;  
#declare A = 0.094; 
#declare B = 0.203;  
#declare L = 0.125;  

#declare Ay = radians(AAy);  
#declare A1 = radians(AA1);
#declare D0 = R + A*cos(A1) + sqrt(B*B - pow((H+A*sin(A1)),2));
#declare D = D0*sin(Ay);  
#declare L0 = D0*cos(Ay);      
#declare A4 = 0;

#declare K = K*1.5;  
#if (K>1)
  #declare K = (1.5-K)*2; 
  #declare A4 = sin(K*pi)*0.1;
  #end 

#declare Ln = L0 - K*L;     
#declare Ayn = atan2(D,Ln);
#declare Dn = abs(D/sin(Ayn));
#declare En = Dn - R;
#declare Cn = sqrt(H*H + En*En);
#declare A3n = acos((B*B + Cn*Cn - A*A)/(2*B*Cn)) + acos(En/Cn);
#declare An = En - B*cos(A3n);
#declare A1n = acos(An/A);
#declare A2n = A3n + A1n - A4;

#declare Ayn = degrees(Ayn);
#declare A1n = degrees(A1n);
#declare A2n = degrees(A2n);

union { 
  union { 
    union { 
      object { Member
        translate x*0.003
        rotate z*20
        }
      object { Foot
        rotate z*(degrees(A4)-36.5)
        translate 0.097*x
        rotate z*20 
        }
      rotate -z*A2n
      translate x*A
      } 
    object { Member }
    rotate z*A1n
    translate x*R
    } 
  object { Member
    rotate x*180
    }
  rotate y*Ayn
  translate y*(H+0.002)
  }  
#end  
      

#macro Mite (pose)   
union { 
  blob {
    threshold 0.56
    sphere { 0,1,1  
      scale <0.75,0.188,0.5>
      translate <-0.125,0.15,0>
      }
    sphere { 0,1,1  
      scale <0.375,0.188,0.25>
      translate <-0.094,0.244,0>
      }
    sphere { 0,1,1  
      scale <0.188,0.125,0.125>
      translate <-0.219,0.088,0>
      }
    sphere { 0,1,-0.25   
      scale <0.25,0.08,0.09>
      rotate y*-20
      translate <0.094,0.088,-0.188>
      }  
    sphere { 0,1,-0.25  
      scale <0.25,0.08,0.09>
      rotate y*20
      translate <0.094,0.088,0.188>
      }     
    sphere { 0,1,1   
      scale <0.125,0.125,0.07>
      translate <0.156,0.15,0.04>
      }
    sphere { 0,1,1  
      scale <0.125,0.125,0.07>
      translate <0.156,0.15,-0.04>
      }
    sphere { 0,1,1
      scale <0.094,0.094,0.094>
      translate <0.203,0.15,0>
      } 
    sphere { 0,1,-2 
      scale <0.25,0.065,0.075>
      translate <0.21,0.15,0>
      }
    sphere { 0,1,2 
      scale <0.06,0.06,0.035>
      rotate <20,-10,0>
      translate <0.265,0.15,-0.028>
      } 
    sphere { 0,1,2 
      scale <0.06,0.06,0.035>
      rotate <-20,10,0>
      translate <0.265,0.15,0.028>
      }
    sphere { 0,1,1 
      scale <0.06,0.02,0.03>
      rotate <20,-5,-10>
      translate <0.23,0.09,-0.024>
      } 
    sphere { 0,1,1 
      scale <0.06,0.02,0.03>
      rotate <-20,5,-10>
      translate <0.23,0.09,0.024>
      }  
    sphere { 0,1,-1 
      scale <0.04,0.03,0.04>
      translate <0.25,0.119,-0.03>
      } 
    sphere { 0,1,-1 
      scale <0.04,0.03,0.04>
      translate <0.25,0.119,0.03>
      }
    
    texture { 
      pigment { crackle 
        color_map {
          [0 Mitecolor2*0.8]
          [0.5 Mitecolor1]
          }           
        scale 1
        turbulence 0.4
        omega 0.1 
        }
      finish { phong 0.4 phong_size 10 } 
      normal { bumps 0.4 
        scale 0.02 
        turbulence 0.5
        }
      }   
    }      
  
  object { Leg(10,30,pose)
    translate <0.156,0,-0.125>
    }
  object { Leg(-10,30,pose+0.5)// L1
    translate <0.156,0,0.125>
    }
  object { Leg(40,40,pose+0.625)// R2
    translate <0.11,0,-0.14>
    }
  object { Leg(-40,40,pose+0.125)// L2
    translate <0.11,0,0.14>
    }  
  object { Leg(70,50,pose+0.25)// R3
    translate <0.062,0,-0.145>
    }
  object { Leg(-70,50,pose+0.75)// L3
    translate <0.062,0,0.145>
    }
  object { Leg(110,40,pose+0.875)// R4
    translate <0.016,0,-0.15>
    }
  object { Leg(-110,40,pose+0.375)// L4
    translate <0.015,0,0.15>
    }
    
  } 
#end 

//---------------------------------------------------------------------
 
  object{boat
scale 0.4
rotate -40*y
translate<-3,1,6> 
}
  
 object{Ostrov}   
 object{Ostrov translate<-10,0,0>}
 object {cam3 translate<1,-0.1,35> scale 0.5}
 object {cam3 translate<10,-0.7,20> scale 0.5}
 object {cam3 translate<-11,-0.7,26> scale 0.5}
 object {cam3 translate<-20,-0.7,35> scale 0.7}
 object {cam3 translate<13,-0.7,30> scale 0.7}
 object{cam2 translate<7,-1.8,11> scale 0.4}
 object{sea}
 camera{Camera_1}
 
 object {Tree translate<3,0,12>}
 object {Tree translate<-4,0,11>}
 object {Tree scale 0.5 translate<1.3,0.1,9>}
   
object { Mite(clock) rotate 90*y scale 0.6 translate<5,0,7> }
object { Mite(clock) rotate <-20,20,0> scale 1 translate<-1,0.35,8> }
object { Mite(clock) rotate <-20,90,-20> scale 2 translate<1,0.8,12> }     