clc
clear all
close all




DC11=zeros(40,360);
DC12=zeros(40,360);
DC13=zeros(40,360);
DC22=zeros(40,360);
DC23=zeros(40,360);
DC33=zeros(40,360);
DC44=zeros(40,360);
DC45=zeros(40,360);
DC55=zeros(40,360);
DC66=zeros(40,360);
DC16=zeros(40,360);
DC26=zeros(40,360);
DC36=zeros(40,360);
rV2=zeros(40,360);


C11=24.54;
C12=3.89;
C13=2.38;
C22=28.79;
C23=2.37;
C33=29.87;
C44=11.24;
C45=1;          %       CHANGE?????????
C55=10.73;
C66=10.98;
C16=-3.18;
C26=1.13;
C36=.2;














for t=1:40
    for p=1:360
    
    tet=t*pi/180;
    phi=p*pi/180;

    n1 =  sin(tet)*cos(phi);
    n2 = sin(tet)*sin(phi);
    n3 = cos(tet);
    
    
    rV2(t,p)=(1/3)*(2*sqrt(3)*sqrt((1/3)*(C11*n1^2 + 2*C16*n1*n2 + C22*n2^2 + 2*C26*n1*n2 + n3^2*(C33 + C44 + C55) + C44*n2^2 + 2*C45*n1*n2 + C55*n1^2 + C66*n1^2 + C66*n2^2)^2 - ...
      (C11*n1^2 + 2*C16*n1*n2 + C55*n3^2 + C66*n2^2)*(C22*n2^2 + 2*C26*n1*n2 + C44*n3^2 + C66*n1^2) - (C11*n1^2 + 2*C16*n1*n2 + C55*n3^2 + C66*n2^2)*(C33*n3^2 + C44*n2^2 + 2*C45*n1*n2 + C55*n1^2) + ...
      (n2*(n1*(C12 + C66) + C26*n2) + C16*n1^2 + C45*n3^2)^2 + (n1*n3*(C13 + C55) + n2*n3*(C36 + C45))^2 - (C22*n2^2 + 2*C26*n1*n2 + C44*n3^2 + C66*n1^2)*...
       (C33*n3^2 + C44*n2^2 + 2*C45*n1*n2 + C55*n1^2) + (n2*n3*(C23 + C44) + n1*n3*(C36 + C45))^2) + C11*n1^2 + 2*C16*n1*n2 + C22*n2^2 + 2*C26*n1*n2 + C33*n3^2 + C44*n2^2 + C44*n3^2 + 2*C45*n1*n2 + ...
   C55*n1^2 + C55*n3^2 + C66*n1^2 + C66*n2^2);
   
   
   

    DC11(t,p)=(1/3)*(n1^2 + (sqrt(3)*((-n1^2)*(C55*n1^2 + 2*C45*n1*n2 + C44*n2^2 + C33*n3^2) - n1^2*(C66*n1^2 + 2*C26*n1*n2 + C22*n2^2 + C44*n3^2) + ...
      (2/3)*n1^2*(C11*n1^2 + C55*n1^2 + C66*n1^2 + 2*C16*n1*n2 + 2*C26*n1*n2 + 2*C45*n1*n2 + C22*n2^2 + C44*n2^2 + C66*n2^2 +...
        (C33 + C44 + C55)*n3^2)))/sqrt(((C36 + C45)*n1*n3 + (C23 + C44)*n2*n3)^2 + ((C13 + C55)*n1*n3 + (C36 + C45)*n2*n3)^2 - ...
      (C55*n1^2 + 2*C45*n1*n2 + C44*n2^2 + C33*n3^2)*(C66*n1^2 + 2*C26*n1*n2 + C22*n2^2 + C44*n3^2) + ...
      (C16*n1^2 + n2*((C12 + C66)*n1 + C26*n2) + C45*n3^2)^2 - (C55*n1^2 + 2*C45*n1*n2 + C44*n2^2 + C33*n3^2)*...
       (C11*n1^2 + 2*C16*n1*n2 + C66*n2^2 + C55*n3^2) - (C66*n1^2 + 2*C26*n1*n2 + C22*n2^2 + C44*n3^2)*...
       (C11*n1^2 + 2*C16*n1*n2 + C66*n2^2 + C55*n3^2) + (1/3)*(C11*n1^2 + C55*n1^2 + C66*n1^2 + 2*C16*n1*n2 + 2*C26*n1*n2 + 2*C45*n1*n2 + ...
         C22*n2^2 + C44*n2^2 + C66*n2^2 + (C33 + C44 + C55)*n3^2)^2));
         
          
          
          
          DC12(t,p)=(2*n1*n2*(C16*n1^2 + n2*((C12 + C66)*n1 + C26*n2) + C45*n3^2))/...
  (sqrt(3)*sqrt(((C36 + C45)*n1*n3 + (C23 + C44)*n2*n3)^2 + ((C13 + C55)*n1*n3 + (C36 + C45)*n2*n3)^2 - ...
     (C55*n1^2 + 2*C45*n1*n2 + C44*n2^2 + C33*n3^2)*(C66*n1^2 + 2*C26*n1*n2 + C22*n2^2 + C44*n3^2) + ...
     (C16*n1^2 + n2*((C12 + C66)*n1 + C26*n2) + C45*n3^2)^2 - (C55*n1^2 + 2*C45*n1*n2 + C44*n2^2 + C33*n3^2)*...
      (C11*n1^2 + 2*C16*n1*n2 + C66*n2^2 + C55*n3^2) - (C66*n1^2 + 2*C26*n1*n2 + C22*n2^2 + C44*n3^2)*...
      (C11*n1^2 + 2*C16*n1*n2 + C66*n2^2 + C55*n3^2) + (1/3)*(C11*n1^2 + C55*n1^2 + C66*n1^2 + 2*C16*n1*n2 + 2*C26*n1*n2 + 2*C45*n1*n2 + ...
        C22*n2^2 + C44*n2^2 + C66*n2^2 + (C33 + C44 + C55)*n3^2)^2));
        
        
        
         
         
         
         
         
         DC13(t,p)=(2*n1*n3*((C13 + C55)*n1*n3 + (C36 + C45)*n2*n3))/...
  (sqrt(3)*sqrt(((C36 + C45)*n1*n3 + (C23 + C44)*n2*n3)^2 + ((C13 + C55)*n1*n3 + (C36 + C45)*n2*n3)^2 - ...
     (C55*n1^2 + 2*C45*n1*n2 + C44*n2^2 + C33*n3^2)*(C66*n1^2 + 2*C26*n1*n2 + C22*n2^2 + C44*n3^2) + ...
     (C16*n1^2 + n2*((C12 + C66)*n1 + C26*n2) + C45*n3^2)^2 - (C55*n1^2 + 2*C45*n1*n2 + C44*n2^2 + C33*n3^2)*...
      (C11*n1^2 + 2*C16*n1*n2 + C66*n2^2 + C55*n3^2) - (C66*n1^2 + 2*C26*n1*n2 + C22*n2^2 + C44*n3^2)*...
      (C11*n1^2 + 2*C16*n1*n2 + C66*n2^2 + C55*n3^2) + (1/3)*(C11*n1^2 + C55*n1^2 + C66*n1^2 + 2*C16*n1*n2 + 2*C26*n1*n2 + 2*C45*n1*n2 + ...
        C22*n2^2 + C44*n2^2 + C66*n2^2 + (C33 + C44 + C55)*n3^2)^2));
        
        
        
        DC22(t,p)=(1/3)*(n2^2 + (sqrt(3)*((-n2^2)*(C55*n1^2 + 2*C45*n1*n2 + C44*n2^2 + C33*n3^2) - n2^2*(C11*n1^2 + 2*C16*n1*n2 + C66*n2^2 + C55*n3^2) + ...
      (2/3)*n2^2*(C11*n1^2 + C55*n1^2 + C66*n1^2 + 2*C16*n1*n2 + 2*C26*n1*n2 + 2*C45*n1*n2 + C22*n2^2 + C44*n2^2 + C66*n2^2 + ...
        (C33 + C44 + C55)*n3^2)))/sqrt(((C36 + C45)*n1*n3 + (C23 + C44)*n2*n3)^2 + ((C13 + C55)*n1*n3 + (C36 + C45)*n2*n3)^2 - ...
      (C55*n1^2 + 2*C45*n1*n2 + C44*n2^2 + C33*n3^2)*(C66*n1^2 + 2*C26*n1*n2 + C22*n2^2 + C44*n3^2) + ...
      (C16*n1^2 + n2*((C12 + C66)*n1 + C26*n2) + C45*n3^2)^2 - (C55*n1^2 + 2*C45*n1*n2 + C44*n2^2 + C33*n3^2)*...
       (C11*n1^2 + 2*C16*n1*n2 + C66*n2^2 + C55*n3^2) - (C66*n1^2 + 2*C26*n1*n2 + C22*n2^2 + C44*n3^2)*...
       (C11*n1^2 + 2*C16*n1*n2 + C66*n2^2 + C55*n3^2) + (1/3)*(C11*n1^2 + C55*n1^2 + C66*n1^2 + 2*C16*n1*n2 + 2*C26*n1*n2 + 2*C45*n1*n2 + ...
         C22*n2^2 + C44*n2^2 + C66*n2^2 + (C33 + C44 + C55)*n3^2)^2));
         
         
         
         
         
         DC23(t,p)=(2*n2*n3*((C36 + C45)*n1*n3 + (C23 + C44)*n2*n3))/...
  (sqrt(3)*sqrt(((C36 + C45)*n1*n3 + (C23 + C44)*n2*n3)^2 + ((C13 + C55)*n1*n3 + (C36 + C45)*n2*n3)^2 - ...
     (C55*n1^2 + 2*C45*n1*n2 + C44*n2^2 + C33*n3^2)*(C66*n1^2 + 2*C26*n1*n2 + C22*n2^2 + C44*n3^2) + ...
     (C16*n1^2 + n2*((C12 + C66)*n1 + C26*n2) + C45*n3^2)^2 - (C55*n1^2 + 2*C45*n1*n2 + C44*n2^2 + C33*n3^2)*...
      (C11*n1^2 + 2*C16*n1*n2 + C66*n2^2 + C55*n3^2) - (C66*n1^2 + 2*C26*n1*n2 + C22*n2^2 + C44*n3^2)*...
      (C11*n1^2 + 2*C16*n1*n2 + C66*n2^2 + C55*n3^2) + (1/3)*(C11*n1^2 + C55*n1^2 + C66*n1^2 + 2*C16*n1*n2 + 2*C26*n1*n2 + 2*C45*n1*n2 + ...
        C22*n2^2 + C44*n2^2 + C66*n2^2 + (C33 + C44 + C55)*n3^2)^2));
        
        
        
        DC33(t,p)=(1/3)*(n3^2 + (sqrt(3)*((-n3^2)*(C66*n1^2 + 2*C26*n1*n2 + C22*n2^2 + C44*n3^2) - n3^2*(C11*n1^2 + 2*C16*n1*n2 + C66*n2^2 + C55*n3^2) + ...
      (2/3)*n3^2*(C11*n1^2 + C55*n1^2 + C66*n1^2 + 2*C16*n1*n2 + 2*C26*n1*n2 + 2*C45*n1*n2 + C22*n2^2 + C44*n2^2 + C66*n2^2 + ...
        (C33 + C44 + C55)*n3^2)))/sqrt(((C36 + C45)*n1*n3 + (C23 + C44)*n2*n3)^2 + ((C13 + C55)*n1*n3 + (C36 + C45)*n2*n3)^2 - ...
      (C55*n1^2 + 2*C45*n1*n2 + C44*n2^2 + C33*n3^2)*(C66*n1^2 + 2*C26*n1*n2 + C22*n2^2 + C44*n3^2) + ...
      (C16*n1^2 + n2*((C12 + C66)*n1 + C26*n2) + C45*n3^2)^2 - (C55*n1^2 + 2*C45*n1*n2 + C44*n2^2 + C33*n3^2)*...
       (C11*n1^2 + 2*C16*n1*n2 + C66*n2^2 + C55*n3^2) - (C66*n1^2 + 2*C26*n1*n2 + C22*n2^2 + C44*n3^2)*...
       (C11*n1^2 + 2*C16*n1*n2 + C66*n2^2 + C55*n3^2) + (1/3)*(C11*n1^2 + C55*n1^2 + C66*n1^2 + 2*C16*n1*n2 + 2*C26*n1*n2 + 2*C45*n1*n2 + ...
         C22*n2^2 + C44*n2^2 + C66*n2^2 + (C33 + C44 + C55)*n3^2)^2));
         
         
         
         
         
         DC44(t,p)=(1/3)*(n2^2 + n3^2 + (sqrt(3)*(2*n2*n3*((C36 + C45)*n1*n3 + (C23 + C44)*n2*n3) - n3^2*(C55*n1^2 + 2*C45*n1*n2 + C44*n2^2 + C33*n3^2) - ...
      n2^2*(C66*n1^2 + 2*C26*n1*n2 + C22*n2^2 + C44*n3^2) - n2^2*(C11*n1^2 + 2*C16*n1*n2 + C66*n2^2 + C55*n3^2) - ...
      n3^2*(C11*n1^2 + 2*C16*n1*n2 + C66*n2^2 + C55*n3^2) + (2/3)*(n2^2 + n3^2)*(C11*n1^2 + C55*n1^2 + C66*n1^2 + 2*C16*n1*n2 + 2*C26*n1*n2 + ...
        2*C45*n1*n2 + C22*n2^2 + C44*n2^2 + C66*n2^2 + (C33 + C44 + C55)*n3^2)))/...
    sqrt(((C36 + C45)*n1*n3 + (C23 + C44)*n2*n3)^2 + ((C13 + C55)*n1*n3 + (C36 + C45)*n2*n3)^2 - (C55*n1^2 + 2*C45*n1*n2 + C44*n2^2 + C33*n3^2)*...
       (C66*n1^2 + 2*C26*n1*n2 + C22*n2^2 + C44*n3^2) + (C16*n1^2 + n2*((C12 + C66)*n1 + C26*n2) + C45*n3^2)^2 - ...
      (C55*n1^2 + 2*C45*n1*n2 + C44*n2^2 + C33*n3^2)*(C11*n1^2 + 2*C16*n1*n2 + C66*n2^2 + C55*n3^2) - ...
      (C66*n1^2 + 2*C26*n1*n2 + C22*n2^2 + C44*n3^2)*(C11*n1^2 + 2*C16*n1*n2 + C66*n2^2 + C55*n3^2) + ...
      (1/3)*(C11*n1^2 + C55*n1^2 + C66*n1^2 + 2*C16*n1*n2 + 2*C26*n1*n2 + 2*C45*n1*n2 + C22*n2^2 + C44*n2^2 + C66*n2^2 + (C33 + C44 + C55)*n3^2)^...
        2));
    
    
    
    
    DC45(t,p)=(1/3)*(2*n1*n2 + (sqrt(3)*(2*n1*n3*((C36 + C45)*n1*n3 + (C23 + C44)*n2*n3) + 2*n2*n3*((C13 + C55)*n1*n3 + (C36 + C45)*n2*n3) - ...
      2*n1*n2*(C66*n1^2 + 2*C26*n1*n2 + C22*n2^2 + C44*n3^2) + 2*n3^2*(C16*n1^2 + n2*((C12 + C66)*n1 + C26*n2) + C45*n3^2) - ...
      2*n1*n2*(C11*n1^2 + 2*C16*n1*n2 + C66*n2^2 + C55*n3^2) + (4/3)*n1*n2*(C11*n1^2 + C55*n1^2 + C66*n1^2 + 2*C16*n1*n2 + 2*C26*n1*n2 + ...
        2*C45*n1*n2 + C22*n2^2 + C44*n2^2 + C66*n2^2 + (C33 + C44 + C55)*n3^2)))/...
    sqrt(((C36 + C45)*n1*n3 + (C23 + C44)*n2*n3)^2 + ((C13 + C55)*n1*n3 + (C36 + C45)*n2*n3)^2 - (C55*n1^2 + 2*C45*n1*n2 + C44*n2^2 + C33*n3^2)*...
       (C66*n1^2 + 2*C26*n1*n2 + C22*n2^2 + C44*n3^2) + (C16*n1^2 + n2*((C12 + C66)*n1 + C26*n2) + C45*n3^2)^2 - ...
      (C55*n1^2 + 2*C45*n1*n2 + C44*n2^2 + C33*n3^2)*(C11*n1^2 + 2*C16*n1*n2 + C66*n2^2 + C55*n3^2) - ...
      (C66*n1^2 + 2*C26*n1*n2 + C22*n2^2 + C44*n3^2)*(C11*n1^2 + 2*C16*n1*n2 + C66*n2^2 + C55*n3^2) + ...
      (1/3)*(C11*n1^2 + C55*n1^2 + C66*n1^2 + 2*C16*n1*n2 + 2*C26*n1*n2 + 2*C45*n1*n2 + C22*n2^2 + C44*n2^2 + C66*n2^2 + (C33 + C44 + C55)*n3^2)^...
        2));
    
    
    
    DC55(t,p)=(1/3)*(n1^2 + n3^2 + (sqrt(3)*(2*n1*n3*((C13 + C55)*n1*n3 + (C36 + C45)*n2*n3) - n3^2*(C55*n1^2 + 2*C45*n1*n2 + C44*n2^2 + C33*n3^2) - ...
      n1^2*(C66*n1^2 + 2*C26*n1*n2 + C22*n2^2 + C44*n3^2) - n3^2*(C66*n1^2 + 2*C26*n1*n2 + C22*n2^2 + C44*n3^2) - ...
      n1^2*(C11*n1^2 + 2*C16*n1*n2 + C66*n2^2 + C55*n3^2) + (2/3)*(n1^2 + n3^2)*(C11*n1^2 + C55*n1^2 + C66*n1^2 + 2*C16*n1*n2 + 2*C26*n1*n2 + ...
        2*C45*n1*n2 + C22*n2^2 + C44*n2^2 + C66*n2^2 + (C33 + C44 + C55)*n3^2)))/...
    sqrt(((C36 + C45)*n1*n3 + (C23 + C44)*n2*n3)^2 + ((C13 + C55)*n1*n3 + (C36 + C45)*n2*n3)^2 - (C55*n1^2 + 2*C45*n1*n2 + C44*n2^2 + C33*n3^2)*...
       (C66*n1^2 + 2*C26*n1*n2 + C22*n2^2 + C44*n3^2) + (C16*n1^2 + n2*((C12 + C66)*n1 + C26*n2) + C45*n3^2)^2 - ...
      (C55*n1^2 + 2*C45*n1*n2 + C44*n2^2 + C33*n3^2)*(C11*n1^2 + 2*C16*n1*n2 + C66*n2^2 + C55*n3^2) - ...
      (C66*n1^2 + 2*C26*n1*n2 + C22*n2^2 + C44*n3^2)*(C11*n1^2 + 2*C16*n1*n2 + C66*n2^2 + C55*n3^2) + ...
      (1/3)*(C11*n1^2 + C55*n1^2 + C66*n1^2 + 2*C16*n1*n2 + 2*C26*n1*n2 + 2*C45*n1*n2 + C22*n2^2 + C44*n2^2 + C66*n2^2 + (C33 + C44 + C55)*n3^2)^...
        2));
    
    
    
    
    DC66(t,p)=(1/3)*(n1^2 + n2^2 + (sqrt(3)*((-n1^2)*(C55*n1^2 + 2*C45*n1*n2 + C44*n2^2 + C33*n3^2) - n2^2*(C55*n1^2 + 2*C45*n1*n2 + C44*n2^2 + C33*n3^2) - ...
      n2^2*(C66*n1^2 + 2*C26*n1*n2 + C22*n2^2 + C44*n3^2) + 2*n1*n2*(C16*n1^2 + n2*((C12 + C66)*n1 + C26*n2) + C45*n3^2) - ...
      n1^2*(C11*n1^2 + 2*C16*n1*n2 + C66*n2^2 + C55*n3^2) + (2/3)*(n1^2 + n2^2)*(C11*n1^2 + C55*n1^2 + C66*n1^2 + 2*C16*n1*n2 + 2*C26*n1*n2 + ...
        2*C45*n1*n2 + C22*n2^2 + C44*n2^2 + C66*n2^2 + (C33 + C44 + C55)*n3^2)))/...
    sqrt(((C36 + C45)*n1*n3 + (C23 + C44)*n2*n3)^2 + ((C13 + C55)*n1*n3 + (C36 + C45)*n2*n3)^2 - (C55*n1^2 + 2*C45*n1*n2 + C44*n2^2 + C33*n3^2)*...
       (C66*n1^2 + 2*C26*n1*n2 + C22*n2^2 + C44*n3^2) + (C16*n1^2 + n2*((C12 + C66)*n1 + C26*n2) + C45*n3^2)^2 - ...
      (C55*n1^2 + 2*C45*n1*n2 + C44*n2^2 + C33*n3^2)*(C11*n1^2 + 2*C16*n1*n2 + C66*n2^2 + C55*n3^2) - ...
      (C66*n1^2 + 2*C26*n1*n2 + C22*n2^2 + C44*n3^2)*(C11*n1^2 + 2*C16*n1*n2 + C66*n2^2 + C55*n3^2) + ...
      (1/3)*(C11*n1^2 + C55*n1^2 + C66*n1^2 + 2*C16*n1*n2 + 2*C26*n1*n2 + 2*C45*n1*n2 + C22*n2^2 + C44*n2^2 + C66*n2^2 + (C33 + C44 + C55)*n3^2)^...
        2));
    
    
    
    
    DC16(t,p)=(1/3)*(2*n1*n2 + (sqrt(3)*(-2*n1*n2*(C55*n1^2 + 2*C45*n1*n2 + C44*n2^2 + C33*n3^2) - 2*n1*n2*(C66*n1^2 + 2*C26*n1*n2 + C22*n2^2 + C44*n3^2) + ...
      2*n1^2*(C16*n1^2 + n2*((C12 + C66)*n1 + C26*n2) + C45*n3^2) + (4/3)*n1*n2*(C11*n1^2 + C55*n1^2 + C66*n1^2 + 2*C16*n1*n2 + 2*C26*n1*n2 + ...
        2*C45*n1*n2 + C22*n2^2 + C44*n2^2 + C66*n2^2 + (C33 + C44 + C55)*n3^2)))/...
    sqrt(((C36 + C45)*n1*n3 + (C23 + C44)*n2*n3)^2 + ((C13 + C55)*n1*n3 + (C36 + C45)*n2*n3)^2 - (C55*n1^2 + 2*C45*n1*n2 + C44*n2^2 + C33*n3^2)*...
       (C66*n1^2 + 2*C26*n1*n2 + C22*n2^2 + C44*n3^2) + (C16*n1^2 + n2*((C12 + C66)*n1 + C26*n2) + C45*n3^2)^2 - ...
      (C55*n1^2 + 2*C45*n1*n2 + C44*n2^2 + C33*n3^2)*(C11*n1^2 + 2*C16*n1*n2 + C66*n2^2 + C55*n3^2) - ...
      (C66*n1^2 + 2*C26*n1*n2 + C22*n2^2 + C44*n3^2)*(C11*n1^2 + 2*C16*n1*n2 + C66*n2^2 + C55*n3^2) + ...
      (1/3)*(C11*n1^2 + C55*n1^2 + C66*n1^2 + 2*C16*n1*n2 + 2*C26*n1*n2 + 2*C45*n1*n2 + C22*n2^2 + C44*n2^2 + C66*n2^2 + (C33 + C44 + C55)*n3^2)^...
        2));
    
    
    
    
    
    DC26(t,p)=(1/3)*(2*n1*n2 + (sqrt(3)*(-2*n1*n2*(C55*n1^2 + 2*C45*n1*n2 + C44*n2^2 + C33*n3^2) + ...
      2*n2^2*(C16*n1^2 + n2*((C12 + C66)*n1 + C26*n2) + C45*n3^2) - 2*n1*n2*(C11*n1^2 + 2*C16*n1*n2 + C66*n2^2 + C55*n3^2) + ...
      (4/3)*n1*n2*(C11*n1^2 + C55*n1^2 + C66*n1^2 + 2*C16*n1*n2 + 2*C26*n1*n2 + 2*C45*n1*n2 + C22*n2^2 + C44*n2^2 + C66*n2^2 + ...
        (C33 + C44 + C55)*n3^2)))/sqrt(((C36 + C45)*n1*n3 + (C23 + C44)*n2*n3)^2 + ((C13 + C55)*n1*n3 + (C36 + C45)*n2*n3)^2 - ...
      (C55*n1^2 + 2*C45*n1*n2 + C44*n2^2 + C33*n3^2)*(C66*n1^2 + 2*C26*n1*n2 + C22*n2^2 + C44*n3^2) + ...
      (C16*n1^2 + n2*((C12 + C66)*n1 + C26*n2) + C45*n3^2)^2 - (C55*n1^2 + 2*C45*n1*n2 + C44*n2^2 + C33*n3^2)*...
       (C11*n1^2 + 2*C16*n1*n2 + C66*n2^2 + C55*n3^2) - (C66*n1^2 + 2*C26*n1*n2 + C22*n2^2 + C44*n3^2)*...
       (C11*n1^2 + 2*C16*n1*n2 + C66*n2^2 + C55*n3^2) + (1/3)*(C11*n1^2 + C55*n1^2 + C66*n1^2 + 2*C16*n1*n2 + 2*C26*n1*n2 + 2*C45*n1*n2 + ...
         C22*n2^2 + C44*n2^2 + C66*n2^2 + (C33 + C44 + C55)*n3^2)^2));
         
         
         
         
         
         DC36(t,p)=(2*n2*n3*(n1*n3*(C13 + C55) + n2*n3*(C36 + C45)) + 2*n1*n3*(n2*n3*(C23 + C44) + n1*n3*(C36 + C45)))/...
  (sqrt(3)*sqrt((1/3)*(C11*n1^2 + 2*C16*n1*n2 + C22*n2^2 + 2*C26*n1*n2 + n3^2*(C33 + C44 + C55) + C44*n2^2 + ...
        2*C45*n1*n2 + C55*n1^2 + C66*n1^2 + C66*n2^2)^2 - (C11*n1^2 + 2*C16*n1*n2 + C55*n3^2 + C66*n2^2)*...
      (C22*n2^2 + 2*C26*n1*n2 + C44*n3^2 + C66*n1^2) - (C11*n1^2 + 2*C16*n1*n2 + C55*n3^2 + C66*n2^2)*...
      (C33*n3^2 + C44*n2^2 + 2*C45*n1*n2 + C55*n1^2) + (n2*(n1*(C12 + C66) + C26*n2) + C16*n1^2 + C45*n3^2)^2 + ...
     (n1*n3*(C13 + C55) + n2*n3*(C36 + C45))^2 - (C22*n2^2 + 2*C26*n1*n2 + C44*n3^2 + C66*n1^2)*...
      (C33*n3^2 + C44*n2^2 + 2*C45*n1*n2 + C55*n1^2) + (n2*n3*(C23 + C44) + n1*n3*(C36 + C45))^2));
      
      
      
      
    end
