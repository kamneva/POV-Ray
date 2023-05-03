

#macro MakeBranch(level,pos,vb,dotop) 
#if (level>level0-3) #debug concat("level ",str(level,0,0),"\n") #end
#if (level>0)     

#local nseg=max(1,nseg0-level0+level);  
#local lbseg=lb[level]/nseg; 
#local posb=array[nseg+1] 
#local posb[0]=pos;

#local i=0;

#local ay= 360*(0.5-rand(rd));
#while (i<nseg)
        
        #local rbseg1=rb[level]+(rb[level-1]-rb[level])*i/nseg; 
        #local rbseg2=rb[level]+(rb[level-1]-rb[level])*(i+1)/nseg;
        
        #if (vlength(vpush)=0) #local vp=vpush; #else #local vp=vnormalize(vpush)*i/nseg; #end

        
        #local vg=<0.5-rand(rd),0.5-rand(rd),0.5-rand(rd)>;
        #if (vlength(vg)>0) #local vg=vnormalize(vg); #end

        
         #local posb[i+1]=posb[i]+lbseg*vnormalize(vb+vp*fpush+vg*fgnarl)*(1+(0.5-rand(rd))*stdlseg);
        
        #if (posb[i+1].y<aboveground) 
                #local posb[i+1]=<posb[i+1].x,aboveground+rand(rd)*i/nseg,posb[i+1].z>; 
        #end
        

        #if (posb[i+1].y>belowsky) 
                #local posb[i+1]=<posb[i+1].x,belowsky-rand(rd)*i/nseg,posb[i+1].z>; 
        #end

        
        #if(dofile = true)
                #if (dotexture = true) 

                        #write(filehandle,"union{cone{",posb[i],",",rbseg1,",",posb[i+1],",",rbseg2,"}\n")
                        #write(filehandle,"sphere{",posb[i],",",rbseg1,"}\n")
                        #write(filehandle,"texture{txtTree ")
                        mAlign(posb[i],posb[i+1],true)
                        #write(filehandle,"}}\n")
                #else
                        #write(filehandle,"cone{",posb[i],",",rbseg1,",",posb[i+1],",",rbseg2,"}\n")
                        #write(filehandle,"sphere{",posb[i],",",rbseg1,"}\n")
                
                #end
        #end                                                
                union{
                        cone{posb[i],rbseg1,posb[i+1],rbseg2}
                        sphere{posb[i],rbseg1}
                        #if (dotexture= true)
                                texture{txtTree mAlign(posb[i],posb[i+1],false)}
                        #end
                }   
        
        #if (rand(rdl)<=leafproba & level<=leaflevel)
                #local alz=alz0*(0.5-rand(rdl));
                #local alx=alx0+stdalx*(0.5-rand(rdl));
                #local P1=posb[i];
                #local P2=posb[i+1];
                #local aly=degrees(atan2(P2.x-P1.x,P2.z-P1.z+0.0001))-180;

                #if (dofile = true)
                        #write(filehandle2,"object{Leaf scale ",(1+stdlsize*rand(rdl))," rotate z*",alz," rotate x*",alx," rotate y*",aly, " translate <",P2.x,",",P2.y,",",P2.z,">}\n")
                #end                                                                 
                object{Leaf scale (1+stdlsize*rand(rdl)) rotate z*alz rotate x*alx rotate y*aly translate P2}
        
        #end
        #if (posb[i+1].x>xMax) #declare xMax=posb[i+1].x; #end
        #if (posb[i+1].y>yMax) #declare yMax=posb[i+1].y; #end
        #if (posb[i+1].z>zMax) #declare zMax=posb[i+1].z; #end
        #if (posb[i+1].x<xMin) #declare xMin=posb[i+1].x; #end
        #if (posb[i+1].y<yMin) #declare yMin=posb[i+1].y; #end
        #if (posb[i+1].z<zMin) #declare zMin=posb[i+1].z; #end
        #local i=i+1;

#end            

#local new_level=level-1;                  
#local ax=ab[level]+ stdax*(0.5-rand(rd));
#local ay=stday*(0.5-rand(rd));
#local new_vb=vCone(posb[nseg-1],posb[nseg],ax,ay)
MakeBranch(new_level,posb[nseg],new_vb,false)

#local j=1;      
#while (j<nb)
        #if (rand(rd)<=branchproba)

                #local i=int(jb*nseg)+rand(rd)*(nseg-int(jb*nseg));
                #local ay=j*360/nb + stday*(0.5-rand(rd));
                #local ax=ab[level]+ stdax*(0.5-rand(rd));
                #local new_vb=vCone(posb[i],posb[i+1],ax,ay)
                #local new_pos=posb[i]+(posb[i+1]-posb[i])*rand(rd);
                MakeBranch(new_level,new_pos,new_vb,false)
        #end
        #local j=j+1;
#end


#if (dotop=true & level=level0)
        #local ax=stdax*(0.5-rand(rd));
        #local ay=stday*(0.5-rand(rd));
        #local new_vb=vCone(posb[nseg-1],posb[nseg],ax,ay)
        MakeBranch(new_level,posb[nseg],new_vb,true)
#end

#if (twigproba>0 & level=level0)
        #local i=0;
        #while (i<nseg)
                #if (rand(rd)<=twigproba)
                        #local ay=360*(0.5-rand(rd));
                        #local ax=ab[level]+ stdax*(0.5-rand(rd));
                        #local new_vb=vCone(posb[i],posb[i+1],ax,ay)   
                        #local new_pos=posb[i]+(posb[i+1]-posb[i])*rand(rd);
                        MakeBranch(1,new_pos,new_vb,false)
                                
                #end
                #local i=i+1;
        #end

#end

#if (rootproba>0 & level=level0)                         
        #local new_vb=vroot;
        #local new_pos=yroot;
        #local i=0;
        #while (i<nroot)
                #if (rand(rd)<=rootproba)
                        #local ay=((i*360/nroot)+stday*(0.5-rand(rd)));
                        #if (dofile=true)
                                #write(filehandle,"union{\n")
                        #end
                        union{MakeRoot(new_level,new_pos,new_vb) rotate ay*y}
                        #if (dofile=true)
                                #write(filehandle,"rotate y*",ay,"}\n")
                        #end
                #end
                #local i=i+1;
        #end
#end                        


#end
#end

#macro MakeRoot(level,pos,vb) 

#if (level>level0-2)
#debug concat("root level ",str(level,0,0),"\n")
#local nseg=max(1,nseg0-level0+level);  
#local lbseg=lb[level]/nseg; 
#local posb=array[nseg+1]
#local posb[0]=pos; 

#local i=0;

#local ay= 360*(0.5-rand(rd));                                               
#while (i<nseg)

        #local rbseg1=rb[level]*(1-i/nseg); 
        #local rbseg2=rb[level]*(1-(i+1)/nseg);
      
        #local vp=-y*i/nseg; #if (vlength(vp)>0) #local vp=vnormalize(vp); #end

       
        #local vg=<(0.5-rand(rd))*2,0.5-rand(rd),2*(0.5-rand(rd))>;
        #if (vlength(vg)>0) #local vg=vnormalize(vg); #end

  
        #local posb[i+1]=posb[i]+lbseg*vnormalize(vb+vp*0.2+vg*fgnarl)*(1+(0.5-rand(rd))*stdlseg);
        #if (posb[i+1].y>0 & (i/nseg)>=0.3) #local posb[i+1]=<posb[i+1].x,0,posb[i+1].z>; #end

        #if (dofile = true)
                #if (dotexture = true) 
                        #write(filehandle,"union{cone{",posb[i],",",rbseg1,",",posb[i+1],",",rbseg2,"}\n")
                        #write(filehandle,"sphere{",posb[i],",",rbseg1,"}\n")
                        #write(filehandle,"texture{txtTree ")
                        mAlign(posb[i],posb[i+1],true)
                        #write(filehandle,"}}\n")
                #else                   
                        #write(filehandle,"cone{",posb[i],",",rbseg1,",",posb[i+1],",",rbseg2,"}\n")
                        #write(filehandle,"sphere{",posb[i],",",rbseg1,"}\n")
              
                #end
        #end
        union{
                cone{posb[i],rbseg1,posb[i+1],rbseg2}
                sphere{posb[i],rbseg1}
                #if (dotexture = true)
                        texture{txtTree mAlign(posb[i],posb[i+1],false)}
                #end
                }
        #if (posb[i+1].x>xMax) #declare xMax=posb[i+1].x; #end
        #if (posb[i+1].y>yMax) #declare yMax=posb[i+1].y; #end
        #if (posb[i+1].z>zMax) #declare zMax=posb[i+1].z; #end
        #if (posb[i+1].x<xMin) #declare xMin=posb[i+1].x; #end
        #if (posb[i+1].y<yMin) #declare yMin=posb[i+1].y; #end
        #if (posb[i+1].z<zMin) #declare zMin=posb[i+1].z; #end


        #local i=i+1;

#end    



#local j=0;      
#local new_level=level-1;
#while (j<nb)
        #if (rand(rd)<=branchproba)
                #local i=int(jb*nseg)+j*(nseg-int(jb*nseg))/nb;
                #local ay=360*(0.5-rand(rd));
                #local ax=ab[level]+ stdax*(0.5-rand(rd));
                #local new_vb=vCone(posb[i],posb[i+1],ax,ay)
                #if (new_vb.y>0) #local new_vb=<new_vb.x,-rand(rd)*new_vb.y,new_vb.z>;#end
                #local new_pos=posb[i]+(posb[i+1]-posb[i])*rand(rd);
                MakeRoot(new_level,new_pos,new_vb)
        #end
        #local j=j+1;