end



figure (22)
subplot(3,4,1)
imagesc(DC11)
% xlabel('Incident angle (\mu\theta)','FontSize',10)
% ylabel('Azimuth (\mu\phi)','FontSize',10)
title ('\mu\alpha_{11}','FontWeight','bold','FontSize',14)



subplot(3,4,2)
imagesc(DC12)





subplot(3,4,3)
imagesc(DC13)
% xlabel('Incident angle (\mu\theta)','FontWeight','bold','FontSize',14)
% ylabel('Azimuth (\mu\phi)','FontWeight','bold','FontSize',14)
title ('\mu\alpha_{22}','FontWeight','bold','FontSize',14)






subplot(3,4,4)
imagesc(DC22)
% xlabel('Incident angle (\mu\theta)','FontSize',10)
% ylabel('Azimuth (\mu\phi)','FontSize',10)
title ('\mu\gamma_{11}','FontWeight','bold','FontSize',14)




subplot(3,4,5)
imagesc(DC23)

% xlabel('Incident angle (\mu\theta)','FontSize',10)
% ylabel('Azimuth (\mu\phi)','FontSize',10)
title ('\mu\gamma_{12}','FontWeight','bold','FontSize',14)



subplot(3,4,6)
imagesc(DC33)

% xlabel('Incident angle (\mu\theta)','FontWeight','bold','FontSize',14)
% ylabel('Azimuth (\mu\phi)','FontWeight','bold','FontSize',14)
title ('\mu\gamma_{22}','FontWeight','bold','FontSize',14)