#end

#end        
#end

#macro MakeTree()

#declare xMax=pos0.x;
#declare yMax=pos0.y;
#declare zMax=pos0.z;
#declare xMin=pos0.x;
#declare yMin=pos0.y;
#declare zMin=pos0.z;


FillTreeArrays(level0,lb0,qlb,rb0,qrb,ab0,qab)
       #if(dofile=true)
            #debug concat(ftname," tree file creation start\n")
            #fopen filehandle ftname write     
            #write(filehandle,"union{\n")
            #if (leafproba>0)
                #debug concat(fvname," foliage file creation starts\n")
                #fopen filehandle2 fvname write    
                #write(filehandle2,"union{\n")
            #end
       #end


       union{MakeBranch(level0,pos0,v0,dotop)}
       
       #if(dofile = true)
            #if (leafproba>0)
                #write (filehandle2,"}\n")          
                #fclose filehandle2
                #debug concat(fvname," foliage file created\n")
            #end
            #write (filehandle,"}\n")           
            #write (filehandle,"// Tree in box{<",xMin,",",yMin,",",zMin,">,<",xMax,",",yMax,",",zMax,"> pigment{Green}}\n")
            #fclose filehandle
            #debug concat(ftname," tree file created\n")
       #end
       #debug concat("Tree goes from <",str(xMin,0,3),",",str(yMin,0,3),",",str(zMin,0,3),"> to <",str(xMax,0,3),",",str(yMax,0,3),",",str(zMax,0,3),">\n")

#end

#macro FillTreeArrays(level,lb0,qlb,rb0,qrb,ab0,qab)
#declare lb=array[level+1]
#declare rb=array[level+1]
#declare ab=array[level+1]
#local i=level;
#declare lb[i]=lb0;
#declare rb[i]=rb0;
#declare ab[i]=ab0;
#debug concat("level=",str(i,0,0)," lb=",str(lb[i],0,3)," rb=",str(rb[i],0,3),"\n")
#local i=level-1;  
#while (i>=0)
        #declare lb[i]=lb[i+1]*qlb;
        #declare rb[i]=rb[i+1]*qrb;
        #declare ab[i]=ab[i+1]*qab;
#debug concat("level=",str(i,0,0)," lb=",str(lb[i],0,3)," rb=",str(rb[i],0,3),"\n")
        
#local i=i-1;
#end
#end                        


#macro MakeLeaf(lsize,seg,ll,wl,fl,lpow,al,apow,ndents,nlobes,alobes,qlobes,ls,ws,as,dofile,ffname)
#debug "create leaf\n"
#if(dofile=true)          
        #debug concat(ffname," individual leaf file creation starts\n")

        #fopen filehandle ffname write  
        #write(filehandle,"mesh{\n")
#end
mesh{

#local lseg=ll/seg;  
#local nI=3; #local nJ=seg+1;
#local nP=nI*nJ; #local P=array[nP] 
#local pl=<0,0,0>;   
#local j=0; 
#while (j<nJ)          
        #local tl=j/seg;
        #if (j>0) #local pl=pl+lseg*vaxis_rotate(z,x,pow(tl,apow)*al);#end
        
                #local P[j*nI]=pl-x*wl*(pow(sin(tl*pi),lpow)*(2+(pow(sin(tl*pi*ndents),2))))/3;
                #local P[j*nI+1]=pl-y*fl*sin(tl*pi);
                #local P[j*nI+2]=pl+x*wl*(pow(sin(tl*pi),lpow)*(2+(pow(sin(tl*pi*ndents),2))))/3;
        #local j=j+1;        
#end   


#local q=0;
#while (q<(nI*(nJ-1)-1))
#local i=mod(q,nI);#local j=(q-i)/nI;
#if (i <nI-1)        
        #if (nlobes>1)
        
                #local j=0;
                #local a=-alobes/2;
                #while (j<nlobes)    
                        #local sc=qlobes+(1-qlobes)*sin(j*pi/(nlobes-1));
                        triangle{vaxis_rotate(P[q]*sc,z,a),vaxis_rotate(P[q+1]*sc,z,a),vaxis_rotate(P[q+nI+1]*sc,z,a)}
                        triangle{vaxis_rotate(P[q]*sc,z,a),vaxis_rotate(P[q+nI]*sc,z,a),vaxis_rotate(P[q+nI+1]*sc,z,a)}
                        #if (dofile=true)
                                #local tt1=vaxis_rotate(P[q]*sc,z,a);
                                #local tt2=vaxis_rotate(P[q+1]*sc,z,a);
                                #local tt3=vaxis_rotate(P[q+nI+1]*sc,z,a);
                                #local tt4=vaxis_rotate(P[q+nI]*sc,z,a);
                                #write(filehandle,"triangle{<",tt1.x,",",tt1.y,",",tt1.z,">,<",tt2.x,",",tt2.y,",",tt2.z,">,<",tt3.x,",",tt3.y,",",tt3.z,">}\n")
                                #write(filehandle,"triangle{<",tt1.x,",",tt1.y,",",tt1.z,">,<",tt4.x,",",tt4.y,",",tt4.z,">,<",tt3.x,",",tt3.y,",",tt3.z,">}\n")
                        #end
                        #local j=j+1;
                        #local a=a+alobes/(nlobes-1);
                #end
         #else

                triangle{P[q],P[q+1],P[q+nI+1]} triangle{P[q],P[q+nI],P[q+nI+1]}
                #if (dofile=true)
                        #write(filehandle,"triangle{<",P[q].x,",",P[q].y,",",P[q].z,">,<",P[q+1].x,",",P[q+1].y,",",P[q+1].z,">,<",P[q+nI+1].x,",",P[q+nI+1].y,",",P[q+nI+1].z,">}\n")
                        #write(filehandle,"triangle{<",P[q].x,",",P[q].y,",",P[q].z,">,<",P[q+nI].x,",",P[q+nI].y,",",P[q+nI].z,">,<",P[q+nI+1].x,",",P[q+nI+1].y,",",P[q+nI+1].z,">}\n")
                #end

         #end
         
#end
#local q=q+1;
#end        


#if (ls>0)

#local lseg=ls/seg;

        #local nI=2; #local nJ=seg+1;
        #local nP=nI*nJ; #local P=array[nP]
        #local pl=<0,0,0>; 
        #local j=0; 
        #while (j<nJ)          
                #local tl=j/seg;
                #if (j>0) #local pl=pl+lseg*vaxis_rotate(-z,x,-pow(tl,apow)*as);#end
                #local P[j*nI]=pl-x*ws;
                #local P[j*nI+1]=pl+x*ws;
                #local j=j+1;        
        #end   


#local q=0;
#while (q<(nI*(nJ-1)-1))
#local i=mod(q,nI);#local j=(q-i)/nI;
        #if (i <nI-1) 
                triangle{P[q],P[q+1],P[q+nI+1]} triangle{P[q],P[q+nI],P[q+nI+1]} 
                #if (dofile=true)
                        #write(filehandle,"triangle{<",P[q].x,",",P[q].y,",",P[q].z,">,<",P[q+1].x,",",P[q+1].y,",",P[q+1].z,">,<",P[q+nI+1].x,",",P[q+nI+1].y,",",P[q+nI+1].z,">}\n")
                        #write(filehandle,"triangle{<",P[q].x,",",P[q].y,",",P[q].z,">,<",P[q+nI].x,",",P[q+nI].y,",",P[q+nI].z,">,<",P[q+nI+1].x,",",P[q+nI+1].y,",",P[q+nI+1].z,">}\n")
                #end
                
        #end
#local q=q+1;
#end        
translate <0,-P[nP-1].y,-P[nP-1].z> 
#if (dofile=true)
        #write (filehandle,"translate <0,",-P[nP-1].y,",",-P[nP-1].z,">\n")
#end
#end

scale lsize  
rotate y*180 

#if(dofile = true)
        #write (filehandle,"scale ",lsize," rotate y*180}\n")
        #fclose filehandle
        #debug concat(ffname," individual leaf file created\n")

#end
}
#debug "end of leaf creation\n"
#end

#macro vCone(P1,P2,ax,ay)
#local p = vaxis_rotate(vaxis_rotate(y,x,ax),y,ay);
#local yV1=vnormalize(P2-P1);
#local xV1=vnormalize(vcross(yV1,z));
#local zV1=vcross(xV1,yV1);
#local answer=vnormalize(<p.x*xV1.x + p.y*yV1.x + p.z*zV1.x,p.x*xV1.y + p.y*yV1.y + p.z*zV1.y,p.x*xV1.z + p.y*yV1.z + p.z*zV1.z>);
answer;
#end   


#macro mAlign(P1,P2,dofile)
#local yV1=vnormalize(P2-P1);
#local xV1=vnormalize(vcross(yV1,z));
#local zV1=vcross(xV1,yV1);
        #if(dofile = true)
                #write(filehandle,"matrix <",xV1.x,",",xV1.y,",",xV1.z,",",yV1.x,",",yV1.y,",",yV1.z,",",zV1.x,",",zV1.y,",",zV1.z,",",P1.x,",",P1.y,",",P1.z,"> ")
        #else
                matrix <xV1.x,xV1.y,xV1.z,yV1.x,yV1.y,yV1.z,zV1.x,zV1.y,zV1.z,P1.x,P1.y,P1.z>

        #end
#end   