subplot(3,4,7)
imagesc(DC44)

% xlabel('Incident angle (\mu\theta)','FontWeight','bold','FontSize',14)
% ylabel('Azimuth (\mu\phi)','FontWeight','bold','FontSize',14)
title ('\mu\beta_{1111}','FontWeight','bold','FontSize',14)



subplot(3,4,8)
imagesc(DC45)
% xlabel('Incident angle (\mu\theta)','FontWeight','bold','FontSize',14)
% ylabel('Azimuth (\mu\phi)','FontWeight','bold','FontSize',14)
title ('\mu\beta_{1112}','FontWeight','bold','FontSize',14)




subplot(3,4,9)
imagesc(DC55)
% xlabel('Incident angle (\mu\theta)','FontWeight','bold','FontSize',14)
% ylabel('Azimuth (\mu\phi)','FontWeight','bold','FontSize',14)
title ('\mu\beta_{1122}','FontWeight','bold','FontSize',14)





subplot(3,4,10)
imagesc(DC66)
% xlabel('Incident angle (\mu\theta)','FontWeight','bold','FontSize',14)
% ylabel('Azimuth (\mu\phi)','FontWeight','bold','FontSize',14)
title ('\mu\beta_{1222}','FontWeight','bold','FontSize',14)






subplot(3,4,11)
imagesc(DC16)
% xlabel('Incident angle (\mu\theta)','FontWeight','bold','FontSize',14)
% ylabel('Azimuth (\mu\phi)','FontWeight','bold','FontSize',14)
title ('\mu\beta_{2222}','FontWeight','bold','FontSize',14)




subplot(3,4,12)
imagesc(DC26)
% xlabel('Incident angle (\mu\theta)','FontWeight','bold','FontSize',14)
% ylabel('Azimuth (\mu\phi)','FontWeight','bold','FontSize',14)
title ('\mu\beta_{2222}','FontWeight','bold','FontSize',14)


figure(2)
imagesc(rV2)

